package com.oa.biz.impl;

import com.oa.biz.ClaimVoucherBiz;
import com.oa.dao.ClaimVoucherDao;
import com.oa.dao.ClaimVoucherItemDao;
import com.oa.dao.DealRecordDao;
import com.oa.dao.EmployeeDao;
import com.oa.entity.ClaimVoucher;
import com.oa.entity.ClaimVoucherItem;
import com.oa.entity.DealRecord;
import com.oa.entity.Employee;
import com.oa.global.Contant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service("claimVoucherBiz")
public class ClaimVoucherBizImpl implements ClaimVoucherBiz {
    @Qualifier("claimVoucherDao")
    @Autowired
    private ClaimVoucherDao claimVoucherDao;

    @Qualifier("claimVoucherItemDao")
    @Autowired
    private ClaimVoucherItemDao claimVoucherItemDao;

    @Qualifier("dealRecordDao")
    @Autowired
    private DealRecordDao dealRecordDao;

    @Qualifier("employeeDao")
    @Autowired
    private EmployeeDao employeeDao;

    public void save(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items) {
        claimVoucher.setCreateTime(new Date());
        claimVoucher.setNextDealSn(claimVoucher.getCreateSn());
        claimVoucher.setStatus(Contant.CLAIMVOUCHER_CREATED);
        claimVoucherDao.insert(claimVoucher);

        for(ClaimVoucherItem item:items){
            item.setClaimVoucherId(claimVoucher.getId());
            claimVoucherItemDao.insert(item);
        }
    }

    public ClaimVoucher get(int id) {
        return claimVoucherDao.select(id);
    }

    public List<ClaimVoucherItem> getItems(int cvid) {
        return claimVoucherItemDao.selectByClaimVoucher(cvid);
    }

    public List<DealRecord> getRecords(int cvid) {
        return dealRecordDao.selectByClaimVoucher(cvid);
    }

    public List<ClaimVoucher> getForSelf(String sn) {
        return claimVoucherDao.selectByCreateSn(sn);
    }

    public List<ClaimVoucher> getForDeal(String sn) {
        return claimVoucherDao.selectByNextDealSn(sn);
    }

    public void update(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items) {
        claimVoucher.setNextDealSn(claimVoucher.getCreateSn());
        claimVoucher.setStatus(Contant.CLAIMVOUCHER_CREATED);
        claimVoucherDao.update(claimVoucher);

        List<ClaimVoucherItem> olds = claimVoucherItemDao.selectByClaimVoucher(claimVoucher.getId());   //获取数据库已有的条目集合
        //删除我不要的条目
        for(ClaimVoucherItem old : olds){     //迭代其集合
            boolean isHave = false;
            for(ClaimVoucherItem item : items){       //寻找条目集合是否存在
                if(item.getId() == old.getId()){
                    isHave = true;
                    break;
                }
            }
            if(!isHave){
                claimVoucherItemDao.delete(old.getId());
            }
        }
        for(ClaimVoucherItem item : items){
            item.setClaimVoucherId(claimVoucher.getId());
            if(item.getId() != null && item.getId() > 0){
                //更新已经有了的条目
                claimVoucherItemDao.update(item);
            }else{
                //插入之前不存在的新条目
                claimVoucherItemDao.insert(item);
            }
        }
    }

    public void submit(int id) {
        ClaimVoucher claimVoucher = claimVoucherDao.select(id);
        Employee employee = employeeDao.select(claimVoucher.getCreateSn());

        //报销单状态更新
        claimVoucher.setStatus(Contant.CLAIMVOUCHER_SUBMIT);
        claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(employee.getDepartmentSn(),Contant.POST_FM).get(0).getSn());
        claimVoucherDao.update(claimVoucher);

        DealRecord dealRecord = new DealRecord();
        dealRecord.setDealWay(Contant.DEAL_SUBMIT);
        dealRecord.setDealSn(employee.getSn());
        dealRecord.setClaimVoucherId(id);
        dealRecord.setDealResult(Contant.CLAIMVOUCHER_SUBMIT);
        dealRecord.setDealTime(new Date());
        dealRecord.setComment("无");
        dealRecordDao.insert(dealRecord);
    }

    public void deal(DealRecord dealRecord) {
        ClaimVoucher claimVoucher = claimVoucherDao.select(dealRecord.getClaimVoucherId());
        Employee employee = employeeDao.select(dealRecord.getDealSn());
        //设置处理时间
        dealRecord.setDealTime(new Date());

        if(dealRecord.getDealWay().equals(Contant.DEAL_PASS)){
            //金额小于5000或者处理报销单的人是总经理就不需要复审
            if(claimVoucher.getTotalAmount()<=Contant.LIMIT_CHECK || employee.getPost().equals(Contant.POST_GM)){
                //修改报销单状态:已审核
                claimVoucher.setStatus(Contant.CLAIMVOUCHER_APPROVED);
                //设置待处理人为财务
                claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(null,Contant.POST_CASHIER).get(0).getSn());
                //设置处理结果
                dealRecord.setDealResult(Contant.CLAIMVOUCHER_APPROVED);
            }else{      //需要复审的
                claimVoucher.setStatus(Contant.CLAIMVOUCHER_RECHECK);
                claimVoucher.setNextDealSn(employeeDao.selectByDepartmentAndPost(null,Contant.POST_GM).get(0).getSn());
                dealRecord.setDealResult(Contant.CLAIMVOUCHER_RECHECK);
            }
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_BACK)){        //打回的操作
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_BACK);
            claimVoucher.setNextDealSn(claimVoucher.getCreateSn());
            dealRecord.setDealResult(Contant.CLAIMVOUCHER_BACK);
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_REJECT)){      //拒绝的操作
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_TERMINATED);
            claimVoucher.setNextDealSn(null);
            dealRecord.setDealResult(Contant.CLAIMVOUCHER_TERMINATED);
        }else if(dealRecord.getDealWay().equals(Contant.DEAL_PAID)){        //打款的操作
            claimVoucher.setStatus(Contant.CLAIMVOUCHER_PAID);
            claimVoucher.setNextDealSn(null);
            dealRecord.setDealResult(Contant.CLAIMVOUCHER_PAID);
        }
        //报销单更新
        claimVoucherDao.update(claimVoucher);
        //审核记录插入
        dealRecordDao.insert(dealRecord);
    }

}

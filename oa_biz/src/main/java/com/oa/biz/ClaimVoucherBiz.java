package com.oa.biz;

import com.oa.entity.ClaimVoucher;
import com.oa.entity.ClaimVoucherItem;
import com.oa.entity.DealRecord;
import com.oa.entity.ClaimVoucher;

import java.util.List;

public interface ClaimVoucherBiz {
    //保存报销单
    void save(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items);
    //获取报销单对象
    ClaimVoucher get(int id);
    //获取报销单条目
    List<ClaimVoucherItem> getItems(int cvid);
    //审核记录
    List<DealRecord> getRecords(int cvid);

    //获取个人报销单
    List<ClaimVoucher> getForSelf(String sn);
    //获取待处理报销单
    List<ClaimVoucher> getForDeal(String sn);

    //修改报销单
    void update(ClaimVoucher claimVoucher, List<ClaimVoucherItem> items);

    //提交报销单
    void submit(int id);

    //审核报销单
    void deal(DealRecord dealRecord);
}

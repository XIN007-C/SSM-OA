package com.oa.dto;

import com.oa.entity.ClaimVoucher;
import com.oa.entity.ClaimVoucherItem;

import java.util.List;

public class ClaimVoucherInfo {
    //用一下的方式获取用户提交的信息
    private ClaimVoucher claimVoucher;      //报销单对象
    private List<ClaimVoucherItem> items;       //items集合

    public ClaimVoucher getClaimVoucher() {
        return claimVoucher;
    }

    public void setClaimVoucher(ClaimVoucher claimVoucher) {
        this.claimVoucher = claimVoucher;
    }

    public List<ClaimVoucherItem> getItems() {
        return items;
    }

    public void setItems(List<ClaimVoucherItem> items) {
        this.items = items;
    }
}

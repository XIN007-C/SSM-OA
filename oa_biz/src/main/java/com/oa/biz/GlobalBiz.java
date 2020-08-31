package com.oa.biz;

import com.oa.entity.Employee;

public interface GlobalBiz {
    Employee login(String sn, String password);
    void changePassword(Employee employee);
}

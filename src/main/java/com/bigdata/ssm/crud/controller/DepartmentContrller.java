package com.bigdata.ssm.crud.controller;

import com.bigdata.ssm.crud.bean.Department;
import com.bigdata.ssm.crud.bean.Msg;
import com.bigdata.ssm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentContrller {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 获取部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}

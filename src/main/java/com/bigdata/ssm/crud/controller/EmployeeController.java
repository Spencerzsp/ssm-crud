package com.bigdata.ssm.crud.controller;

import com.bigdata.ssm.crud.bean.Employee;
import com.bigdata.ssm.crud.bean.Msg;
import com.bigdata.ssm.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工CRUD请求
 * @ Author: zsp
 * @ Date: 2020/2/14 0014 下午 3:22
 * @ Version
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 以json格式返回数据
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        //引入PageHelper分页插件
        //在查询之前，只需要调用,传入页码以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
//
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，li连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(emps, 5);

        return Msg.success().add("pageInfo", page);
    }

    /**
     * 以页面形式返回数据
     * 查询员工数据(分页查询)
     * @return
     */
    @RequestMapping("/emp")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                          Model model){

        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前，只需要调用,传入页码以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
//
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据，li连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }
}

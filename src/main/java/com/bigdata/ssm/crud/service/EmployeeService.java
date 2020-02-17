package com.bigdata.ssm.crud.service;

import com.bigdata.ssm.crud.bean.Employee;
import com.bigdata.ssm.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ Author: zsp
 * @ Date: 2020/2/14 0014 下午 3:27
 * @ Version
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);

    }
}

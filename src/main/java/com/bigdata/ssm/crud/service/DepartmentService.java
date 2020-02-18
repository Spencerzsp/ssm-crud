package com.bigdata.ssm.crud.service;

import com.bigdata.ssm.crud.bean.Department;
import com.bigdata.ssm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}

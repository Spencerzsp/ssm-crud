package com.bigdata.ssm.crud.test;

import com.bigdata.ssm.crud.bean.Department;
import com.bigdata.ssm.crud.dao.DepartmentMapper;
import com.bigdata.ssm.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层的工作
 * @ Author: zsp
 * @ Date: 2020/2/13 0013 下午 7:05
 * @ Version
 * 推荐spring的项目使用spring的单元测试，可以自动注入我们需要的组件
 * 1.导入spring test的模块
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.直接autowired要使用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    //测试DepartmentMapper
    @Test
    public void testCRUD(){

//        //1.创建spring ioc容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//
//        //2.从容器中获取mapper
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
//        System.out.println(bean);

        departmentMapper.insertSelective(new Department(null, "开发部"));
        departmentMapper.insertSelective(new Department(null, "测试部"));
        System.out.println(employeeMapper);

//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@bigdata.com", 2));

        //批量插入多个员工，可以使用执行批量操作的sqlSession

//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
//            mapper.insertSelective(new Employee(null, uid, "M", uid + "@bigdata.com", 1));
//        }

        System.out.println("批量执行完成---");

    }
}

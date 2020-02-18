<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/14 0014
  Time: 下午 3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <%--表头--%>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <%--表内容--%>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前页,总共页,总共条记录
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
           <%--1页面加载完成以后，直接发送ajax请求，要到分页数据--%>
            <script type="application/javascript">
                $(function () {
                   $.ajax({
                       url: "${APP_PATH}/emps",
                       data: "pn=1",
                       type: "GET",
                       success: function (result) {
                           // 检测是否请求成功，f12浏览器查看
                           //console.log(result);
                           //1、解析并显示员工数据
                           build_emps_table(result);
                           //2、解析并显示分页信息
                       }
                   });
                });

                //构建表格信息
                function build_emps_table(result) {
                    var emps = result.extend.pageInfo.list;
                    $.each(emps, function (index, item) {
//                        alert(item.empName);
                        var empIdTd = $("<td></td>").append(item.empId);
                        var empNameTd = $("<td></td>").append(item.empName);
                        var gender = $("<td></td>").append(item.gender == "M" ? "男" : "女");
                        var email = $("<td></td>").append(item.email);
                        var deptNameTd = $("<td></td>").append(item.department.deptName);
                        /**
                         * <button class="btn btn-primary btn-sm">
                         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                         */
                        var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                            .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                        var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                            .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                        var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                        $("<tr></tr>").append(empIdTd)
                            .append(empNameTd)
                            .append(gender)
                            .append(email)
                            .append(deptNameTd)
//                            .append(editBtn)
//                            .append(delBtn)
                            .append(btnTd)
                            .appendTo("#emps_table tbody")
                    });
                }
                //构建分页导航信息
                function build_page_nav() {

                }
            </script>
        </div>
    </div>
</div>

</body>
</html>

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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@bigdata.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

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
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
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
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
           <%--1页面加载完成以后，直接发送ajax请求，要到分页数据--%>
            <script type="application/javascript">
                $(function () {

                    //去首页
                    to_page(1)

                });

                function to_page(pn) {
                    $.ajax({
                        url: "${APP_PATH}/emps",
                        data: "pn=" + pn,
                        type: "GET",
                        success: function (result) {
                            // 检测是否请求成功，f12浏览器查看
                            //console.log(result);
                            //1、解析并显示员工数据
                            build_emps_table(result);
                            //2、解析并显示分页信息
                            build_page_info(result);
                            //3、解析显示分页条数据
                            build_page_nav(result);
                        }
                    });
                }

                //构建表格信息
                function build_emps_table(result) {

                    //每次构建之前，需要对表格进行清空
                    $("#emps_table tbody").empty()

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



                //解析显示分页信息
                function build_page_info(result) {

                    $("#page_info_area").empty()

                    $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum
                        + "页,总共" + result.extend.pageInfo.pages
                        + "页,总共" + result.extend.pageInfo.total + "条记录")

                }
                //构建分页导航信息
                function build_page_nav(result) {

                    $("#page_nav_area").empty()
                    //构建父元素ul
                    var ul = $("<ul></ul>").addClass("pagination")

                    //构建元素
                    var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"))
                    var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"))

                    if(result.extend.pageInfo.hasPreviousPage == false){
                        firstPageLi.addClass("disabled")
                        prePageLi.addClass("disabled")
                    } else {
                        //为元素添加点击事件
                        firstPageLi.click(function () {
                            to_page(1)
                        });
                        prePageLi.click(function () {
                            to_page(result.extend.pageInfo.pageNum - 1)
                        });
                    }

                    var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"))
                    var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"))

                    if(result.extend.pageInfo.hasNextPage == false){
                        nextPageLi.addClass("disabled")
                        lastPageLi.addClass("disabled")
                    } else {
                        nextPageLi.click(function () {
                            to_page(result.extend.pageInfo.pageNum + 1)
                        });
                        lastPageLi.click(function () {
                            to_page(result.extend.pageInfo.pages)
                        })
                    }

                    //添加首页和前一页
                    ul.append(firstPageLi).append(prePageLi)

                    $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                        var numLi = $("<li></li>").append($("<a></a>").append(item))

                        //如果遍历的页码刚好是当前页码，就显示active(高亮)
                        if(result.extend.pageInfo.pageNum == item){
                            numLi.addClass("active")
                        }
                        numLi.click(function () {
                            to_page(item)
                        });
                        ul.append(numLi)
                    })

                    ul.append(nextPageLi).append(lastPageLi)

                    var navEli = $("<nav></nav>").append(ul)

                    navEli.appendTo("#page_nav_area")


                }

                //点击新增按钮弹出模态框
                $("#emp_add_model_btn").click(function () {

                    //弹出模态框之前，发送ajax请求，去数据库查出部门信息，显示在下拉列表中
                    //可以单独抽取成一个方法，在此处调用
                    getDeps()

                    //弹出模态框
                    $("#empAddModel").modal({
                        //设置弹出模态框之后页面背景内容不会消失
                        backdrop: "static"
                    })
                })

                //查出所有的部门信息，并显示在下拉列表中
                function getDeps() {
                    $.ajax({
                        //服务器应该有一个这样对应的方法
                        url: "${APP_PATH}/depts",
                        type: "GET",
                        success: function (result) {
                            //{"code":100,"msg":"处理成功！","extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                            //console.log(result)
                            //dept_add_select
                            $.each(result.extend.depts, function (index, item) {
                                var optionEli = $("<option></option>")
                                    .append(item.deptName)
                                    .attr("value", item.deptId)

                                optionEli.appendTo("#dept_add_select")
                            })
                        }
                    })
                }

            </script>
        </div>
    </div>
</div>

</body>
</html>

<%-- 
    Document   : add_category
    Created on : 14-Sep-2022, 3:45:34 PM
    Author     : mayur
--%>

<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 100%, 68% 96%, 32% 100%, 0 96%);
            }
            .scrollable{
                height: 600px;
                width: 600px;
                overflow: scroll;
            }
        </style>        

    </head>
    <body>
        <%
            Admin admin = (Admin) session.getAttribute("currentUser");
            if (admin == null) {
                response.sendRedirect("ad_login_page.jsp");
            }

        %>

        <!--navbar-->
        <%--<%@include file="admin_normal_navbar.jsp" %>--%>

        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="admin_login.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="admin_login.jsp"><span class="fa fa-bell-o"></span>Enter Gallary <span class="sr-only">(current)</span></a>
                    </li>


                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-card"></span>Contact</a>
                    </li>
                    <li class="nav-item">

                    <li class="nav-item">
                        <a class="nav-link" href="add_category.jsp"><span class="fa fa-check-square-o"></span>Add Categories</a>
                    </li>
                </ul>

                <ul class="navbar-nav mr-right">

                    <li class="nav-item">
                        <a class="nav-link" href="admin_manage_post.jsp"><span class="fa fa-user-circle-o"></span><%= admin.getEmail()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminLogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--end of navbar-->





        <main class="d-flex align-items-center primary-background" style="height: 70vh;">
            <div class="container">
                <div class="row">

                    <!--delete category-->
                    <div class="col-md-4">
                        <div class="scrollable">

                            <table class="table">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">Category Id</th>
                                        <th scope="col">Cat Name</th>
                                        <th scope="col">Description</th>
                                        <th scope="col">Operation</th>
                                    </tr>
                                </thead>
                                <%

                                    PostDao d = new PostDao(ConnectionProvider.getConnection());

                                    List<Category> list = null;

                                    list = d.getAllCategories();

                                    for (Category categ : list) {
                                %>
                                <tbody>
                                    <tr class="text-white">
                                        <th scope="row"><%= categ.getCid()%></th>
                                        <td><%= categ.getName()%></td>
                                        <td><%= categ.getDescription()%></td>

                                        <td><button onclick="deleteCategory(<%= categ.getCid()%>)" class="btn btn-outline-light btn-lg btn-sm"><span class="fa fa-times-circle"></span>Delete</button>
                                        </td>
                                    </tr>
                                </tbody>
                                <%
                                    }
                                %>
                            </table>
                        </div>


                    </div>


                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-plus fa-3x"></span>
                                <br>
                                <p>Add Category Here</p>

                            </div>


                            <div class="card-body">
                                <form id="addcategory" method="post" action="AddCategoryServlet">
                                    <div class="form-group">
                                        <label>Category Name</label>
                                        <input name="categ" type="text" class="form-control" placeholder="Enter Category">
                                    </div>
                                    <div class="form-group">
                                        <label>Enter description</label>
                                        <textarea  name="catdesc" rows="3" class="form-control" placeholder="Description"></textarea>

                                    </div>
                                    <div class="container text-center"><!-- comment -->
                                        <button id="submit" type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>



        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>


<!--        <script>
                    $(document).ready(function () {
                    $("#addcategory").on("submit", function (event) {
                    event.preventDefault();
                            console.log("you have clicked submit");
                            const formd = new FormData(this);
                                    console.log(formd);
                                    $.ajax({
                                    url: "AddCategoryServlet",
                                            type: 'POST',
                                            data: formd,
                                            success: function (data, textStatus, jqXHR) {
                                            console.log(data);
                                            
                                            },
//                                            error: function (jqXHR, textStatus, errorThrown) {
//                                            swal("error", "somethhing went wrong", "error");
//                                            },
                                            processData: false,
                                            contentType: false

                                    });
                            });
                    });
        </script>-->



        <script>
                    function deleteCategory(cid)
                    {
                    console.log(cid)

                            $.ajax({
                            url: "delCategoryServlet",
                                    data: {categId : cid},
                                    success: function (data, textStatus, jqXHR)
                                    {

                                    console.log(data);
                                            if (data.trim() == 'done')
                                    {
                                    swal("Deleted Successfully...", "success").then((value) => {
                                    location.reload();
                                    });
                                    } else
                                    {
                                    swal("Error!", "Something went wrong try again!", "error");
                                    }
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                    //                        error
                                    swal("Error!", "Something went wrong try again!", "error");
                                    }
                            });
                    }
        </script>

    </body>
</html>

<%-- 
    Document   : my_post
    Created on : 12-Sep-2022, 11:36:31 PM
    Author     : mayur
--%>

<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

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
                clip-path: polygon(0 0, 100% 0, 100% 100%, 68% 93%, 32% 100%, 0 92%);
            }
            .card-ht{
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 4;
                -webkit-box-orient: vertical;
            }
            body{
                background: url(img/bgimg.jpg);
                background-size: cover;
                background-attachment: fixed;
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
                    <li class="nav-item">
                        <a class="nav-link" href="admin_all_users.jsp"><span class="fa fa-address-card"></span>Our Users</a>
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
        <!--main body of the page-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col">
                        <!--posts-->

                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin" ></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>

                        <div class="container-fluid" id="post-container">

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

        <script>
            function deletebyid(pid)
            {
                console.log(pid)

                $.ajax({
                    url: "deletePostServlet",
                    data: {postId: pid},
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

        <script>
            $(document).ready(function () {

                let editStatus = false;

                $('#edit-profile-button').click(function () {
                    if (editStatus === false)
                    {
                        $('#profile-details').hide();
                        $('#profile-edit').show();
                        editStatus = true;
                        $(this).text("Back");
                    } else
                    {
                        $('#profile-details').show();
                        $('#profile-edit').hide();
                        editStatus = false;
                        $(this).text("Edit");

                    }


                });

            });
        </script>

        <!--now add post js-->
        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
//                 this code gets called when from is submitted
                    event.preventDefault();
                    console.log("you have clicked on submit");
                    let form = new FormData(this);

//                now requesting to server

                    $.ajax({
                        url: "AddPostServlet",
                        type: 'post',
                        data: form,

                        success: function (data, textStatus, jqXHR) {
//                        success
                            console.log(data);
                            if (data.trim() === 'done')
                            {
                                swal("Good job!", "Saved Successfully", "success");
                            } else
                            {
                                swal("Error!", "Something went wrong try again!", "error");

                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
//                        error
                            swal("Error!", "Something went wrong try again!", "error");

                        },
                        processData: false,
                        contentType: false

                    });

                });
            });

        </script>

        <!--loading post using ajax-->
        <script>


            $(document).ready(function (e) {
                $('#loader').show();
                $('#post-container').hide();

                const uidd =<%=admin.getId()%>

                $.ajax({
                    url: "load_all_post.jsp",
                    data: {uid: uidd},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $('#loader').hide();
                        $('#post-container').show();
                        $('#post-container').html(data);

                    }
                });

            });
        </script>

    </body>
</html>

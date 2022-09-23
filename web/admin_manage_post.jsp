

<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    Admin admin = (Admin) session.getAttribute("currentUser");
    if (admin == null) {
        response.sendRedirect("ad_login_page.jsp");
    }

%>
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
                clip-path: polygon(0 0, 100% 0, 100% 100%, 68% 93%, 32% 100%, 0 92%);
            }
            body{
                background: url(img/bgimg.jpg);
                background-size: cover;
                background-attachment: fixed;

            }
        </style>
    </head>
    <body>
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
<!--                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span>Do Post</a>
                    </li>-->
<!--                    <li class="nav-item">
                        <a class="nav-link" href="my_post.jsp"><span class="fa fa-asterisk"></span>My Posts</a>
                    </li>-->
                </ul>

                <ul class="navbar-nav mr-right">

                    <li class="nav-item">
                        <a class="nav-link" href="admin_manage_post.jsp" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle-o"></span><%= admin.getEmail()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="AdminLogoutServlet"><span class="fa fa-user-plus"></span>Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--end of navbar-->

        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>

        <div class="alert <%=m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>


        <!--main body of the page-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">
                                All Posts 
                            </a>
                            <!--categories-->
                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());

                                ArrayList<Category> list1 = d.getAllCategories();

                                for (Category cc : list1) {
                            %>
                            <a href="#" onclick="getPosts(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName()%></a>

                            <%
                                }

                            %>
                        </div>
                    </div>

                    <!--second col-->
                    <div class="col-md-8">
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



        <!--end of main body of thhe page-->


        <!--end add post modal-->

        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>



        <!--loading post using ajax-->
        <script>

            function getPosts(catId, temp) {
                $('#loader').show();
                $('#post-container').hide();

                $('.c-link').removeClass('active');

                $.ajax({
                    url: "load_posts_admin.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $('#loader').hide();
                        $('#post-container').show();
                        $('#post-container').html(data);
                        $(temp).addClass('active');

                    }
                });
            }

            $(document).ready(function (e) {
                let allPostRef = $('.c-link')[0];
                getPosts(0, allPostRef);
            });
        </script>

        
    </body>
</html>

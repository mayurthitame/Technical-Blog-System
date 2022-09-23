<%-- 
    Document   : show_blog_page
    Created on : 12-Sep-2022, 2:26:30 PM
    Author     : mayur
--%>
<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
    Admin admin = (Admin) session.getAttribute("currentUser");
    if (admin == null) {
        response.sendRedirect("ad_login_page.jsp");
    }

%>

<%    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%>|| Techblog</title>
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(0 0, 100% 0, 100% 100%, 68% 93%, 32% 100%, 0 92%);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border:1px solid #e2e2e2;
                padding-top: 15px;

            }
            body{
                background: url(img/bgimg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            /*            .custom{
                            display: inline-flex;
                            flex-wrap: nowrap;  
                        }*/
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


    <!--main content of body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header primary-background text-white">
                        <h4 class="post-title"><%= p.getpTitle()%></h4>

                    </div>
                    <div class="card-body">
                        <div class="text-center">
                            <img class="card-img-top my-2 show-img" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">

                        </div>

                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <%
                                    UserDao ud = new UserDao(ConnectionProvider.getConnection());

                                %>
                                <p class="post-user-info"><a href="#!"> <%= ud.getUserByUserId(p.getUserId()).getName()%></a> has posted :</p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                            </div>
                        </div>

                        <p class="post-content"><%=p.getpContent()%></p>
                        <br><!-- comment -->
                        <br><!-- comment -->
                        <div class="ppst-code">
                            <pre><%= p.getpCode()%></pre>
                        </div>
                    </div>
                    <div class="card-footer primary-background">
                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>
                        <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                        <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
                    </div>

<!--                    <div class="card-footer">
                        <div class="fb-comments" data-href="http://localhost:8080/TechBlog/show_blog_page.jsp?post_id=<%= p.getPid()%>" data-width="" data-numposts="5"></div>

                    </div>-->
                </div>

            </div>

        </div>

    </div>
    <!--end of main content of body-->


    <!--javascripts-->
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="js/myjs.js" type="text/javascript"></script>


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

</body>
</html>

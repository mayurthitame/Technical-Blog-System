<%-- 
    Document   : index
    Created on : 09-Sep-2022, 8:38:31 PM
    Author     : mayur
--%>

<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.*" %>
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

        </style>
    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>

        <!--Banner-->
        <div class="banner-background">
            <div class="container-fluid p-0 m-0">
                <div class="jumbotron primary-background text-white"> 
                    <div class="container">
                        <h3 class="display-3">Welcome to TechBlog</h3>
                        <h3>Tech Blog</h3><!-- comment -->
                        <p>Welcome to technical blog,world of technology!
                            A programming language is any set of rules that converts strings, or graphical program elements in the case of visual programming languages, to various kinds of machine code output.[citation needed] Programming languages are one kind of computer language, and are used in computer programming to implement algorithms.
                        </p>
                        <p>Most programming languages consist of instructions for computers. There are programmable machines that use a set of specific instructions, rather than general programming languages. </p>
                        <a href="profile.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span>Start! its Free</a>
                        <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle-o fa-spin"></span>Login</a>

                    </div>
                </div>
            </div>
        </div>
        <!--cards-->
        <div class="container">
            <div class="row mb-2">
                <%
                    PostDao p = new PostDao(ConnectionProvider.getConnection());
                    List<Post> list = p.getAllPosts();
                    for (Post pp : list) {
                %>

                <div class="col-md-4">
                    <div class="card baseBlock text-center">
                        <div class="card-body">
                            <h5 class="card-title"><%= pp.getpTitle()%></h5>
                            <p class="card-text card-ht"><%= pp.getpContent()%></p>
                            <a href="show_blog_page.jsp?post_id=<%=pp.getPid() %>" class="btn primary-background text-white">Read More</a>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>


        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        
<!--                <script>
            $(document).ready(function(e) {
                $('#user-nav').show();
                $('#admin-nav').hide();
            });
            
            
        </script>-->
        
        
    </body>
</html>

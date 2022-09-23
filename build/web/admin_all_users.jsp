<%-- 
    Document   : admin_all_users
    Created on : 15-Sep-2022, 11:29:58 AM
    Author     : mayur
--%>

<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.User"%>
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
        <%@include file="admin_normal_navbar.jsp" %>
        
        
            <%
            Admin adm = (Admin) session.getAttribute("currentUser");
            if (adm == null) {
                response.sendRedirect("ad_login_page.jsp");
            }

        %>
        <div class="container primary-background mt-4">

            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">User Id</th>
                        <th scope="col">Name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Gender</th>
                        <th scope="col">About</th>
                        <th scope="col">Reg Date</th>
                        <th scope="col">Manage Users</th>
                    </tr>
                </thead>


                <%

                    UserDao d = new UserDao(ConnectionProvider.getConnection());

                    List<User> list = null;     

                    list = d.getAllUsers();

                    for (User user : list) {
                %>



                <tbody>
                    <tr class="text-white">
                        <th scope="row"><%= user.getId()%></th>
                        <td><%= user.getName()%></td>
                        <td><%= user.getEmail()%></td>
                        <td><%= user.getGender()%></td>
                        <td><%= user.getAbout()%></td>
                        <td><%= user.getDateTime()%></td>
                        <td><button onclick="deleteUser(<%= user.getId() %>)" class="btn btn-outline-light btn-lg btn-sm"><span class="fa fa-times-circle"></span>Delete</button>
                        </td>
                    </tr>
                </tbody>

                <%
                    }
                %>

            </table>

        </div>

        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

          <script>
                function deleteUser(uid)
                {
                    console.log(uid)

                    $.ajax({
                        url: "deleteUserServlet",
                        data: {userId: uid},
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

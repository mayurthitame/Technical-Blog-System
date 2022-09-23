
<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.nio.channels.ConnectionPendingException"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<head>

</head>

<div class="container">
    <div class="row">
        <%
            PostDao p = new PostDao(ConnectionProvider.getConnection());
            List<Post> list2 = p.getAllPosts();

            if (list2.isEmpty()) {
                out.println("<h3 class='display-4 text-center'>No posts in this category..!!</h3>");
                return;
            }
            for (Post pp : list2) {
        %>

        <div class="col-md-4 text-center">
            <div class="card my-4"  style="height: 400px">

                <div class="card-header">  
                    <h5 class="card-title"><%= pp.getpTitle()%></h5>
            </div>
                     <div class="card-body">
                    <p class="card-text card-ht"><%= pp.getpContent()%></p>
                </div>
                <div class="card-footer primary-background">
                    <a href="show_blog_admin.jsp?post_id=<%=pp.getPid()%>" class="btn btn-outline-light primary-background text-white">Read More</a>
                    <button  onclick="deletebyid(<%= pp.getPid()%>)" class="btn btn-danger text-white">Delete</button>
                </div>

            </div>
        </div>

        <%
            }
        %>

    </div>
</div>
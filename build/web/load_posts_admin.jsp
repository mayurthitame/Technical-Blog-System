<%@page import="com.tech.blog.entities.Admin"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.nio.channels.ConnectionPendingException"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<html>
<head>

    <script>

    </script>
</head>
<body>
<div class="row">

    <%
        Admin uuu = (Admin) session.getAttribute("currentUser");

        Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {

            posts = d.getAllPosts();

        } else {

            posts = d.getPostByCatId(cid);

        }
        if (posts.size() == 0) {
            out.println("<h3 class='display-4 text-center'>No posts in this category..!!</h3>");
            return;
        }
        for (Post p : posts) {
    %>
    <div class="col-md-6 mt-2">
        <div class="card baseBlock">
            <!--<div class="embed-responsive embed-responsive-1by1">-->
                <img class="card-img-top img-fluid img-fix" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
            <!--</div>-->
            <div class="card-body">
                <b><%=p.getpTitle()%></b>
                <div class="card-text card-ht">
                    <p><%= p.getpContent()%></p>

                </div>

            </div>
            <div class="card-footer text-center primary-background">

                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());


                %>
                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>

                <a href="show_blog_admin.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
            </div>
        </div>  

    </div>     



    <%
        }


    %>
    
    
</div>
    
        <!--end add post modal-->

    <!--javascripts-->
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="js/myjs.js" type="text/javascript"></script>

    
    
    </body>
</html>
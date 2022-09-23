<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.nio.channels.ConnectionPendingException"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<html>
    <head>

        <style>
            .card-ht{
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }
            .img-fix{
                /*width: 100%;*/
                height: 200px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">

                <%
                    User uuu = (User) session.getAttribute("currentUser");

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
                    <div class="card baseBlock" style="height: 500px;">
                        <!--<div class="embed-responsive embed-responsive-1by1">-->
                        <img class="card-img-top img-fix" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
                        <!--</div>-->
                        <div class="card-body">
                            <b><%=p.getpTitle()%></b>
                            <div class="card-text">
                                <p class="card-ht"><%= p.getpContent()%></p>
                            </div>

                        </div>
                        <div class="card-footer text-center primary-background">

                            <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                            %>
                            <div id="butone">
                                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                            </div>
                            <div id="butsec">
                                <a href="#!" onclick="deleteLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-down"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                            </div>

                            <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <!--<script src="js/myjs.js" type="text/javascript"></script>-->

                <script>
            $(document).ready(function () {
                $('#butone').show();
                $('#butsec').hide();
                });

            function doLike(pid, uid)
            {

                    console.log(pid + "," + uid);
                    const d = {
                        uid: uid,
                        pid: pid,
                        operation: 'like'
                    };
                    $.ajax({
                        url: "LikeServlet",
                        data: d,
                        success: function (data, textStatus, jqXHR) {
//                            console.log(data);

                            if (data.trim() == 'true')
                            {
                                let c = $('.like-counter').html();
                                c++;

                                $('.like-counter').html(c);
//                                location.reload();
//                                $('.lk-link').addClass('active');

                                $('#butone').hide();
                                $('#butsec').show();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(data);
                        }

                    });
                
            }
        

        </script>

        
        <script>//

//            let liked;
//            $(document).ready(function () {
//                $('#butone').show();
//                $('#butsec').hide();
//            });
            function deleteLike(pid, uid)
            {

                    console.log(pid + "," + uid);
                    const d = {
                        uid: uid,
                        pid: pid,
                        operation: 'unlike'
                    };

                    $.ajax({
                        url: "LikeServlet",
                        data: d,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
//                            console.log(liked);

                            if (data.trim() == 'true')
                            {
                                let c = $('.like-counter').html();
                                c--;

                                $('.like-counter').html(c);
//                                location.reload();
//                                $('.lk-link').addClass('active');
                                $('#butone').show(); 
                                $('#butsec').hide();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(data);
                        }

                    });
                
            }

        </script>

        

    </body>
</html>
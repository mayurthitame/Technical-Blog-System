

<%@page import="com.tech.blog.entities.Admin"%>
<!--admin navbar-->
<%
    Admin admin = (Admin) session.getAttribute("currentUser");
    
    %>
<nav id="admin-nav" class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="admin_login.jsp"><span class="fa fa-bell-o"></span>Enter in Hub <span class="sr-only">(current)</span></a>
            </li>
                 <li class="nav-item dropdown">
                <a class="nav-link" href="admin_all_post.jsp"><span class="fa fa-address-card"></span>All Posts</a>

            </li>


            <li class="nav-item">
                <a class="nav-link" href="admin_all_users.jsp"><span class="fa fa-address-card"></span>Our Users</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ad_login_page.jsp"><span class="fa fa-user-circle-o"></span>Login</a>
            </li>
            <!--            <li class="nav-item">
                            <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span>Sign Up</a>
                        </li>-->

        </ul>
<%
    
    if (admin != null) 
    {
        %>
        
        
        <ul class="navbar-nav mr-right">
            <li class="nav-item">
                <a class="nav-link" href="admin_manage_post.jsp"><span class="fa fa-user-plus"><%=  admin.getEmail() %></span></a>
            </li>
        </ul>

        <%
    }

%>


    </div>
</nav>
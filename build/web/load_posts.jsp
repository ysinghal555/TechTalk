<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>


<div class="row">

    <%
        User uuu = (User)session.getAttribute("currentUser");
        
        Thread.sleep(200);
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid")); // requesting cid from the ajax (key-value pair) wala. 
        List<Post> posts = null;

        // if catId == 0 (fetch all posts)
        // if catId > 0 (fetch all posts of catId)
        if (cid == 0) {
            posts = d.getAllPost();
        } else {
            posts = d.getPostByCatId(cid);
        }

        if (posts.size() == 0) {
            out.println("<h3 class='display-4 text-center'>No Post to show int this category..</h3>");
            return;
        }

        //    Code we write here is going to repear for all other posts
        for (Post p : posts) {

    %>

    <div class="col-md-6 mt-3">

        <div class="card">

            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">


            <div class="card-body">
                <!--show title-->
                <b><%= p.getpTitle()%></b>

                <!--show content/description-->
                <!--<p class="mt-2"><%= p.getpContent()%></p>-->

                <!--show code(if any)-->
                <!--codes are always show inside pre tag-->
                <!--<pre class="mt-2"><%= p.getpCode()%></pre>-->

            </div>

            <div class="card-footer text-center">

                <%
                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>
                
                <a href="" onclick="doLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-danger btn-sm m-2 "><i class="fa fa-heart"></i><span class="like-counter"> <%=ld.countLikeOnPost(p.getPid()) %></span></a>
                <!--here we are using url-rewriting to send to another page-->
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-info btn-sm m-2">Read More...</a>
                <a href="" class="btn btn-outline-dark btn-sm m-2"><i class="fa fa-commenting"></i><span> </span></a>

            </div>

        </div>

    </div>


    <%    }

    %>

</div>

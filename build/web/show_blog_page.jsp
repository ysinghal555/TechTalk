<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<!--validation if there is user or not -->
<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%></title>

        <!-- CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style> 
            .banner-background{
                clip-path: polygon(0 1%, 100% 1%, 100% 100%, 65% 92%, 30% 100%, 0 92%);
            }

            .post-title{
                font-weight: 100;
                font-size: 30;
            }

            .post-content{
                font-weight: 100;
                font-size: 25;
            }

            h4.post-title{
                line-height: 1.5;
            }

            body{
                background: url(img/1347788.jpg); 
                background-size: cover;
                background-attachment: fixed;
            }
        </style>

    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_IN/sdk.js#xfbml=1&version=v11.0" nonce="yEIMSmPS"></script>
</head>
<body>

    <!--navbar-->

    <nav class="navbar navbar-expand-lg navbar-dark primary-background p-3">
        <a class="navbar-brand mr-5" href="index.jsp"><span class="fa fa-address-book mr-2"></span> TechTalk</a>     
        <button class="navbar-toggler " type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse " id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto ">
                <li class="nav-item active">
                    <a class="nav-link mr-2" href="profile.jsp"> Home<span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white mr-2" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Programming Language</a>
                        <a class="dropdown-item" href="#">Project Implementation</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Data Structures</a>
                    </div>
                </li>

                <li class="nav-item ">
                    <a class="nav-link text-white mr-2" href="#"><span class="fa fa-phone"></span> Contact</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white mr-2" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-upload"></span> Post</a>
                </li>

            </ul>

            <ul class="navbar-nav mr-right">
                <li class="nav-item mr-5">
                    <a class="nav-link text-white" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle mr-2"></span> <%= user.getName()%></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-white" href="LogoutServlet"> <span class="fa fa-sign-out "></span> Logout</a>
                </li>

            </ul>

        </div>
    </nav>

    <!--end of navbar-->


    <!--main content of body-->

    <div class="container">

        <div class="row my-4">

            <div class="col-md-8 offset-md-2">

                <div class="card">

                    <div class="card-header primary-background text-white">

                        <h4 class="post-title"><%=p.getpTitle()%></h4>

                    </div>

                    <div class="card-body">

                        <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap" style=" display: flex; margin:0 auto; width:400px;" >

                        <hr>

                        <div class="row">

                            <div class="col-md-8">
                                <%
                                    UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                %>
                                <p>Posted By: <a style="color: #189be0; "><%=ud.getUserByUserId(p.getUserId()).getName()%></a></p>

                            </div>

                            <div class="col-md-4">

                                <p ><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>

                            </div>

                        </div>

                        <hr>

                        <p class="post-content mt-2"><%=p.getpContent()%></p>

                        <br>
                        <hr>

                        <div class="post-code">

                            <pre class="mt-2"><%=p.getpCode()%></pre>

                        </div>

                    </div>

                    <div class="card-footer">

                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>

                        <a href="" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-danger btn-sm m-2 "><i class="fa fa-heart"></i><span class="like-counter"> <%=ld.countLikeOnPost(p.getPid())%></span></a>
                        <a class="btn btn-outline-dark btn-sm m-2"><i class="fa fa-commenting"></i><span> </span></a>

                    </div>

                    <div class="card-footer">
                        <div class="fb-comments" data-href="http://localhost:8080/TechBlog/show_blog_page.jsp?post_id=<%=p.getPid()%>" data-width="" data-numposts="5"></div>
                    </div>


                </div>

            </div>

        </div>

    </div>

    <!--end of main content of body-->

    <!-- Modal -->

    <!--user profile modal-->

    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-#434142" style="background: #9fbbc9 ">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 30%" >
                        <br>
                        <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>

                        <!--User details-->

                        <div id="profile-details">
                            <table class="table mt-3">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID: </th>
                                        <td><%= user.getId()%></td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%= user.getEmail()%></td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td><%= user.getGender()%></td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Status</th>
                                        <td><%= user.getAbout()%></td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Registered Date</th>
                                        <td><%= user.getDateTime().toString()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->

                        <div id="profile-edit" style="display:none">
                            <h3 class="mt-2">Please Edit Carefully</h3>

                            <form action="EditServlet" method="post" enctype="multipart/form-data">

                                <table class="table">

                                    <tr>
                                        <td>ID</td>
                                        <td><%= user.getId()%></td>
                                    </tr>

                                    <tr>
                                        <td>Name</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Email</td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Password</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Gender</td>
                                        <td><%= user.getGender().toUpperCase()%></td>
                                    </tr>

                                    <tr>
                                        <td>About</td>
                                        <td>
                                            <textarea class="form-control" name="user_about" style="resize: none"
                                                      <%= user.getAbout()%>>
                                            </textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Edit Profile Picture</td>
                                        <td>
                                            <input type="file" name="user_image" class="form-control">
                                        </td>
                                    </tr>

                                </table>

                                <div class="container">
                                    <button type="submit" class="btn btn-outline-success">Save</button>
                                </div>

                            </form>

                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--end of user profile modal-->


    <!--add post modal-->

    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide Post Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <form id="add-post-form" action="AddPostServlet">

                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>Select Category</option>

                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCatergories();

                                    for (Category c : list) {
                                %>

                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter post title." class="form-control"/>
                        </div>

                        <div class="form-group">
                            <textarea name="pContent" placeholder="Add Content" class="form-control" style="resize: none; height: 200px;"></textarea>
                        </div>

                        <div class="form-group">
                            <textarea name="pCode" placeholder="Add Code (if any)" class="form-control" style="resize: none; height: 200px;"></textarea>
                        </div>

                        <div class="form-group">
                            <label>Add image</label>
                            <br>
                            <input name="pic" type="file" >
                        </div>

                        <div class="container text-center">
                            <button type="submit" class="btn btn-outline-success">Post</button>
                        </div>

                    </form>

                </div>

            </div>
        </div>
    </div>

    <!--end of post modal-->


    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="js/myjs.js" type="text/javascript"></script>


    <script>

                            $(document).ready(function () {

                                let editStatus = false;

                                $('#edit-profile-button ').click(function () {

                                    if (editStatus === false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        editStatus = true;

                                        $(this).text("Done");

                                    } else {
                                        $("#profile-details").show();
                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("Edit");
                                    }

                                });
                            });

    </script>

    <!--now add post JS-->
    <script>
        $(document).ready(function (e) {
            //
            $("#add-post-form").on("submit", function (event) {
                //this code gets called when form is submitted....
                event.preventDefault();
                console.log("you have clicked on submit..");
                let form = new FormData(this);
                //now requesting to server
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        //success ..
                        console.log(data);
                        if (data.trim() === 'done') {
                            swal("Registered Successfully!", "Redirecting to Login Page", "success");

                        } else {
                            //error..
                            swal(" went Wrong!", "Please try again!", "warning");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //error..
                        swal(" went Wrong!", "Please try again!", "warning");
                    },
                    processData: false,
                    contentType: false
                });
            });
        });
    </script>

</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

        <!-- CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(100% 0.4%, 100% 100%, 66% 95%, 33% 100%, 0 95%, 0 0.4%);
            }
        </style>
    </head>
    <body>

        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>

        <main class="d-flex align-items-center primary-background banner-background" style="height: 120vh">
            <!--style="padding-bottom: 20px; padding-top: 10px-->

            <div class="container mb-5">

                <div class="col-md-6 offset-md-3">

                    <div class="card">

                        <div class="card-header text-center primary-background text-white m-1" >
                            <span class="fa fa-user-plus fa-2x"></span>
                            <br>
                            Register Here
                        </div>

                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="post">

                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name"  placeholder="Enter Name">
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your password with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="user_gender">Select Gender</label>
                                    <br>
                                    <input name = "user_gender" type="radio"  id="user_gender" value="Male">Male
                                    &nbsp;&nbsp;&nbsp;
                                    <input name = "user_gender" type="radio"  id="user_gender" value="Female">Female
                                </div>

                                <div class="form-group">
                                    <textarea name="user_about" class="form-control" rows="4" placeholder="Enter something about yourself." style="resize: none"></textarea>
                                </div>

                                <div class="form-check text-center">
                                    <input name="user_check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                                </div>

                                <br>

                                <div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-2x"></span>
                                    <h5>Please Wait</h5>
                                    <br>
                                </div>

                                <div class="text-center" id="submit-btn">
                                    <button type="submit" class="btn btn-primary ">Submit</button>
                                </div>

                            </form>

                        </div>

                    </div>

                </div>

            </div>

        </main>

        <!-- JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


        <script>

            $(document).ready(function () {
                console.log("loaded......")

                $('#reg-form').on('submit', function (event) {

                    event.preventDefault();
                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();

                    // send data to register servlet:
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#submit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'done') {
                                swal("Registered Successfully!", "Redirecting to Login Page", "success")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else {
                                swal("Something went Wrong!", "Please try again!", "warning");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal("Something went Wrong!", "Please try again!", "warning");
                        },
                        processData: false,
                        contentType: false

                    });

                });

            });

        </script>
    </body>
</html>

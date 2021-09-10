<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! Something went wrong!!</title>

        <!-- CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body>

    <body>

        <div class="container text-center">
            <img src="img/system.png" class="img-fluid" style="width: 20%;height: auto; margin-top: 13%">
            <br><br><br>
            <h3>Sorry! Something went wrong!!</h3>
            <%= exception%>
            <a href="index.jsp" class="btn primary-background btn-lg text-white mt-4">Home Page</a>
        </div>  

    </body>
</html>

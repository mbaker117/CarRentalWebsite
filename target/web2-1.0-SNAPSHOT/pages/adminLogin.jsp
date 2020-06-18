<%-- 
    Document   : adminLogin
    Created on : May 18, 2020, 6:40:47 AM
    Author     : moham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>
            Mohammed Car Rental Website
        </title>

        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <!-- CSS Files -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../assets/css/now-ui-kit.css?v=1.2.0" rel="stylesheet" />
        <%

            boolean action = session.getAttribute("Result") != null;
            session.removeAttribute("Result");
        %>

    </head>

    <body class="login-page sidebar-collapse">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-transparent " color-on-scroll="400"> </nav>

        <!-- End Navbar -->
        <div class="page-header" filter-color="orange">
            <div class="page-header-image" style="background-image:url(../assets/img/login3.jpg)"></div>

            <div class='alert alert-danger alert-dismissible fade show' id="alert" style="display: none;"role='alert'>
                <span class='alert-icon'><i class='ni ni-notification-70'></i></span>
                <span class='alert-text'><strong>Login Failed! Incorrect username or password</strong> </span>
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <div class="content">
                <div class="container">
                    <div class="col-md-4 ml-auto mr-auto">
                        <div class="card card-login card-plain">
                            <form class="form" method="Post" action="<%=request.getContextPath()%>/AdminLoginRequest">

                                <img src="../assets/img/MyLogo_03.png" style="background-size: auto"/>

                                <div class="card-body">
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons users_circle-08"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" id="username" name ="username" placeholder="Username" required>
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons text_caps-small"></i>
                                            </span>
                                        </div>
                                        <input type="password" name="password" id="password" placeholder="Password..." class="form-control" required/>
                                    </div>

                                    <div class="card-footer text-center">
                                        <input  type="submit" value="Login"  class="btn btn-primary btn-round btn-lg btn-block"/>

                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <footer class="footer">
                <div class="container">
                    <nav>
                        <ul>
                            <li> </li>
                            <li> </li>
                            <li>
                                MBaker

                            </li>
                        </ul>
                    </nav>
                    <div class="copyright" id="copyright">
                        &copy;

                        <a  target="_blank">MBaker</a>.
                    </div>
                </div>
            </footer>
        </div>
        <script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
        <script src="../assets/js/core/bootstrap.min.js" type="text/javascript"></script>

        <!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
        <script src="../assets/js/now-ui-kit.js?v=1.2.0" type="text/javascript"></script>
        <script>

            <% if (action) {%>
            $("#alert").hide().show('medium');
            setTimeout(function () {
                $("#alert").alert('close');
            }, 2000);

            <% }%>






        </script>

    </body>

</html>

<%-- 
    Document   : CustomerRegisterPager
    Created on : May 23, 2020, 7:33:48 AM
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
           Register
        </title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
        <!-- CSS Files -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../assets/css/now-ui-kit.css?v=1.2.0" rel="stylesheet" />
   <%            boolean isAlert = false;
            String op = (String) session.getAttribute("customerOp");
            String alertTxt = "";
            String alertColor = "";
            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;

                int res = (Integer) session.getAttribute("userId");
             
                  if (res == -1) {

                        alertTxt = "Resister Failed! Server Error!!";
                        alertColor = "danger";
                    } else if (res == -2) {
                        alertTxt = "Register Failed! Username already exist!!";
                        alertColor = "danger";
                    } else if (res == -3) {
                        alertTxt = "Register Failed! Phone number already exist!!";
                        alertColor = "danger";

                    } else if (res == -4) {
                        alertTxt = "Register Failed! Email already exist!!";
                        alertColor = "danger";

                    }

            
                session.removeAttribute("op");
                session.removeAttribute("userId");

            }


        %>
    </head>

    <body class="login-page sidebar-collapse">

        <div class="page-header clear-filter" filter-color="black">
            <div class="page-header-image" style="background-image:url(../assets/img/main.jpg)"></div>
              <div class='alert alert-<%= alertColor%> alert-dismissible fade show ml-auto mr-auto text-center ' id="alert" style="display: none;"role='alert'>
                    <span class='alert-icon'><i class='ni ni-notification-70'></i></span>
                    <span class='alert-text'><strong><%= alertTxt%></strong> </span>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
            <div class="content">
                <div class="container">
                    <div class="col-md-4 ml-auto mr-auto">
                        <div class="card card-login card-plain">
                            <form class="form" method="Post" action="<%=request.getContextPath()%>/RegisterServer">

                                <img src="../assets/img/MyLogo_03.png" style="background-size: auto"/>
                                <div class="card-body">
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons users_circle-08"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Username..." name="username" required="true">
                                    </div>
                                      <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons ui-1_lock-circle-open"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Password..."  name="password"required="true">
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons text_caps-small"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="First Name..."  name="firstName" required="true">
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons text_caps-small"></i>
                                            </span>
                                        </div>
                                        <input type="text" placeholder="Last Name..." class="form-control" name="lastName" required="true"/>
                                    </div>
                                  
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons ui-1_email-85"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Email..." name="email" required="true">
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons tech_mobile"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Phone..." name="phoneNumber" required="true">
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="now-ui-icons location_pin"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control" placeholder="Address..." name="address" required="true">
                                    </div>
                                    <div class="input-group no-border input-lg">
                                        <div class="input-group-prepend">


                                            <label for="message-text" class="col-form-label  form-check-inline col-md-6">Driving License</label>
                                            <div class="form-check form-check-inline col-md-2">
                                                <input class="form-check-input" type="radio" name="driving" id="yes"  value="yes" checked>
                                                <label class="form-check" for="yes">Yes</label>
                                            </div>
                                            <div class="form-check form-check-inline col-md-1">
                                                <input class="form-check-input  " type="radio" name="driving" id="no" value="no">
                                                <label class="form-check" for="no">No</label>
                                            </div>
                                        </div>
                                    </div>
                              
                                <div class="card-footer text-center">
                                    <input  type="submit" value="SignUp"  class="btn btn-primary btn-round btn-lg btn-block"/>

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
        <!--   Core JS Files   -->
        <script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
        <script src="../assets/js/core/bootstrap.min.js" type="text/javascript"></script>
  
        <!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
        <script src="../assets/js/now-ui-kit.js?v=1.2.0" type="text/javascript"></script>
           <script>
            <% if (isAlert) {%>
            $("#alert").hide().show('medium');
            setTimeout(function () {
                $("#alert").alert('close');
            }, 2000);
            <% }%>
            // int res = (Integer)session.getAttribute("res");





        </script>
    </body>

</html>
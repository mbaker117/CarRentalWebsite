<%-- 
    Document   : CustomerNewOrderPage
    Created on : May 24, 2020, 8:35:25 AM
    Author     : moham
--%>


<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="package1.CustomerHandler"%>



<%@page import="package1.Car"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="../assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>
            Home Page
        </title>
        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
        <!-- CSS Files -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="../assets/css/now-ui-kit.css?v=1.3.0" rel="stylesheet" />
        <%
            boolean isAlert = false;
            String op = (String) session.getAttribute("customerOp");
            String alertTxt = "";
            String color = "";

            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;

                if (op.equals("add")) {

                    int res = (Integer) session.getAttribute("res");
                    if (res == 1) {
                        alertTxt = "Order added successfully";
                        color = "success";
                    } else {
                        alertTxt = "Order adding Failed !!";
                        color = "danger";
                    }

                }
                session.removeAttribute("customerOp");

            }


        %>
        <%            int userId = (Integer) session.getAttribute("userId");
            String carOptions = "";

            ArrayList<Integer> array3 = CustomerHandler.retriveAvailableCars();
            for (Integer c : array3) {
                carOptions += " <option value ='" + c + "'>" + c + " </option>";

            }


        %>
        <%            if (session.getAttribute("userId") == null) {
                response.sendRedirect("/web2/index.html");
            }


        %>

    </head>

    <body class="landing-page sidebar-collapse">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-transparent " color-on-scroll="400">
            <div class="container">

                <div class="navbar-translate">
                    <a href="#"> MBAKER </a>
                    <button class="navbar-toggler navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-bar top-bar"></span>
                        <span class="navbar-toggler-bar middle-bar"></span>
                        <span class="navbar-toggler-bar bottom-bar"></span>
                    </button>
                </div>


                <div class="collapse navbar-collapse justify-content-end" id="navigation" data-nav-image="../assets/img/blurred-image-1.jpg">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="CustomerHomePage.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="CustomerNewOrderPage.jsp">New Order</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" id="navbarDropdownMenuLink1" data-toggle="dropdown">

                                <p>Orders</p>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink1">
                                <a class="dropdown-item" href="CustomerOrderPage.jsp?kind=all">
                                    All Orders
                                </a>
                                <a class="dropdown-item"  href="CustomerOrderPage.jsp?kind=current">
                                    Current Orders
                                </a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="CustomerAvailableCarsPage.jsp">Available Cars</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/CustomerLogoutServer">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End Navbar -->
        <div class="wrapper">
            <div class="page-header page-header-small">
                <div class="page-header-image" data-parallax="true" style="background-image:url('../assets/img/c3.jpg');">
                </div>
                <div class='alert alert-<%=color%> alert-dismissible fade show ml-auto mr-auto text-center ' id="alert" style="display: none;"role='alert'>
                    <span class='alert-icon'><i class='ni ni-notification-70'></i></span>
                    <span class='alert-text'><strong><%= alertTxt%></strong> </span>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>

                <div class="content-center">
                    <div class="container ">
                        <h1 class="title">
                            Mohammed Baker Cars
                        </h1>
                    </div>
                </div>
            </div>
            <div class="section ">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 ml-auto mr-auto text-center">
                            <h2 class="title">Add order</h2>
                            <h5 class="description">Here you can rent our cars </h5>
                            <form method="Post"  action="<%=request.getContextPath()%>/CustomerOrderServer">
                                <div class="form-row  ">

                                    <div class="form-group col-md-6">
                                        <label for="message-text" class="col-form-label">Car</label>
                                        <select class="form-control" id="myDropdown2" name="carId">
                                            <%= carOptions%>

                                        </select>
                                    </div>
                                    <div class="form-group col-md-6" >
                                        <label for="message-text" class="col-form-label">Additional Fees</label>
                                        <input type="number" min="0" step="0.5" class="form-control" id="additionalFees" name="additionalFees" required> 
                                    </div>
                                </div>
                                <div class="form-row ">
                                    <div class="form-group col-md-6" >
                                        <label for="message-text" class="col-form-label" >Number of Days:</label>
                                        <input type="number" min="1" step="1" class="form-control" id ="days" name="days" required>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="message-text" class="col-form-label">Rent Distance</label>
                                        <input type="number" min="0" step="0.5" class="form-control" id="rentDisatnce" name="rentDisatnce" required>
                                    </div>
                                </div>


                                <div class="footer">

                                    <input type="text" name="customerId" hidden="true" value=<%= userId%>></input>
                                    <input type="submit" class="btn btn-warning col-1" id="modalBtn"value="Add"></input>
                                </div>
                            </form>

                        </div>

                    </div>
                </div>

                <div class="section section-contact-us text-center"> </div>
                <div class="section section-contact-us text-center"> </div>

                <div class="section section-contact-us text-center"> </div>
                <footer class="footer ">
                    <div class=" container ">
                        <nav>
                            <ul>
                                <li>
                                    <a href="#">
                                        Mbaker
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <div class="copyright" id="copyright">
                            &copy;
                            <script>
                                document.getElementById('copyright').appendChild(document.createTextNode(new Date().getFullYear()))
                            </script>
                            Designed And Coded by
                            <a href="#" target="">Mohammed Baker</a>.
                        </div>
                    </div>
                </footer>
            </div>
            <!--   Core JS Files   -->
            <script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
            <script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
            <script src="../assets/js/core/bootstrap.min.js" type="text/javascript"></script>
            <!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
            <script src="../assets/js/plugins/bootstrap-switch.js"></script>
            <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
            <script src="../assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
            <!--  Plugin for the DatePicker, full documentation here: https://github.com/uxsolutions/bootstrap-datepicker -->
            <script src="../assets/js/plugins/bootstrap-datepicker.js" type="text/javascript"></script>
            <!--  Google Maps Plugin    -->
            <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
            <!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
            <script src="../assets/js/now-ui-kit.js?v=1.3.0" type="text/javascript"></script>

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
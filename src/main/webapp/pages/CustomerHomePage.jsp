<%-- 
    Document   : CustomerHomePage
    Created on : May 24, 2020, 3:15:45 AM
    Author     : moham
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


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

        <%   response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setDateHeader("Expires", 0);

            boolean isAlert = false;
            String op = (String) session.getAttribute("customerOp");
            String alertTxt = "";
            if (session.getAttribute("userId") == null) {
                response.sendRedirect("/web2/index.html");
            }

            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;

                if (op.equals("login")) {
                    alertTxt = "Welcome Back";
                } else {
                    alertTxt = "Thanks for registration";
                }
                session.removeAttribute("customerOp");

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
                <div class='alert alert-success alert-dismissible fade show ml-auto mr-auto text-center ' id="alert" style="display: none;"role='alert'>
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
            <div class="section section-about-us">
                <div class="container">
                    <div class="row">
                        <div class="col-md-8 ml-auto mr-auto text-center">
                            <h2 class="title">Who we are?</h2>
                            <h5 class="description">A startup company for renting cars in Amman, you can rent your car online also we will provide 24 hours customer support&nbsp; &nbsp; &nbsp;&nbsp;</h5>
                        </div>
                    </div>
                    <div class="separator separator-primary"></div>
                    <div class="section-story-overview">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="image-container image-left" style="background-image: url('../assets/img/main2.jpg')">
                                    <!-- First image on the left side -->
                                    <p class="blockquote blockquote-primary">"The car has become the carapace, the protective and aggressive shell, of urban and suburban man."     
                                        <br>
                                        <br>
                                        <small>-Marshall McLuhan</small>
                                    </p>
                                </div>
                                <!-- Second image on the left side of the article -->
                                <div class="image-container" style="background-image: url('../assets/img/main5.jpg')"></div>
                            </div>
                            <div class="col-md-5">
                                <!-- First image on the right side, above the article -->
                                <div class="image-container image-right" style="background-image: url('../assets/img/main4.jpg')"></div>
                                <h3>Find Great Deals for Car Rental</h3>
                                <p>Our mission is to help people pick the right rental. Before you book, we will show you everything you need to know. From past customer ratings, what's included and pick-up information, we give you all the facts, so that you can make the right rental choice for you.
                                </p>
                                <p>
                                    We have access to exclusive lowest prices and free add-ons. Our smart booking search engine will ensure that we pass those savings on to you! We will show you the best and cheapest price for your rental requirements to help you find your ideal car. </p>
                                <p>We believe everyone should have a memorable and enjoyable experience with their car rental. For that reason we have selected suppliers that are friendly and helpful, reputable and have in-depth local knowledge to ensure you get the best out of your rental.   </p>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section section-team text-center">
                <div class="container">
                    <h2 class="title">Here is our team</h2>
                    <div class="team">
                        <div class="row">
                            <div class="col-md-4"> </div>
                            <div class="col-md-4">
                                <div class="team-player">
                                    <img src="../assets/img/me.jpg" class="rounded-circle">
                                    <h4 class="title">Mohammed Baker</h4>
                                    <p class="category text-primary">Designer & Developer</p>
                                    <p class="description">Fourth year computer engineering student in PSUT, mobile and web developer.</p>
                                    <a href="#pablo" class="btn btn-primary btn-icon btn-round"><i class="fab fa-twitter"></i></a>
                                    <a href="#pablo" class="btn btn-primary btn-icon btn-round"><i class="fab fa-linkedin"></i></a>
                                </div>
                            </div>
                            <div class="col-md-4"> </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section section-contact-us text-center"> </div>
            <footer class="footer footer-default">
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
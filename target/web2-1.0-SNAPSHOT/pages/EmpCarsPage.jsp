<%-- 
    Document   : EmployeeCarsPage
    Created on : May 20, 2020, 5:30:21 AM
    Author     : moham
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="package1.EmployeeHandler"%>

<%@page import="package1.Car"%>
<%@page import="package1.CarCategory"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Creative Tim">
        <title>Employee Page</title>
        <!-- icon -->
        <link rel="icon" href="icon_03.png" type="image/png">
        <!-- Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <!-- Icons -->
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <!-- Page plugins -->
        <!-- Argon CSS -->
        <link rel="stylesheet" href="../assets/css/argon.css?v=1.2.0" type="text/css">
        <% String table = "";
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setDateHeader("Expires", -1);
            ArrayList<Car> array = EmployeeHandler.retriveCars();

            for (Car e : array) {
                table += "<tr>";
                table += "<th scope='row'> <div class='media align-items-center'> ";
                table += "<div class='media-body' id='tId'> <span class='name mb-0 text-sm'>" + e.getId() + "</span> </div> </div>";
                table += "</th>";
                table += " <td class='budget' id='tUsername'>" + e.getVin() + "</td>";
                table += "   <td> <span class='status' id='tPassword'>" + e.getPlateNumber() + "</span> </td>";
                table += "  <td> <span class='status' id='tFirstName'>" + e.getSeats() + "</span> </td>";
                table += " <td><span class='completion mr-2' id='tLastName'>" + e.getMaker() + "</span></td>";
                table += " <td> <span class='status' id='tPhoneNumber' >" + e.getModelName() + "</span> </td>";
                table += "  <td><span class='completion mr-2' id='tEmail'>" + e.getModelYear() + "</span></td>";
                table += " <td><span class='completion mr-2' id='tAddress'>" + EmployeeHandler.getCatName(e.getCategoryId()) + "</span></td>";
                table += " <td><span class='completion mr-2' id='tAddress'>" + e.getOdoMeter() + "</span></td>";
                boolean rented = e.isRented();
                String color1 = rented ? "danger" : "success";
                String text1 = rented ? "Rented" : "Not Rented";
                table += "   <td><span class='badge badge-dot mr-4'> <i class='bg-" + color1 + "'></i> <span class='status'>" + text1 + "</span> </span>";
                boolean avilable = e.isAvailable();
                String color2 = avilable ? "success" : "danger";
                String text2 = avilable ? "Yes" : "No";
                table += "  </td>";
                table += "   <td><span class='badge badge-dot mr-4'> <i class='bg-" + color2 + "'></i> <span class='status'>" + text2 + "</span> </span>";
                table += "  </td>";
                table += "   <td class='text-right'>";
                table += "   <div class='dropdown'>";
                table += "    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
                table += "     <i class='fas fa-ellipsis-v'></i>";
                table += "   </a>";
                table += "    <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>";
                table += "     <a class='dropdown-item' data-toggle='modal' data-target='#carModal' class='editBtn'>Edit</a>";
                table += "     <form method='Post' action='" + request.getContextPath() + "/EmpCarServer'> <input type='submit' class='dropdown-item ' value='Delete'   ></input>";
                table += "<input type='text'  name='carId' hidden='true' value='" + e.getId() + "'></input>";
                table += "<input type='text'  name='carOp' hidden='true' class='btn btn-warning' value='Delete'></input></form>";
                table += "     <form method='Post' target='_blank'action='EmpCarRentHistoryPage.jsp'> <input type='submit' class='dropdown-item ' value='Rent History'   ></input>";
                table += "<input type='text'  name='carId' hidden='true' value='" + e.getId() + "'></input>";
                table += "</form>";
                table += "     </div>";
                table += "   </div>";
                table += "    </td>";
                table += "  </tr>";

            }

            String catOptions = "";
            ArrayList<CarCategory> array2 = EmployeeHandler.retriveCarCategory();
            for (CarCategory c : array2) {
                catOptions += " <option value ='" + c.getId() + "'>" + c.getName() + " </option>";

            }

        %>

        <%            boolean isAlert = false;
            String op = (String) session.getAttribute("adminCarOp");
            String alertTxt = "";
            String alertColor = "";
            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;

                int res = (Integer) session.getAttribute("adminCarRes");
                if (op.equals("add")) {
                    if (res == 1) {
                        alertTxt = "Car added succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Adding Failed! Server Error!!";
                        alertColor = "danger";
                    } else if (res == -2) {
                        alertTxt = "Adding Failed! Vin already exist!!";
                        alertColor = "danger";
                    } else if (res == -3) {
                        alertTxt = "Adding Failed! Plate Number already exist!!";
                        alertColor = "danger";

                    }

                } else if (op.equals("edit")) {
                    if (res == 1) {
                        alertTxt = "Car edited succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Editing Failed! Server Error!!";
                        alertColor = "danger";
                    } else if (res == -2) {
                        alertTxt = "Editing Failed! Vin already exist!!";
                        alertColor = "danger";
                    } else if (res == -3) {
                        alertTxt = "Editing Failed! Plate Number already exist!!";
                        alertColor = "danger";

                    }

                } else if (op.equals("delete")) {
                    if (res == 1) {
                        alertTxt = "Car delted succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Deleting Failed! Server Error!!";
                        alertColor = "danger";
                    }
                }
                session.removeAttribute("adminCarOp");
                session.removeAttribute("adminCarRes");

            }


        %>

    </head>

    <body>


        <nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white" id="sidenav-main2"></nav>

        <div class="main-content" id="panel">

            <!-- Header -->
            <!-- Header -->
            <div class="header bg-orange pb-6">
                <div class='alert alert-<%= alertColor%> alert-dismissible fade show' id="alert" style="display: none;"role='alert'>
                    <span class='alert-icon'><i class='ni ni-notification-70'></i></span>
                    <span class='alert-text'><strong><%= alertTxt%></strong> </span>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>

                <div class="container-fluid">
                    <div class="header-body">

                        <div class="row align-items-center py-4">
                            <div class="col-lg-6 col-7">
                                <h6 class="h2 text-white d-inline-block mb-0">Car&nbsp;</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4"> </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right"> <a data-toggle="modal" data-target="#carModal" href="#" class="btn btn-sm btn-neutral">New</a> </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page content -->
            <div class="container-fluid mt--6">
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <!-- Card header -->
                            <div class="card-header border-0">
                                <h3 class="mb-0">Car Table&nbsp;</h3>
                            </div>
                            <!-- Light table -->
                            <div class="table-responsive">
                                <table class="table align-items-center table-flush">
                                    <thead class="thead-light">
                                        <tr>
                                            <th scope="col" class="sort" data-sort="id">Id</th>
                                            <th scope="col" class="sort" data-sort="username">VIN</th>
                                            <th scope="col" class="sort" data-sort="password">Plate Number</th>
                                            <th scope="col" class="sort" data-sort="fname">Number Of Seats</th>
                                            <th scope="col" class="sort" data-sort="lname">Maker</th>

                                            <th scope="col" class="sort" data-sort="phone">Model Name</th>
                                            <th scope="col" class="sort" data-sort="email">Model Year</th>
                                            <th scope="col" class="sort" data-sort="address">Category</th>
                                            <th scope="col" class="sort" data-sort="address">Meter Reading</th>
                                            <th scope="col" class="sort" data-sort="active">Rented</th>
                                            <th scope="col" class="sort" data-sort="active">Available</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody class="list">

                                        <%= table%>


                                    </tbody>
                                </table>
                            </div>
                            <!-- Card footer -->
                        </div>
                    </div>
                </div>
                <!-- Dark table -->
                <div class="row">
                    <div class="col"> </div>
                </div>
                <!-- Footer -->
            </div>
        </div>
        <!-- Sidenav -->
        <nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-default" id="sidenav-main">
            <div class="scrollbar-inner">
                <!-- Brand -->
                <div class="sidenav-header ">
                    <a class="navbar-brand" >
                        <img src="../assets/img/brand/orange.png" class="navbar-brand-img" >
                    </a>
                </div>
                <div class="navbar-inner">
                    <!-- Collapse -->
                    <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                        <!-- Nav items -->
                        <ul class="navbar-nav">

                         
                            <li class="nav-item">
                                <a class="nav-link" href="EmpCustomerPage.jsp">
                                    <i class="ni ni-circle-08 text-orange"></i>
                                    <span class="nav-link-text text-white">Customer</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="EmpCarCategoryPage.jsp">
                                    <i class="ni ni-bullet-list-67 text-orange" ></i>
                                    <span class="nav-link-text text-white">Car Category</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="EmpCarsPage.jsp">
                                    <i class="ni ni-bus-front-12 text-orange"></i>
                                    <span class="nav-link-text text-white">Cars </span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="EmpOrderPage.jsp">
                                    <i class="ni ni-ruler-pencil text-orange"></i>
                                    <span class="nav-link-text text-white">Order</span>
                                </a>
                            </li>

                        </ul>
                        <!-- Divider -->
                         <hr class="my-3 bg-white">
                        <!-- Heading -->
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/EmpLogoutServer">
                                    <i class="ni ni-user-run text-orange"></i>
                                    <span class="nav-link-text text-white">Logout</span>
                                </a>
                            </li>

                        </ul> 

                    </div>
                </div>
            </div>
        </nav>



        <div class="modal fade" id="carModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" ></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="Post" id="modalForm" action="<%=request.getContextPath()%>/EmpCarServer">
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="recipient-name" class="col-form-label">VIN:</label>
                                    <input type="text" class="form-control" id ="vin" name="vin" required>
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Plate Number:</label>
                                    <input type="text" class="form-control" id ="plateNumber"  name="plateNumber" required>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label" >Number of seats:</label>
                                    <input type="number" min="1" step="1" class="form-control" id ="seats" name="seats" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="message-text" class="col-form-label">Maker:</label>
                                    <input type="text" class="form-control" id="maker" name="maker" required>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Model Name:</label>
                                    <input type="text" class="form-control" id="modelName" name="modelName" required> 
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Model Year:</label>
                                    <input type="number" min="2000" max ="2020" step="1" class="form-control" id="modelYear" name="modelYear" required>
                                </div> 
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >

                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">Category</label>
                                        <select class="form-control" id="myDropdown" name="categoryId">
                                            <%= catOptions%>

                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Meter Reading:</label>
                                    <input type="number" min="0" class="form-control" id="meterReading" name="meterReading" required>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Rented</label><br>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input" type="radio" name="rented" id="yes"  value="yes" checked>
                                        <label class="form-check-label" for="yes">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input  " type="radio" name="rented" id="no" value="no">
                                        <label class="form-check-label " for="no">No</label>
                                    </div>

                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Available</label><br>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input" type="radio" name="available" id="yesD"  value="yes" checked>
                                        <label class="form-check-label" for="yesD">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input  " type="radio" name="available" id="noD" value="no">
                                        <label class="form-check-label " for="noD">No</label>
                                    </div>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <input type="text" id ="carId" name='carId' hidden="true" class="btn btn-warning" value="-1"></input>
                                <input type="text" id ="carOp" name='carOp' hidden="true" class="btn btn-warning" value=""></input>
                                <input type="submit" class="btn btn-warning" id="modalBtn"value="Add"></input>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="../assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="../assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <!-- Argon JS -->
        <script src="../assets/js/argon.js?v=1.2.0"></script> 

        <script>
            $('#carModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                if (button.text() == "New") {
                    var modal = $(this);
                    modal.find('.modal-title').text('Add Car');
                    $("#modalBtn").val("Add");
                    $("#carOp").val("Add");

                    $("#vin").val(0);
                    $("#plateNumber").val("");
                    $("#seats").val(0);
                    $("#maker").val("");
                    $("#modelName").val("");
                    $("#modelYear").val(2000);

                    $("#myDropdown").prop("selectedIndex", 0);
                    $("#meterReading").val(0);
                } else if (button.text() == "Edit") {
                    $("#carId").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#vin").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#plateNumber").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#seats").val(parseInt(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text()));
                    $("#maker").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#modelName").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().text());
                    $("#modelYear").val(parseInt(button.parent().parent().parent().prev().prev().prev().prev().prev().text()));
                    $("#myDropdown option:contains(" + button.parent().parent().parent().prev().prev().prev().prev().text() + ")").prop('selected', 'selected');
                    $("#meterReading").val(parseFloat(button.parent().parent().parent().prev().prev().prev().text()));
                    var rented = button.parent().parent().parent().prev().prev().text();
                    var available = button.parent().parent().parent().prev().text();
                    if (rented.trim() == "NotRented") {

                        $("#yes").prop("checked", true);
                        $("#no").prop("checked", false);

                    } else {
                        $("#yes").prop("checked", false);
                        $("#no").prop("checked", true);

                    }
                    if (available.trim() == "Yes") {

                        $("#yesD").prop("checked", true);
                        $("#noD").prop("checked", false);

                    } else {
                        $("#yesD").prop("checked", false);
                        $("#noD").prop("checked", true);

                    }

                    var modal = $(this);
                    modal.find('.modal-title').text('Edit Car');
                    $("#modalBtn").val("Edit");
                    $("#carOp").val("Edit");
                }
            });




        </script>

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

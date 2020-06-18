<%-- 
    Document   : AdminEmployeePage
    Created on : May 19, 2020, 2:59:51 AM
    Author     : moham
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="package1.AdminHandler"%>
<%@page import="package1.Employee"%>
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
        <title>Admin Page</title>
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
            ArrayList<Employee> array = AdminHandler.retriveEmployee();

            for (Employee e : array) {
                table += "<tr>";
                table += "<th scope='row'> <div class='media align-items-center'> ";
                table += "<div class='media-body' id='tId'> <span class='name mb-0 text-sm'>" + e.getId() + "</span> </div> </div>";
                table += "</th>";
                table += " <td class='budget' id='tUsername'>" + e.getUsername() + "</td>";
                table += "   <td> <span class='status' id='tPassword'>" + e.getPassword() + "</span> </td>";
                table += "  <td> <span class='status' id='tFirstName'>" + e.getFirstName() + "</span> </td>";
                table += " <td><span class='completion mr-2' id='tLastName'>" + e.getLastName() + "</span></td>";
                table += " <td> <span class='status' id='tPhoneNumber' >" + e.getPhoneNumber() + "</span> </td>";
                table += "  <td><span class='completion mr-2' id='tEmail'>" + e.getEmail() + "</span></td>";
                table += " <td><span class='completion mr-2' id='tAddress'>" + e.getAddress() + "</span></td>";
                boolean active = e.isIsActive();
                String color = active ? "success" : "danger";
                String text = active ? "Active" : "Disable";
                table += "   <td><span class='badge badge-dot mr-4'> <i class='bg-" + color + "'></i> <span class='status'>" + text + "</span> </span>";
                table += "  </td>";
                table += "   <td class='text-right'>";
                table += "   <div class='dropdown'>";
                table += "    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
                table += "     <i class='fas fa-ellipsis-v'></i>";
                table += "   </a>";
                table += "    <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>";
                table += "     <a class='dropdown-item' data-toggle='modal' data-target='#addEmployeeModal' class='editBtn'>Edit</a>";
                table += "     <form method='Post' action='" + request.getContextPath() + "/EmployeeServer'> <input type='submit' class='dropdown-item ' value='Delete'   ></input>";
                table += "<input type='text'  name='empId' hidden='true' value='" + e.getId() + "'></input>";
                table += "<input type='text'  name='empOp' hidden='true' class='btn btn-warning' value='Delete'></input></form>";
                table += "     </div>";
                table += "   </div>";
                table += "    </td>";
                table += "  </tr>";

            }


        %>

        <%            boolean isAlert = false;
            String op = (String) session.getAttribute("adminEmpOp");
            String alertTxt = "";
            String alertColor = "";
            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;
                if (op.equals("login")) {

                    //   String alertText = "Weclome Back";
                    alertTxt = "Weclome Back";
                    alertColor = "success";
                } else {
                    int res = (Integer) session.getAttribute("adminEmpRes");
                    if (op.equals("add")) {
                        if (res == 1) {
                            alertTxt = "Employee added succesfully";
                            alertColor = "success";
                        } else if (res == -1) {

                            alertTxt = "Adding Failed! Server Error!!";
                            alertColor = "danger";
                        } else if (res == -2) {
                            alertTxt = "Adding Failed! Username already exist!!";
                            alertColor = "danger";
                        } else if (res == -3) {
                            alertTxt = "Adding Failed! Phone number already exist!!";
                            alertColor = "danger";

                        } else if (res == -4) {
                            alertTxt = "Adding Failed! Email already exist!!";
                            alertColor = "danger";

                        }

                    } else if (op.equals("edit")) {
                        if (res == 1) {
                            alertTxt = "Employee edited succesfully";
                            alertColor = "success";
                        } else if (res == -1) {

                            alertTxt = "Editing Failed! Server Error!!";
                            alertColor = "danger";
                        } else if (res == -2) {
                            alertTxt = "Editing Failed! Username already exist!!";
                            alertColor = "danger";
                        } else if (res == -3) {
                            alertTxt = "Editing Failed! Phone number already exist!!";
                            alertColor = "danger";

                        } else if (res == -4) {
                            alertTxt = "Editing Failed! Email already exist!!";
                            alertColor = "danger";

                        }

                    } else if (op.equals("delete")) {
                        if (res == 1) {
                            alertTxt = "Employee delted succesfully";
                            alertColor = "success";
                        } else if (res == -1) {

                            alertTxt = "Deleting Failed! Server Error!!";
                            alertColor = "danger";
                        }
                    }
                }
                session.removeAttribute("adminEmpOp");
                session.removeAttribute("adminEmpRes");
            }


        %>

    </head>

    <body>


        <nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white" id="sidenav-main2"></nav>

        <div class="main-content" id="panel">

            <!-- Header -->
            <!-- Header -->
            <div class="header bg-warning pb-6">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Employee&nbsp;</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4"> </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right"> <a data-toggle="modal" data-target="#addEmployeeModal" href="#" class="btn btn-sm btn-neutral">New</a> </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page content -->
            <div class="container-fluid mt--6">
                <div class="row">
                    <div class="col">
                        <div class="card bg-default shadow">
                            <!-- Card header -->
                            <div class="card-header bg-transparent border-0">
                                <h3 class="mb-0 text-white">Employee Table&nbsp;</h3>
                            </div>
                            <!-- Light table -->
                            <div class="table-responsive">
                                <table class="table align-items-center table-dark table-flush">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col" class="sort" data-sort="id">Id</th>
                                            <th scope="col" class="sort" data-sort="username">Username</th>
                                            <th scope="col" class="sort" data-sort="password">Password</th>
                                            <th scope="col" class="sort" data-sort="fname">First Name</th>
                                            <th scope="col" class="sort" data-sort="lname">Last Name</th>

                                            <th scope="col" class="sort" data-sort="phone">Phone Number</th>
                                            <th scope="col" class="sort" data-sort="email">Email</th>
                                            <th scope="col" class="sort" data-sort="address">Address</th>
                                            <th scope="col" class="sort" data-sort="active">Active</th>
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
                                <a class="nav-link" href="AdminEmployeePage.jsp">
                                    <i class="ni ni-badge text-orange"></i>
                                    <span class="nav-link-text text-white">Employee</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AdminCustomerPage.jsp">
                                    <i class="ni ni-circle-08 text-orange"></i>
                                    <span class="nav-link-text text-white">Customer</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AdminCarCategoryPage.jsp">
                                    <i class="ni ni-bullet-list-67 text-orange" ></i>
                                    <span class="nav-link-text text-white">Car Category</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AdminCarsPage.jsp">
                                    <i class="ni ni-bus-front-12 text-orange"></i>
                                    <span class="nav-link-text text-white">Cars </span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="AdminOrderPage.jsp">
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
                                <a class="nav-link" href="<%=request.getContextPath()%>/AdminLogoutServer">
                                    <i class="ni ni-user-run text-orange"></i>
                                    <span class="nav-link-text text-white">Logout</span>
                                </a>
                            </li>

                        </ul> 
                    </div>
                </div>
            </div>
        </nav>


        <div class="modal fade" id="addEmployeeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" ></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="Post" id="modalForm" action="<%=request.getContextPath()%>/EmployeeServer">
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="recipient-name" class="col-form-label">Username:</label>
                                    <input type="text" class="form-control" id ="username" name="username" required>
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Password:</label>
                                    <input type="text" class="form-control" id ="password"  name="password" required>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label" >First Name:</label>
                                    <input type="text" class="form-control" id ="firstName" name="firstName" required>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="message-text" class="col-form-label">Last Name:</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                </div>
                            </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Phone Number:</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required> 
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Email:</label>
                                    <input type="text" class="form-control" id="email" name="email" required>
                                </div>  </div>
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Address:</label>
                                    <input type="text" class="form-control" id="address" name="address" required>
                                </div>
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Active</label><br>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input" type="radio" name="active" id="yes"  value="yes" checked>
                                        <label class="form-check-label" for="yes">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline col-md-2">
                                        <input class="form-check-input  " type="radio" name="active" id="no" value="no">
                                        <label class="form-check-label " for="no">No</label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <input type="text" id ="empId" name='empId' hidden="true" class="btn btn-warning" value="-1"></input>
                                <input type="text" id ="empOp" name='empOp' hidden="true" class="btn btn-warning" value=""></input>
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
            $('#addEmployeeModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                if (button.text() == "New") {
                    var modal = $(this);
                    modal.find('.modal-title').text('Add Employee');
                    $("#modalBtn").val("Add");
                    $("#empOp").val("Add");
                    $("#username").val("");
                    $("#password").val("");
                    $("#firstName").val("");
                    $("#lastName").val("");
                    $("#phoneNumber").val("");
                    $("#email").val("");
                    $("#address").val("");
                    $("#yes").prop("checked", true);
                    $("#no").prop("checked", false);


                } else if (button.text() == "Edit") {
                    $("#empId").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#username").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#password").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#firstName").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().text());
                    $("#lastName").val(button.parent().parent().parent().prev().prev().prev().prev().prev().text());
                    $("#phoneNumber").val(button.parent().parent().parent().prev().prev().prev().prev().text());
                    $("#email").val(button.parent().parent().parent().prev().prev().prev().text());
                    $("#address").val(button.parent().parent().parent().prev().prev().text());
                    var active = button.parent().parent().parent().prev().text();

                    if (active.trim() == "Active") {

                        $("#yes").prop("checked", true);
                        $("#no").prop("checked", false);

                    } else {
                        $("#yes").prop("checked", false);
                        $("#no").prop("checked", true);

                    }

                    var modal = $(this);
                    modal.find('.modal-title').text('Edit Employee');
                    $("#modalBtn").val("Edit");
                    $("#empOp").val("Edit");
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

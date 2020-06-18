<%-- 
    Document   : AdminOrderPage
    Created on : May 20, 2020, 8:42:32 PM
    Author     : moham
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="package1.AdminHandler"%>

<%@page import="package1.Car"%>
<%@page import="package1.Customers"%>
<%@page import="package1.Order"%>
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
            ArrayList<Order> array = AdminHandler.retriveOrders();

            for (Order e : array) {
                table += "<tr>";
                table += "<th scope='row'> <div class='media align-items-center'> ";
                table += "<div class='media-body' id='tId'> <span class='name mb-0 text-sm'>" + e.getId() + "</span> </div> </div>";
                table += "</th>";
                table += " <td class='budget' id='tUsername'>" + AdminHandler.getCustomerName(e.getCustomerId()) + "</td>";
                table += "   <td> <span class='status' id='tPassword'>" + e.getCarId() + "</span> </td>";
                table += "  <td> <span class='status' id='tFirstName'>" + e.getOdoMeterReading() + "</span> </td>";
                table += " <td><span class='completion mr-2' id='tLastName'>" + e.getNumberOfDays() + "</span></td>";
                table += " <td> <span class='status' id='tPhoneNumber' >" + e.getRentDistance() + "</span> </td>";
                table += "  <td><span class='completion mr-2' id='tEmail'>" + e.getAdditionalFees() + "</span></td>";
                table += " <td><span class='completion mr-2' id='tAddress'>" + e.getTotalCost() + "</span></td>";
                table += " <td><span class='completion mr-2' id='tAddress'>" + e.getPayment() + "</span></td>";
                boolean checked = e.isCheckOut();
                String color1 = checked ? "success" : "danger";
                String text1 = checked ? "Checked" : "Not Checked";
                table += "   <td><span class='badge badge-dot mr-4'> <i class='bg-" + color1 + "'></i> <span class='status'>" + text1 + "</span> </span>";
                table += "  </td>";

                table += "   <td class='text-right'>";
                table += "   <div class='dropdown'>";
                table += "    <a class='btn btn-sm btn-icon-only text-light' href='#' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
                table += "     <i class='fas fa-ellipsis-v'></i>";
                table += "   </a>";
                table += "    <div class='dropdown-menu dropdown-menu-right dropdown-menu-arrow'>";
                table += "     <a class='dropdown-item' data-toggle='modal' data-target='#orderModal' class='editBtn'>Edit</a>";
                table += "     <form method='Post' action='" + request.getContextPath() + "/AdminOrderServer'> <input type='submit' class='dropdown-item ' value='Delete'   ></input>";
                table += "<input type='text'  name='orderId' hidden='true' value='" + e.getId() + "'></input>";
                table += "<input type='text'  name='orderOp' hidden='true' class='btn btn-warning' value='Delete'></input></form>";
               if(!checked){
                table += "     <form method='Post' action='" + request.getContextPath() + "/AdminOrderServer'> <input type='submit' class='dropdown-item ' value='Check Out'   ></input>";
                table += "<input type='text'  name='orderId' hidden='true' value='" + e.getId() + "'></input>";
                table += "<input type='text'  name='orderOp' hidden='true' class='btn btn-warning' value='Check'></input></form>";
               }
            
                table += "     </div>";
                table += "   </div>";
                table += "    </td>";
                table += "  </tr>";

            }

            String customerOptions = "";
            ArrayList<Customers> array2 = AdminHandler.retriveCustomers();
            for (Customers c : array2) {
                customerOptions += " <option value ='" + c.getId() + "'>" + c.getFirstName() + " " + c.getLastName() + " </option>";

            }
            String carOptions = "";

            ArrayList<Integer> array3 = AdminHandler.retriveAvailableCars();
            for (Integer c : array3) {
                carOptions += " <option value ='" + c + "'>" + c + " </option>";

            }

        %>

        <%            boolean isAlert = false;
            String op = (String) session.getAttribute("adminOrderOp");
            String alertTxt = "";
            String alertColor = "";
            if (op == null) {
                isAlert = false;

            } else {
                isAlert = true;

                int res = (Integer) session.getAttribute("adminOrderRes");
                if (op.equals("add")) {
                    if (res == 1) {
                        alertTxt = "Order added succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Adding Failed! Server Error!!";
                        alertColor = "danger";
                    }

                } else if (op.equals("edit")) {
                    if (res == 1) {
                        alertTxt = "Order edited succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Editing Failed! Server Error!!";
                        alertColor = "danger";
                    }else {
                          alertTxt = "Editing Failed! Payment larger than Total costs!!";
                        alertColor = "danger"; 
                    }

                } else if (op.equals("delete")) {
                    if (res == 1) {
                        alertTxt = "Order deleted succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Deleting Failed! Server Error!!";
                        alertColor = "danger";
                    }
                }else if (op.equals("check")) {
                    if (res == 1) {
                        alertTxt = "Order checked out  succesfully";
                        alertColor = "success";
                    } else if (res == -1) {

                        alertTxt = "Checking out  Failed! Server Error!!";
                        alertColor = "danger";
                    }else {
                          alertTxt = "Checking out Failed! Payment doesn't equal Total costs!!";
                        alertColor = "danger"; 
                    }
                }
                session.removeAttribute("adminOrderOp");
                session.removeAttribute("adminOrderRes");

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
                                <h6 class="h2 text-white d-inline-block mb-0">Order&nbsp;</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4"> </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right"> <a data-toggle="modal" data-target="#orderModal" href="#" class="btn btn-sm btn-neutral">New</a> </div>
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
                                <h3 class="mb-0 text-white">Order Table&nbsp;</h3>
                            </div>
                            <!-- Light table -->
                            <div class="table-responsive">
                                <table class="table align-items-center table-dark table-flush">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col" class="sort" data-sort="id">Id</th>
                                            <th scope="col" class="sort" data-sort="username">Customer</th>
                                            <th scope="col" class="sort" data-sort="password">Car Id</th>
                                            <th scope="col" class="sort" data-sort="fname">Meter Reading</th>
                                            <th scope="col" class="sort" data-sort="lname">Number Of Days</th>

                                            <th scope="col" class="sort" data-sort="phone">Rent Distance</th>
                                            <th scope="col" class="sort" data-sort="email">Additional fees</th>
                                            <th scope="col" class="sort" data-sort="address">Total Cost</th>
                                            <th scope="col" class="sort" data-sort="address">Payments</th>
                                            <th scope="col" class="sort" data-sort="active">Checked Out</th>

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


        <div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" ></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="Post" id="modalForm" action="<%=request.getContextPath()%>/AdminOrderServer">
                            <div class="form-row  ">
                                <div class="form-group col-md-6">
                                    <label for="message-text" class="col-form-label">Customer</label>
                                    <select class="form-control" id="myDropdown1" name="customerId">
                                        <%= customerOptions%>

                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="message-text" class="col-form-label">Car</label>
                                    <select class="form-control" id="myDropdown2" name="carId">
                                        <%= carOptions%>

                                    </select>
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
                            <div class="form-row ">
                                <div class="form-group col-md-6" >
                                    <label for="message-text" class="col-form-label">Additional Fees</label>
                                    <input type="number" min="0" step="0.5" class="form-control" id="additionalFees" name="additionalFees" required> 
                                </div>
                                <div class="form-group col-md-6" id="pDiv" hidden="true" >
                                    <label for="message-text" class="col-form-label">Payments</label>
                                    <input type="number" min="0" step="0.01" class="form-control" value="0" id="payment" name="payment"  > 
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <input type="text" id ="orderId" name='orderId' hidden="true" class="btn btn-warning" value="-1"></input>
                                <input type="text" id ="orderOp" name='orderOp' hidden="true" class="btn btn-warning" value=""></input>
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
            var add = false;
            $('#orderModal').on('show.bs.modal', function (event) {
                //  $("#myDropdown2").empty();

                var button = $(event.relatedTarget) // Button that triggered the modal

                if (button.text() == "New") {
                    var modal = $(this);
                    modal.find('.modal-title').text('Add Ordr');
                    $("#modalBtn").val("Add");
                    $("#orderOp").val("Add");
                    $("#pDiv").prop("hidden", true);
                    $("#days").val(1);
                      $("#myDropdown1").prop("selectedIndex", 0);
                    $("#rentDisatnce").val(0);
                    $("#additionalFees").val(0);


                    /*  $("#vin").val(0);
                     $("#plateNumber").val("");
                     $("#seats").val(0);
                     $("#maker").val("");
                     $("#modelName").val("");
                     $("#modelYear").val(2000);
                     
                     $("#myDropdown").prop("selectedIndex", 0);
                     $("#meterReading").val(0);*/
                } else if (button.text() == "Edit") {
                       $("#orderId").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#myDropdown1 option:contains(" + button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().prev().text() + ")").prop('selected', 'selected');
                    var o = new Option(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text(), button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $(o).html(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    $("#myDropdown2").prepend(o);
                    $("#myDropdown2").val(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev().prev().text());
                    add = true;
                    $("#days").val(parseInt(button.parent().parent().parent().prev().prev().prev().prev().prev().prev().text()));
                    $("#rentDisatnce").val(parseFloat(button.parent().parent().parent().prev().prev().prev().prev().prev().text()));
                    $("#additionalFees").val(parseFloat(button.parent().parent().parent().prev().prev().prev().prev().text()));
                    $("#payment").val(parseFloat(button.parent().parent().parent().prev().prev().text()));
                    $("#pDiv").prop("hidden", false);
                    var modal = $(this);
                    modal.find('.modal-title').text('Edit Order');
                    $("#modalBtn").val("Edit");
                    $("#orderOp").val("Edit");
                }
            });
            $('#orderModal').on('hidden.bs.modal', function () {
                // do something…
                if (add) {
                    $('#myDropdown2').find('option').get(0).remove();
                    alert("remove");
                    add = false;
                }
            })



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

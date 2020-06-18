<%-- 
    Document   : CustomerRentHistoryPage
    Created on : May 21, 2020, 4:16:36 AM
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
        <title>Rent History</title>
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
            ArrayList<Order> array = AdminHandler.rentHistory("customerId", Integer.parseInt(request.getParameter("custId")));
            

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

                table += "     </div>";
                table += "   </div>";
                table += "    </td>";
                table += "  </tr>";

            }

          

        %>

      

    </head>

    <body>


      
        <div class="main-content" id="panel">

            <!-- Header -->
            <!-- Header -->
            <div class="header bg-default pb-6">
               

                <div class="container-fluid">
                    <div class="header-body">

                        <div class="row align-items-center py-4">
                            <div class="col-lg-6 col-7">
                                <h6 class="h2 text-white d-inline-block mb-0"><%= request.getParameter("custName") %>&nbsp;</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4"> </nav>
                            </div>
                           
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
                                <h3 class="mb-0">Rent History&nbsp;</h3>
                            </div>
                            <!-- Light table -->
                            <div class="table-responsive">
                                <table class="table align-items-center table-flush">
                                    <thead class="thead-light">
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
       


       
        <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="../assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="../assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <!-- Argon JS -->
        <script src="../assets/js/argon.js?v=1.2.0"></script> 

     

    </body>

</html>

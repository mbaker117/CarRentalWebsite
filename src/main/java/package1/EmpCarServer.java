/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author moham
 */
@WebServlet(name = "EmpCarServer", urlPatterns = {"/EmpCarServer"})
public class EmpCarServer extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("carOp");
        int id = Integer.parseInt(request.getParameter("carId").trim());
        if (!op.equals("Delete")) {

            int vin = Integer.parseInt(request.getParameter("vin").trim());
            String plateNumber = request.getParameter("plateNumber").trim();
            int seats = Integer.parseInt(request.getParameter("seats").trim());
            String maker = request.getParameter("maker").trim();
            String modelName = request.getParameter("modelName").trim();
            int modelYear = Integer.parseInt(request.getParameter("modelYear").trim());
            int categoryId = Integer.parseInt(request.getParameter("categoryId").trim());
            float meterReading = Float.parseFloat(request.getParameter("meterReading").trim());
            boolean isRented = request.getParameter("rented").equals("yes");
            boolean isAvailable = request.getParameter("available").equals("yes");
            try {
                if (op.equals("Add")) {
                    int res = EmployeeHandler.addCar(new Car(0, vin, plateNumber, seats, maker, modelName, modelYear, meterReading, categoryId, isRented, isAvailable));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminCarOp", "add");
                    session.setAttribute("adminCarRes", res);
                } else {
                    int res = EmployeeHandler.editCar(new Car(id, vin, plateNumber, seats, maker, modelName, modelYear, meterReading, categoryId, isRented, isAvailable));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminCarOp", "edit");
                    session.setAttribute("adminCarRes", res);
                }

            } catch (SQLException ex) {
                
            }
        } else {
            int res = EmployeeHandler.deleteCar(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminCarOp", "delete");
            session.setAttribute("adminCarRes", res);
        }
        response.sendRedirect("/web2/pages/EmpCarsPage.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

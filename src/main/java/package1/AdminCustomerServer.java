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
@WebServlet(name = "AdminCustomerServer", urlPatterns = {"/AdminCustomerServer"})
public class AdminCustomerServer extends HttpServlet {

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
       String op = request.getParameter("custOp");
        int id = Integer.parseInt(request.getParameter("custId").trim());
        if (!op.equals("Delete")) {

            String username = request.getParameter("username").trim();
            String password = request.getParameter("password").trim();
            String firstName = request.getParameter("firstName").trim();
            String lastName = request.getParameter("lastName").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();
            String email = request.getParameter("email").trim();
            String address = request.getParameter("address").trim();
            boolean isActive = request.getParameter("active").equals("yes");
            boolean isDriving = request.getParameter("driving").equals("yes");
            try {
                if (op.equals("Add")) {
                    int res = AdminHandler.addCustomer(new Customers(0, username, password, email, firstName, lastName, address, phoneNumber, isActive, isDriving));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminCustOp", "add");
                    session.setAttribute("adminCustRes", res);
                } else {
                    int res = AdminHandler.editCustomer(new Customers(id, username, password, email, firstName, lastName, address, phoneNumber, isActive, isDriving));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminCustOp", "edit");
                    session.setAttribute("adminCustRes", res);
                }

            } catch (SQLException ex) {
                Logger.getLogger(EmployeeServer.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            int res = AdminHandler.deleteCustomer(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminCustOp", "delete");
            session.setAttribute("adminCustRes", res);
        }
        response.sendRedirect("/web2/pages/AdminCustomerPage.jsp");
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

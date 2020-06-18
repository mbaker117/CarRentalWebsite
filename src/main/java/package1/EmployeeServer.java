/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

import java.io.IOException;
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
@WebServlet(name = "EmployeeServer", urlPatterns = {"/EmployeeServer"})
public class EmployeeServer extends HttpServlet {

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
        String op = request.getParameter("empOp");
        int id = Integer.parseInt(request.getParameter("empId").trim());
        if (!op.equals("Delete")) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            boolean isActive = request.getParameter("active").equals("yes");
            try {
                if (op.equals("Add")) {
                    int res = AdminHandler.addEmployee(new Employee(0, username, password, email, firstName, lastName, address, phoneNumber, isActive));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminEmpOp", "add");
                    session.setAttribute("adminEmpRes", res);
                } else {
                    int res = AdminHandler.editEmployee(new Employee(id, username, password, email, firstName, lastName, address, phoneNumber, isActive));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminEmpOp", "edit");
                    session.setAttribute("adminEmpRes", res);
                }

            } catch (SQLException ex) {
                Logger.getLogger(EmployeeServer.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            int res = AdminHandler.deleteEmployee(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminEmpOp", "delete");
            session.setAttribute("adminEmpRes", res);
        }
        response.sendRedirect("/web2/pages/AdminEmployeePage.jsp");
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

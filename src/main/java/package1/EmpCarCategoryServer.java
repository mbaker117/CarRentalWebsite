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
@WebServlet(name = "EmpCarCategoryServer", urlPatterns = {"/EmpCarCategoryServer"})
public class EmpCarCategoryServer extends HttpServlet {

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
          String op = request.getParameter("catOp");
        int id = Integer.parseInt(request.getParameter("catId").trim());
        if (!op.equals("Delete")) {

            String name = request.getParameter("name");
            float pricePerKm = Float.parseFloat(request.getParameter("pricePerKm").trim());
            float pricePerDay = Float.parseFloat(request.getParameter("pricePerDay").trim());
           
          
                if (op.equals("Add")) {
                    int res = EmployeeHandler.addCarCategory(new CarCategory(0, name, pricePerDay, pricePerKm));

                    HttpSession session = request.getSession();
                    session.setAttribute("adminCatOp", "add");
                    session.setAttribute("adminCatRes", res);
                } else {
                      int res = EmployeeHandler.editCarCategory(new CarCategory(id, name, pricePerDay, pricePerKm));
                    HttpSession session = request.getSession();
                    session.setAttribute("adminCatOp", "edit");
                    session.setAttribute("adminCatRes", res);
                }

            
        } else {
            int res = EmployeeHandler.deleteCarCategory(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminCatOp", "delete");
            session.setAttribute("adminCatRes", res);
        }
        response.sendRedirect("/web2/pages/EmpCarCategoryPage.jsp");
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

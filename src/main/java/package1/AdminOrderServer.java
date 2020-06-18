/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "AdminOrderServer", urlPatterns = {"/AdminOrderServer"})
public class AdminOrderServer extends HttpServlet {

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
        String op = request.getParameter("orderOp");
        int id = Integer.parseInt(request.getParameter("orderId").trim());
        if (!op.equals("Delete") && !op.equals("Check")) {

            int customerId = Integer.parseInt(request.getParameter("customerId").trim());
            int carId = Integer.parseInt(request.getParameter("carId").trim());
            int days = Integer.parseInt(request.getParameter("days").trim());

            float rentDistance = Float.parseFloat(request.getParameter("rentDisatnce").trim());

             float additionalFees = Float.parseFloat(request.getParameter("additionalFees").trim());
            if (op.equals("Add")) {
                 int res = AdminHandler.addOrder(new Order(0, customerId, carId,0, rentDistance, days, additionalFees, 0, true, 0));

                  HttpSession session = request.getSession();
                    session.setAttribute("adminOrderOp", "add");
                    session.setAttribute("adminOrderRes", res);
            } else {
                float payment = Float.parseFloat(request.getParameter("payment").trim());
                 int res = AdminHandler.editOrder(new Order(id, customerId, carId,0, rentDistance, days, additionalFees, 0, true, payment));
                    HttpSession session = request.getSession();
                    session.setAttribute("adminOrderOp", "edit");
                    session.setAttribute("adminOrderRes", res);
            }

        } else {
            if(op.equals("Delete")){
            int res = AdminHandler.deleteOrder(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminOrderOp", "delete");
            session.setAttribute("adminOrderRes", res);
            }else{
                int res = AdminHandler.checkOut(id);

            HttpSession session = request.getSession();
            session.setAttribute("adminOrderOp", "check");
            session.setAttribute("adminOrderRes", res); 
            }
        }
        response.sendRedirect("/web2/pages/AdminOrderPage.jsp");
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

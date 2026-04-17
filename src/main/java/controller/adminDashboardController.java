package controller;

import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "adminDashboardController", urlPatterns = {"/admin/dashboard"})
public class adminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("ADMIN".equals(user.getRole())) {
                java.util.List<model.AdminRentalDTO> allRentals = 
                    service.RentalService.getInstance().getAllRentalsWithUsers();
                
                double totalRevenue = 0;
                for(model.AdminRentalDTO r : allRentals) {
                    totalRevenue += r.getTotalCost();
                }
                
                request.setAttribute("adminUser", user);
                request.setAttribute("allRentals", allRentals);
                request.setAttribute("activeUnits", allRentals.size());
                request.setAttribute("totalRevenue", totalRevenue);
                
                request.getRequestDispatcher("/WEB-INF/pages/admin_dashboard.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}

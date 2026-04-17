package controller;

import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "dashboardController", urlPatterns = {"/dashboard"})
public class dashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            
            // Fetch real rentals from service
            java.util.List<model.Rental> activeRentals = 
                service.RentalService.getInstance().getRentalsByUserId(user.getId());
            
            request.setAttribute("user", user);
            request.setAttribute("rentals", activeRentals);
            request.setAttribute("rentalCount", activeRentals.size());
            
            request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }
}

package controller;

import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

package controller;

import model.User;
import service.RentalService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "cancelController", urlPatterns = {"/cancel"})
public class cancelController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String rentalIdParam = request.getParameter("rentalId");
        if (rentalIdParam != null && !rentalIdParam.isEmpty()) {
            try {
                int rentalId = Integer.parseInt(rentalIdParam);
                RentalService.getInstance().cancelRental(rentalId, user.getId());
            } catch (NumberFormatException e) {
                // Ignore invalid
            }
        }
        
        response.sendRedirect("dashboard?panel=bookings");
    }
}

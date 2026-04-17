package controller;

import model.User;
import service.RentalService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "bookController", urlPatterns = {"/book"})
public class bookController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        String carIdParam = request.getParameter("carId");
        
        // Ensure user is logged in
        if (user == null) {
            if (carIdParam != null) {
                session.setAttribute("pendingBookingCarId", carIdParam);
            }
            response.sendRedirect("login");
            return;
        }

        if (carIdParam != null && !carIdParam.isEmpty()) {
            try {
                int carId = Integer.parseInt(carIdParam);
                RentalService.getInstance().bookCar(carId, user.getId());
                session.removeAttribute("pendingBookingCarId"); // Clear if it was pending
            } catch (NumberFormatException e) {
                // Ignore invalid
            }
        }
        
        response.sendRedirect("dashboard");
    }
}

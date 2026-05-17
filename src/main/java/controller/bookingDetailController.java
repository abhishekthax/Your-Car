package controller;

import model.Rental;
import model.Car;
import model.User;
import service.RentalService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "bookingDetailController", urlPatterns = {"/booking-detail"})
public class bookingDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("dashboard");
            return;
        }

        try {
            int rentalId = Integer.parseInt(idParam);
            Rental rental = RentalService.getInstance().getRentalById(rentalId);

            // Security check: Ensure the booking belongs to the logged-in user
            if (rental == null || rental.getUserId() != user.getId()) {
                response.sendRedirect("dashboard");
                return;
            }

            Car car = RentalService.getInstance().getCarById(rental.getCarId());
            
            request.setAttribute("rental", rental);
            request.setAttribute("car", car);
            request.getRequestDispatcher("/WEB-INF/pages/booking_detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard");
        }
    }
}

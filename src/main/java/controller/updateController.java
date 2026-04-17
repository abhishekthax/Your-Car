package controller;

import model.User;
import model.Car;
import model.Rental;
import service.RentalService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "updateController", urlPatterns = {"/update"})
public class updateController extends HttpServlet {

    /**
     * GET /update?rentalId=X  — show the fleet so user can pick a new car
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String rentalIdParam = request.getParameter("rentalId");
        if (rentalIdParam == null || rentalIdParam.isEmpty()) {
            response.sendRedirect("dashboard");
            return;
        }

        try {
            int rentalId = Integer.parseInt(rentalIdParam);
            Rental rental = RentalService.getInstance().getRentalById(rentalId);

            if (rental == null || rental.getUserId() != user.getId()) {
                response.sendRedirect("dashboard");
                return;
            }

            List<Car> fleet = RentalService.getInstance().getFleet();

            request.setAttribute("rental", rental);
            request.setAttribute("fleet", fleet);
            request.getRequestDispatcher("/WEB-INF/pages/update_booking.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard");
        }
    }

    /**
     * POST /update  — apply the car swap and redirect to dashboard
     */
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
        String newCarIdParam  = request.getParameter("newCarId");

        if (rentalIdParam != null && newCarIdParam != null) {
            try {
                int rentalId = Integer.parseInt(rentalIdParam);
                int newCarId  = Integer.parseInt(newCarIdParam);
                RentalService.getInstance().updateRental(rentalId, newCarId, user.getId());
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        response.sendRedirect("dashboard");
    }
}

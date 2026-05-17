package controller;

import dbconfig.dbconfig;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "loginController", urlPatterns = {"/login"})
public class loginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";

        // Admin check: BOTH email AND password must match exactly
        boolean isAdminEmail = "admin@ridenepal.com".equalsIgnoreCase(email);
        boolean isAdminPassword = "admin123".equals(password);

        if (isAdminEmail && isAdminPassword) {
            // Valid admin — grant access
            HttpSession session = request.getSession();
            model.User adminUser = new model.User(0, "System Admin", email, password, "ADMIN");
            session.setAttribute("user", adminUser);
            response.sendRedirect("admin/dashboard");
            return;
        } else if (isAdminPassword && !isAdminEmail) {
            // Correct admin password, wrong email — reject with error
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        try {
            if (util.Validator.isNullOrEmpty(email)) {
                throw new exception.ValidationException("Please fill up the email.");
            }
            if (!util.Validator.isValidEmail(email)) {
                throw new exception.ValidationException("Invalid email format. Please add a valid email.");
            }
            if (util.Validator.isNullOrEmpty(password)) {
                throw new exception.ValidationException("Please fill up the password.");
            }

            // Regular user login via database
            model.User user = service.RentalService.getInstance().validateUser(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Check for pending booking
                String pendingCarId = (String) session.getAttribute("pendingBookingCarId");
                if (pendingCarId != null) {
                    try {
                        service.RentalService.getInstance().bookCar(Integer.parseInt(pendingCarId), user.getId());
                        session.removeAttribute("pendingBookingCarId");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                
                response.sendRedirect("dashboard");
            } else {
                throw new exception.ValidationException("Invalid email or password.");
            }
        } catch (exception.ValidationException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}

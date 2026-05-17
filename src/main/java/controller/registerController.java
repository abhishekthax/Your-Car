package controller;

import dbconfig.dbconfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "registerController", urlPatterns = {"/register"})
public class registerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (util.Validator.isNullOrEmpty(fullName)) {
                throw new exception.ValidationException("Please fill up your full name.");
            }
            if (util.Validator.isNullOrEmpty(email)) {
                throw new exception.ValidationException("Please fill up the email.");
            }
            if (!util.Validator.isValidEmail(email)) {
                throw new exception.ValidationException("Invalid email format. Please add a valid email.");
            }
            if (util.Validator.isNullOrEmpty(password)) {
                throw new exception.ValidationException("Please fill up the password.");
            }
            if (!util.Validator.isValidPassword(password)) {
                throw new exception.ValidationException("Password must be at least 6 characters.");
            }

            // Check for existing user
            if (service.RentalService.getInstance().getUserByEmail(email) != null) {
                throw new exception.DuplicateAccountException("Email already registered. Please try another or sign in.");
            }

            model.User user = new model.User(0, fullName, email, password, "STUDENT");
            boolean success = service.RentalService.getInstance().addUser(user);

            if (success) {
                response.sendRedirect("login");
            } else {
                throw new exception.ValidationException("Registration failed. Please try again.");
            }
        } catch (exception.ValidationException | exception.DuplicateAccountException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "homeController", urlPatterns = {"/home", ""})
public class homeController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Fetch the car fleet from service
        java.util.List<model.Car> fleet = service.RentalService.getInstance().getFleet();
        request.setAttribute("fleet", fleet);
        
        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }
}

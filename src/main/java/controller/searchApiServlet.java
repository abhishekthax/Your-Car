package controller;

import service.RentalService;
import model.Car;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "searchApiServlet", urlPatterns = {"/api/search"})
public class searchApiServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (query == null || query.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        // Use Binary Search for high-speed lookup (Coursework Requirement)
        Car foundCar = RentalService.getInstance().searchCarByModel(query.trim());
        
        List<Car> results = new ArrayList<>();
        if (foundCar != null) {
            results.add(foundCar);
        } else {
            // Fallback: If no exact match via binary search, find partial matches (UX improvement)
            List<Car> fleet = RentalService.getInstance().getFleet();
            for (Car car : fleet) {
                if (car.getModel().toLowerCase().contains(query.toLowerCase()) || 
                    car.getMake().toLowerCase().contains(query.toLowerCase())) {
                    results.add(car);
                }
                if (results.size() >= 5) break; // Limit results
            }
        }

        response.getWriter().write(gson.toJson(results));
    }
}

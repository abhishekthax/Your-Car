package controller;

import service.RentalService;
import model.Car;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "searchController", urlPatterns = {"/search"})
public class searchController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");
        
        if (query != null && !query.trim().isEmpty()) {
            String q = query.trim().toLowerCase();
            // 1. Try Exact Match via Binary Search
            Car foundCar = RentalService.getInstance().searchCarByModel(query.trim());
            
            if (foundCar != null) {
                request.setAttribute("searchResult", foundCar);
            } else {
                // 2. Try Partial Match if Binary Search (exact) fails
                List<Car> fleet = RentalService.getInstance().getFleet();
                Car partialMatch = null;
                for (Car car : fleet) {
                    if (car.getModel().toLowerCase().contains(q) || 
                        car.getMake().toLowerCase().contains(q)) {
                        partialMatch = car;
                        break;
                    }
                }
                
                if (partialMatch != null) {
                    request.setAttribute("searchResult", partialMatch);
                    request.setAttribute("searchMsg", "Showing closest match for '" + query + "'");
                } else {
                    request.setAttribute("searchError", "No vehicle found with model name: " + query);
                }
            }
        }
        
        // Return to home page with results
        request.setAttribute("fleet", RentalService.getInstance().getFleet());
        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }
}

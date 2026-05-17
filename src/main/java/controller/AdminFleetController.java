package controller;

import model.Car;
import model.User;
import service.RentalService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminFleetController", urlPatterns = {"/admin/fleet", "/admin/fleet/add", "/admin/fleet/update", "/admin/fleet/delete"})
public class AdminFleetController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Car> fleet = RentalService.getInstance().getFleet();
        request.setAttribute("fleet", fleet);
        request.getRequestDispatcher("/WEB-INF/pages/admin_fleet.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        RentalService service = RentalService.getInstance();

        try {
            if (path.contains("/add")) {
                Car car = extractCarFromRequest(request);
                service.addCar(car);
            } else if (path.contains("/update")) {
                Car car = extractCarFromRequest(request);
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    car.setId(Integer.parseInt(idStr));
                    service.updateCar(car);
                }
            } else if (path.contains("/delete")) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    service.deleteCar(Integer.parseInt(idStr));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/fleet");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return "ADMIN".equals(user.getRole());
        }
        return false;
    }

    private Car extractCarFromRequest(HttpServletRequest request) {
        Car car = new Car();
        car.setMake(request.getParameter("make"));
        car.setModel(request.getParameter("model"));
        car.setType(request.getParameter("type"));
        car.setTransmission(request.getParameter("transmission"));
        
        String priceStr = request.getParameter("pricePerDay");
        if (priceStr != null) car.setPricePerDay(Double.parseDouble(priceStr));
        
        car.setImageUrl(request.getParameter("imageUrl"));
        car.setStatus(request.getParameter("status"));
        
        String hpStr = request.getParameter("hp");
        if (hpStr != null) car.setHp(Integer.parseInt(hpStr));
        
        car.setAccel060(request.getParameter("accel060"));
        
        return car;
    }
}

package service;

import model.User;
import model.Car;
import model.Rental;
import dbconfig.dbconfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;
import java.util.Stack;
import java.util.LinkedList;

public class RentalService {
    private static RentalService instance;
    private final Queue<Rental> reservationQueue = new LinkedList<>();
    private final Stack<Rental> cancellationStack = new Stack<>();

    private RentalService() {}

    public static synchronized RentalService getInstance() {
        if (instance == null) {
            instance = new RentalService();
        }
        return instance;
    }

    // User Methods
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (fullName, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User validateUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Fleet Methods
    public List<Car> getFleet() {
        List<Car> fleet = new ArrayList<>();
        String sql = "SELECT * FROM cars";
        try (Connection conn = dbconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                int hp = 0;
                String accel060 = "N/A";
                try { hp = rs.getInt("hp"); } catch (SQLException ignored) {}
                try { accel060 = rs.getString("accel060"); } catch (SQLException ignored) {}
                fleet.add(new Car(
                    rs.getInt("id"),
                    rs.getString("make"),
                    rs.getString("model"),
                    rs.getString("type"),
                    rs.getString("transmission"),
                    rs.getDouble("pricePerDay"),
                    rs.getString("imageUrl"),
                    rs.getString("status"),
                    hp,
                    accel060
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fleet;
    }

    // Rental Methods
    public Rental getRentalById(int rentalId) {
        String sql = "SELECT * FROM rentals WHERE id = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, rentalId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Rental(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carId"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getString("status"),
                        rs.getDouble("totalCost"),
                        rs.getString("carInfo")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Rental> getRentalsByUserId(int userId) {
        List<Rental> userRentals = new ArrayList<>();
        String sql = "SELECT * FROM rentals WHERE userId = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userRentals.add(new Rental(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carId"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getString("status"),
                        rs.getDouble("totalCost"),
                        rs.getString("carInfo")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userRentals;
    }

    public Car getCarById(int carId) {
        String sql = "SELECT * FROM cars WHERE id = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int hp = 0;
                    String accel060 = "N/A";
                    try { hp = rs.getInt("hp"); } catch (SQLException ignored) {}
                    try { accel060 = rs.getString("accel060"); } catch (SQLException ignored) {}
                    return new Car(
                        rs.getInt("id"),
                        rs.getString("make"),
                        rs.getString("model"),
                        rs.getString("type"),
                        rs.getString("transmission"),
                        rs.getDouble("pricePerDay"),
                        rs.getString("imageUrl"),
                        rs.getString("status"),
                        hp,
                        accel060
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void bookCar(int carId, int userId) {
        Car car = getCarById(carId);
        if (car != null) {
            String carTitle = car.getMake() + " " + car.getModel();
            Rental rental = new Rental(0, userId, carId, "Active Now", "48 Hours", "Active", car.getPricePerDay() * 2, carTitle);
            
            // USE QUEUE: Add to pending queue before processing
            reservationQueue.add(rental);
            
            // Process queue - in a real app this might be async, but here we process it immediately
            Rental nextRental = reservationQueue.poll();
            if (nextRental != null) {
                String sql = "INSERT INTO rentals (userId, carId, startDate, endDate, status, totalCost, carInfo) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (Connection conn = dbconfig.getConnection();
                     PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, nextRental.getUserId());
                    ps.setInt(2, nextRental.getCarId());
                    ps.setString(3, nextRental.getStartDate());
                    ps.setString(4, nextRental.getEndDate());
                    ps.setString(5, nextRental.getStatus());
                    ps.setDouble(6, nextRental.getTotalCost());
                    ps.setString(7, nextRental.getCarInfo());
                    ps.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    public void cancelRental(int rentalId, int userId) {
        // USE STACK: Store in cancellation history
        Rental rental = getRentalById(rentalId);
        if (rental != null && rental.getUserId() == userId) {
            cancellationStack.push(rental);

            String sql = "DELETE FROM rentals WHERE id = ? AND userId = ?";
            try (Connection conn = dbconfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, rentalId);
                ps.setInt(2, userId);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void updateRental(int rentalId, int newCarId, int userId) {
        Car newCar = getCarById(newCarId);
        if (newCar == null) return;

        Rental rental = getRentalById(rentalId);
        if (rental == null || rental.getUserId() != userId) return;

        String newCarInfo = newCar.getMake() + " " + newCar.getModel();
        double newCost = newCar.getPricePerDay() * 2;

        String sql = "UPDATE rentals SET carId = ?, carInfo = ?, totalCost = ? WHERE id = ? AND userId = ?";
        try (Connection conn = dbconfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newCarId);
            ps.setString(2, newCarInfo);
            ps.setDouble(3, newCost);
            ps.setInt(4, rentalId);
            ps.setInt(5, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<model.AdminRentalDTO> getAllRentalsWithUsers() {
        List<model.AdminRentalDTO> allRentals = new ArrayList<>();
        String sql = "SELECT r.*, u.fullName, c.imageUrl FROM rentals r " +
                    "JOIN users u ON r.userId = u.id " +
                    "JOIN cars c ON r.carId = c.id";
        try (Connection conn = dbconfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                allRentals.add(new model.AdminRentalDTO(
                    rs.getInt("id"),
                    rs.getString("fullName"),
                    rs.getString("carInfo"),
                    rs.getString("imageUrl"),
                    rs.getString("startDate"),
                    rs.getString("endDate"),
                    rs.getString("status"),
                    rs.getDouble("totalCost")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allRentals;
    }
}

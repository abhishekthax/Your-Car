package model;

import java.io.Serializable;

public class AdminRentalDTO implements Serializable {
    private int id;
    private String renterName;
    private String carTitle;
    private String carImage;
    private String startDate;
    private String endDate;
    private String status;
    private double totalCost;
    private String fuelStatus; // Mocked for UI
    private String tirePressure; // Mocked for UI
    private String serviceDue; // Mocked for UI

    public AdminRentalDTO(int id, String renterName, String carTitle, String carImage, 
                         String startDate, String endDate, String status, double totalCost) {
        this.id = id;
        this.renterName = renterName;
        this.carTitle = carTitle;
        this.carImage = carImage;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.totalCost = totalCost;
        
        // Static mocks for UI fidelity to the reference image
        this.fuelStatus = "85%";
        this.tirePressure = "Optimal";
        this.serviceDue = "1,240 mi";
    }

    // Getters
    public int getId() { return id; }
    public String getRenterName() { return renterName; }
    public String getCarTitle() { return carTitle; }
    public String getCarImage() { return carImage; }
    public String getStartDate() { return startDate; }
    public String getEndDate() { return endDate; }
    public String getStatus() { return status; }
    public double getTotalCost() { return totalCost; }
    public String getFuelStatus() { return fuelStatus; }
    public String getTirePressure() { return tirePressure; }
    public String getServiceDue() { return serviceDue; }
}

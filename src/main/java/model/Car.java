package model;

import java.io.Serializable;

public class Car implements Serializable {
    private int id;
    private String make;
    private String model;
    private String type;
    private String transmission;
    private double pricePerDay;
    private String imageUrl;
    private String status;
    private int hp;
    private String accel060;

    public Car() {}

    public Car(int id, String make, String model, String type, String transmission, double pricePerDay, String imageUrl, String status, int hp, String accel060) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.type = type;
        this.transmission = transmission;
        this.pricePerDay = pricePerDay;
        this.imageUrl = imageUrl;
        this.status = status;
        this.hp = hp;
        this.accel060 = accel060;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getMake() { return make; }
    public void setMake(String make) { this.make = make; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getTransmission() { return transmission; }
    public void setTransmission(String transmission) { this.transmission = transmission; }
    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getHp() { return hp; }
    public void setHp(int hp) { this.hp = hp; }
    public String getAccel060() { return accel060; }
    public void setAccel060(String accel060) { this.accel060 = accel060; }
}

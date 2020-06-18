/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

/**
 *
 * @author moham
 */
public class Car {
    private int id;
    private int vin;
    private String plateNumber;
    private int seats;
    private String maker;
    private String modelName;
    private int modelYear;
    private float odoMeter;
    private int categoryId;
    private boolean rented;
    private boolean available;

    public Car(int id, int vin, String plateNumber, int seats, String maker, String modelName, int modelYear, float odoMeter, int categoryId, boolean rented, boolean available) {
        this.id = id;
        this.vin = vin;
        this.plateNumber = plateNumber;
        this.seats = seats;
        this.maker = maker;
        this.modelName = modelName;
        this.modelYear = modelYear;
        this.odoMeter = odoMeter;
        this.categoryId = categoryId;
        this.rented = rented;
        this.available = available;
    }

    public int getSeats() {
        return seats;
    }

    

    public int getId() {
        return id;
    }

    public int getVin() {
        return vin;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public String getMaker() {
        return maker;
    }

    public String getModelName() {
        return modelName;
    }

    public int getModelYear() {
        return modelYear;
    }

    public float getOdoMeter() {
        return odoMeter;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public boolean isRented() {
        return rented;
    }

    public boolean isAvailable() {
        return available;
    }
    
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

/**
 *
 * @author moham
 */public class Order {

    private int id;
    private int customerId;
    private int carId;
    private float odoMeterReading;
    private float rentDistance;
    private int numberOfDays;
    private float additionalFees;
    private float totalCost;
    private boolean checkOut;
    private float payment;

    public Order(int id, int customerId, int carId, float odoMeterReading, float rentDistance, int numberOfDays, float additionalFees, float totalCost, boolean checkOut, float payment) {
        this.id = id;
        this.customerId = customerId;
        this.carId = carId;
        this.odoMeterReading = odoMeterReading;
        this.rentDistance = rentDistance;
        this.numberOfDays = numberOfDays;
        this.additionalFees = additionalFees;
        this.totalCost = totalCost;
        this.checkOut = checkOut;
        this.payment = payment;
    }

    public int getId() {
        return id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public int getCarId() {
        return carId;
    }

    public float getOdoMeterReading() {
        return odoMeterReading;
    }

    public float getRentDistance() {
        return rentDistance;
    }

    public int getNumberOfDays() {
        return numberOfDays;
    }

    public float getAdditionalFees() {
        return additionalFees;
    }

    public float getTotalCost() {
        return totalCost;
    }

    public boolean isCheckOut() {
        return checkOut;
    }

    public float getPayment() {
        return payment;
    }

}

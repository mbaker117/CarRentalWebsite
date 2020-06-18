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

public class CarCategory {
    private int id;
    private String name;
    private float pricePerDay;
    private  float pricePerKm;

    public CarCategory(int id, String name, float pricePerDay, float pricePerKm) {
        this.id = id;
        this.name = name;
        this.pricePerDay = pricePerDay;
        this.pricePerKm = pricePerKm;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public float getPricePerDay() {
        return pricePerDay;
    }

    public float getPricePerKm() {
        return pricePerKm;
    }
    
    
}

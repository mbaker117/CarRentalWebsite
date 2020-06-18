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
public class Customers {
    private int id;
    private String  username;
    private String  password;
    private String  email;
    private String  firstName;
    private String  lastName;
    private String  address;
    private String  phoneNumber;
    private boolean  isActive;
    private boolean drivingLiecnse;



    public Customers(int id, String username, String password, String email, String firstName, String lastName, String address, String phoneNumber, boolean isActive, boolean drivingLiecnse) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.isActive = isActive;
        this.drivingLiecnse = drivingLiecnse;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getAddress() {
        return address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public boolean isDrivingLiecnse() {
        return drivingLiecnse;
    }
    
}


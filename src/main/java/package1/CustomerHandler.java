/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package package1;

import com.mysql.cj.conf.PropertyKey;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

/**
 *
 * @author moham
 */
public class CustomerHandler {

    private static Connection connection;
    private final static String URL = "jdbc:mysql://localhost:3308/project?autoReconnect=true&useSSL=false";

    public static int login(String username, String password) throws SQLException {
        try {
            if (connection == null) {
                connectWithDataBase();
            }
            PreparedStatement statment = connection.prepareStatement("select * from customer WHERE Username=?");

            statment.setString(1, username);

            ResultSet set = statment.executeQuery();
            if (set.next()) {

                if (set.getString("Password").equals(password) && set.getBoolean("IsActive")) {
                    return set.getInt("Id");
                } else {
                    closeConnection();
                    return -1;
                }

            } else {
                closeConnection();
                return -1;
            }
        } catch (Exception ex) {
            closeConnection();
            return -1;
        }
    }

    private static void connectWithDataBase() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        Properties info = new Properties();
        info.put("user", "root");
        info.put("password", "root@PSUT");
        connection = DriverManager.getConnection(URL, info);
    }

    public static int register(Customers cust) throws SQLException, ClassNotFoundException {
        if (connection == null) {
            connectWithDataBase();
        }
        String username = cust.getUsername();
        int id = isCustomerExist(-1, "Username", username);

        if (id == -1) {
            String phoneNumber = cust.getPhoneNumber();
            int id2 = isCustomerExist(-1, "PhoneNumber", phoneNumber);

            if (id2 == -1) {
                String email = cust.getEmail();
                int id3 = isCustomerExist(-1, "Email", email);

                if (id3 == -1) {
                    String password = cust.getPassword();
                    String firstName = cust.getFirstName();
                    String lastName = cust.getLastName();
                    String address = cust.getAddress();
                    boolean isActive = true;
                    boolean isDrive = cust.isDrivingLiecnse();
                    return addCustomer(username, password, firstName, lastName, address, email, phoneNumber, isActive, isDrive);

                } else {
                    return -4;
                }
            } else {
                return -3;
            }

        } else {
            return -2;
        }
    }

    private static int isCustomerExist(int id, String attribute, String data) throws SQLException {
        PreparedStatement statement = connection.prepareCall("select Id from customer where " + attribute + " = ? and id !=?");
        statement.setString(1, data);
        statement.setInt(2, id);
        ResultSet set = statement.executeQuery();
        if (set.next()) {
            return set.getInt("Id");
        }

        return -1;

    }

    private static int addCustomer(String username, String password, String firstName, String lastName, String address, String email, String phoneNumber, boolean isActive, boolean drivingLicense) {
        try {
            PreparedStatement statement = connection.prepareStatement("insert into customer (Username,Password,FirstName,LastName"
                    + ",Address,Email,PhoneNumber,IsActive,ValidDrivingLicense) values(?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, address);
            statement.setString(6, email);
            statement.setString(7, phoneNumber);
            statement.setBoolean(8, isActive);
            statement.setBoolean(9, drivingLicense);
            statement.executeUpdate();
            ResultSet set = statement.getGeneratedKeys();
            if (set.next()) {
                return set.getInt(1);
            } else {
                return -1;
            }

        } catch (SQLException e) {
            return -1;
        }
    }

    private static void closeConnection() throws SQLException {
        connection.close();
        connection = null;
    }

    public static ArrayList<Order> retriveOrders(int id, boolean all) throws SQLException, IOException, ClassNotFoundException {

        Statement statment = connection.createStatement();

        String sql = "";
        if (all) {
            sql = "select * from orders where CustomerId='" + id + "' order by Id ";
        } else {
            sql = "select * from orders where CustomerId='" + id + "' and CheckOut='0' order by Id ";
        }

        ResultSet set = statment.executeQuery(sql);

        ArrayList<Order> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Order(set.getInt("Id"), set.getInt("CustomerId"), set.getInt("CarId"),
                    set.getFloat("OdoMeterReading"), set.getFloat("RentDistance"), set.getInt("NumberOfDay"), set.getFloat("AdditionalFees"),
                    set.getFloat("TotalCost"), set.getBoolean("CheckOut"), set.getFloat("Payments")));

        }

        return array;
    }

    public static ArrayList<Integer> retriveAvailableCars() throws SQLException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from cars where IsRented ='0' and IsAvaliable='1' order by Id ");

        ArrayList<Integer> list = new ArrayList<>();

        while (set.next()) {

            list.add(set.getInt("Id"));

        }
        return list;

    }

    public static String getCatName(int id) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("select Name from car_category where Id ='" + id + "'");
        while (set.next()) {
            return set.getString("Name");
        }
        return "N/A";
    }

    public static ArrayList<Car> retriveCars() throws SQLException, IOException {
        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from cars  where IsRented ='0' and IsAvaliable='1' order by Id ");

        ArrayList<Car> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Car(set.getInt("Id"), set.getInt("VIN"), set.getString("PlateNumber"),
                    set.getInt("NumberOfSeats"), set.getString("Maker"), set.getString("ModelName"), set.getInt("ModelYear"),
                    set.getFloat("MeterReading"), set.getInt("CategoryId"), set.getBoolean("IsRented"), set.getBoolean("IsAvaliable")));

        }

        return array;

    }

    public static int addOrder(Order order) {
        try {
            int customerId = order.getCustomerId();
            int carId = order.getCarId();
            int numberOfDays = order.getNumberOfDays();
            float rentDistance = order.getRentDistance();
            float additionalFees = order.getAdditionalFees();

            float odoMeter = 0;
            float totalCost = 0;
            float payment = order.getPayment();
            Statement carStatement = connection.createStatement();
            ResultSet carSet = carStatement.executeQuery("select * from cars where Id ='" + carId + "'");

            if (carSet.next()) {
                odoMeter = carSet.getFloat("MeterReading");
                int catergoryId = carSet.getInt("CategoryId");
                Statement categoryStatement = connection.createStatement();
                ResultSet categorySet = categoryStatement.executeQuery("select * from car_category where Id ='" + catergoryId + "'");
                if (categorySet.next()) {
                    float pricePerDay = categorySet.getFloat("PricePerDay");
                    float pricePerKm = categorySet.getFloat("PricePerKm");

                    totalCost = pricePerDay * numberOfDays + pricePerKm * rentDistance + additionalFees;
                }
            }

            PreparedStatement statement = connection.prepareStatement("insert into orders (CarId,CustomerId,OdoMeterReading,NumberOfDay"
                    + ",RentDistance,AdditionalFees,TotalCost) values(?,?,?,?,?,?,?)");
            statement.setInt(1, carId);
            statement.setInt(2, customerId);
            statement.setFloat(3, odoMeter);
            statement.setInt(4, numberOfDays);
            statement.setFloat(5, rentDistance);
            statement.setFloat(6, additionalFees);
            statement.setFloat(7, totalCost);

            statement.executeUpdate();
            rentCar(carId, 1);
            return 1;

        } catch (SQLException ex) {

            return -1;
        }

    }

    private static void rentCar(int id, int rent) throws SQLException {

        Statement statement = connection.createStatement();
        statement.executeUpdate("update cars set IsRented ='" + rent + "' where Id ='" + id + "'");

    }

    public static void logout() throws SQLException {
        connection.close();
        connection = null;
    }

}

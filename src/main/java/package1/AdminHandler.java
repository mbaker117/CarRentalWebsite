package package1;

import java.io.File;
import java.io.FileNotFoundException;
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
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author moham
 */
public class AdminHandler {

    private static Connection connection;
    private final static String URL = "jdbc:mysql://localhost:3308/project?autoReconnect=true&useSSL=false";

    public static boolean login(String username, String password) {
        
        
        try {
            if (connection == null) {
                connectWithDataBase();
            }
            PreparedStatement statment = connection.prepareStatement("select * from admin WHERE Username=?");

            statment.setString(1, username);

            ResultSet set = statment.executeQuery();
            if (set.next()) {

                if (set.getString("Password").equals(password) && set.getBoolean("IsActive")) {
                    return true;
                } else {
                    return false;
                }

            } else {
                return false;
            }
        } catch (Exception ex) {
            return false;
        }
    }

    private static void connectWithDataBase() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        Properties info = new Properties();
        info.put("user", "root");
        info.put("password", "root@PSUT");
        connection = DriverManager.getConnection(URL, info);
    }

    public static ArrayList<Employee> retriveEmployee() throws SQLException {
        ArrayList<Employee> array = new ArrayList<>();
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("select * from employee order by Id ");
        while (set.next()) {
            array.add(new Employee(set.getInt("Id"), set.getString("Username"), set.getString("Password"),
                    set.getString("Email"), set.getString("FirstName"), set.getString("LastName"), set.getString("Address"),
                    set.getString("PhoneNumber"), set.getBoolean("IsActive")));
        }

        return array;
    }

    public static int addEmployee(Employee employee) throws SQLException {
        String username = employee.getUsername();
        int id = isEmployeeExist(-1, "Username", username);

        if (id == -1) {
            String phoneNumber = employee.getPhoneNumber();
            int id2 = isEmployeeExist(-1, "PhoneNumber", phoneNumber);

            if (id2 == -1) {
                String email = employee.getEmail();
                int id3 = isEmployeeExist(-1, "Email", email);

                if (id3 == -1) {
                    String password = employee.getPassword();
                    String firstName = employee.getFirstName();
                    String lastName = employee.getLastName();
                    String address = employee.getAddress();
                    boolean isActive = employee.isIsActive();

                    boolean response = insertEmployee(username, password, firstName, lastName, address, email, phoneNumber, isActive);

                    if (response) {
                        return 1;
                    } else {
                        return -1;
                    }

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

    private static int isEmployeeExist(int id, String attribute, String data) throws SQLException {
        PreparedStatement statement = connection.prepareCall("select Id from employee where " + attribute + " = ? and id !=?");
        statement.setString(1, data);
        statement.setInt(2, id);
        ResultSet set = statement.executeQuery();
        if (set.next()) {
            return set.getInt("Id");
        }

        return -1;
    }

    private static boolean insertEmployee(String username, String password, String firstName, String lastName, String address, String email, String phoneNumber, boolean isActive) {
        try {
            PreparedStatement statement = connection.prepareStatement("insert into employee (Username,Password,FirstName,LastName"
                    + ",Address,Email,PhoneNumber,IsActive) values(?,?,?,?,?,?,?,?)");
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, address);
            statement.setString(6, email);
            statement.setString(7, phoneNumber);
            statement.setBoolean(8, isActive);

            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            try {
                PrintWriter out = new PrintWriter(new File("D:\\log.txt"));
                out.println(e.toString());
                out.flush();

            } catch (Exception ex) {

            }
            return false;
        }
    }

    public static int editEmployee(Employee emp) throws SQLException {

        int userId = emp.getId();
        String username = emp.getUsername();
        int id = isEmployeeExist(userId, "Username", username);

        if (id == -1) {
            String phoneNumber = emp.getPhoneNumber();
            int id2 = isEmployeeExist(userId, "PhoneNumber", phoneNumber);

            if (id2 == -1) {
                String email = emp.getEmail();
                int id3 = isEmployeeExist(userId, "Email", email);

                if (id3 == -1) {
                    String password = emp.getPassword();
                    String firstName = emp.getFirstName();

                    String lastName = emp.getLastName();
                    String address = emp.getAddress();
                    boolean isActive = emp.isIsActive();

                    boolean response = updateEmployee(userId, username, password, firstName, lastName, address, email, phoneNumber, isActive);
                    if (response) {
                        return 1;
                    } else {
                        return -1;
                    }
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

    private static boolean updateEmployee(int id, String username, String password, String firstName, String lastName, String address, String email, String phoneNumber, boolean active) {

        try {
            PreparedStatement statement = connection.prepareStatement("update employee set Username =? "
                    + ", Password = ? , FirstName = ? , LastName=? ,Email =? ,Address = ? ,PhoneNumber = ?"
                    + " , IsActive = ?  where Id = ?");
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, email);
            statement.setString(6, address);
            statement.setString(7, phoneNumber);
            statement.setBoolean(8, active);

            statement.setInt(9, id);

            statement.executeUpdate();
            return true;

        } catch (SQLException ex) {

        }
        return false;
    }

    public static int deleteEmployee(int userId) {
        try {

            Statement statement = connection.createStatement();

            statement.executeUpdate("delete from employee where Id='" + userId + "'");
            return 1;
        } catch (SQLException ex) {
            return -1;
        }
    }

    public static ArrayList<Customers> retriveCustomers() throws SQLException, IOException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from customer order by Id ");

        ArrayList<Customers> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Customers(set.getInt("Id"), set.getString("Username"), set.getString("Password"),
                    set.getString("Email"), set.getString("FirstName"), set.getString("LastName"), set.getString("Address"),
                    set.getString("PhoneNumber"), set.getBoolean("IsActive"), set.getBoolean("ValidDrivingLicense")));

        }

        return array;

    }

    public static int addCustomer(Customers cust) throws SQLException {
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
                    boolean isActive = cust.isIsActive();
                    boolean isDrive = cust.isDrivingLiecnse();
                    boolean response = addCustomer(username, password, firstName, lastName, address, email, phoneNumber, isActive, isDrive);
                    if (response) {
                        return 1;
                    } else {
                        return -1;
                    }

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

    private static boolean addCustomer(String username, String password, String firstName, String lastName, String address, String email, String phoneNumber, boolean isActive, boolean drivingLicense) {
        try {
            PreparedStatement statement = connection.prepareStatement("insert into customer (Username,Password,FirstName,LastName"
                    + ",Address,Email,PhoneNumber,IsActive,ValidDrivingLicense) values(?,?,?,?,?,?,?,?,?)");
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
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public static int editCustomer(Customers cust) throws SQLException {

        int userId = cust.getId();
        String username = cust.getUsername();
        int id = isCustomerExist(userId, "Username", username);

        if (id == -1) {
            String phoneNumber = cust.getPhoneNumber();
            int id2 = isCustomerExist(userId, "PhoneNumber", phoneNumber);

            if (id2 == -1) {
                String email = cust.getEmail();
                int id3 = isCustomerExist(userId, "Email", email);

                if (id3 == -1) {
                    String password = cust.getPassword();
                    String firstName = cust.getFirstName();
                    String lastName = cust.getLastName();
                    String address = cust.getAddress();
                    boolean isActive = cust.isIsActive();
                    boolean isDrive = cust.isDrivingLiecnse();
                    boolean response = updateCustomer(userId, username, password, firstName, lastName, address, email, phoneNumber, isActive, isDrive);
                    if (response) {
                        return 1;
                    } else {
                        return -1;
                    }

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

    private static boolean updateCustomer(int id, String username, String password, String firstName, String lastName, String address, String email, String phoneNumber, boolean active, boolean drive) {
        try {
            PreparedStatement statement = connection.prepareStatement("update customer set Username =? "
                    + ", Password = ? , FirstName = ? , LastName=? ,Email =? ,Address = ? ,PhoneNumber = ?"
                    + " , IsActive = ? ,ValidDrivingLicense =? where Id = ?");
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, firstName);
            statement.setString(4, lastName);
            statement.setString(5, email);
            statement.setString(6, address);
            statement.setString(7, phoneNumber);
            statement.setBoolean(8, active);
            statement.setBoolean(9, drive);
            statement.setInt(10, id);

            statement.executeUpdate();
            return true;

        } catch (SQLException ex) {

        }
        return false;
    }

    public static int deleteCustomer(int userId) {
        try {

            Statement statement = connection.createStatement();

            statement.executeUpdate("delete from customer where Id='" + userId + "'");
            return 1;

        } catch (SQLException ex) {
            return -1;

        }

    }

    public static ArrayList<CarCategory> retriveCarCategory() throws SQLException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from car_category order by Id ");

        ArrayList<CarCategory> array = new ArrayList<>();
        while (set.next()) {

            array.add(new CarCategory(set.getInt("Id"), set.getString("Name"), set.getFloat("PricePerDay"),
                    set.getFloat("PricePerKm")));

        }

        return array;
    }

    public static int addCarCategory(CarCategory cat) {
        try {
            String name = cat.getName();
            int id = isCarCategoryExist(-1, name);

            if (id == -1) {
                float pricePerDay = cat.getPricePerDay();
                float pricePerKm = cat.getPricePerKm();
                PreparedStatement statement = connection.prepareStatement("insert into car_category (Name,PricePerDay,PricePerKm) values(?,?,?)");
                statement.setString(1, name);
                statement.setFloat(2, pricePerDay);
                statement.setFloat(3, pricePerKm);

                statement.executeUpdate();
                return 1;
            } else {
                return -2;
            }

        } catch (SQLException ex) {

            return -1;
        }
    }

    private static int isCarCategoryExist(int id, String name) throws SQLException {
        PreparedStatement statement = connection.prepareCall("select Id from car_category where Name = ? and id != ?");
        statement.setString(1, name);
        statement.setInt(2, id);
        ResultSet set = statement.executeQuery();
        if (set.next()) {
            return set.getInt("Id");
        }

        return -1;
    }

    public static int editCarCategory(CarCategory cat) {
        try {
            int categoryId = cat.getId();
            String name = cat.getName();
            int id = isCarCategoryExist(categoryId, name);

            if (id == -1) {
                float pricePerDay = cat.getPricePerDay();
                float pricePerKm = cat.getPricePerKm();
                PreparedStatement statment = connection.prepareStatement("update car_category set Name = ? , PricePerDay=?,PricePerKm=? where id =?");
                statment.setString(1, name);
                statment.setFloat(2, pricePerDay);
                statment.setFloat(3, pricePerKm);
                statment.setInt(4, categoryId);
                statment.executeUpdate();
                return 1;
            } else {
                return -2;
            }

        } catch (SQLException ex) {

            return -1;
        }
    }

    public static int deleteCarCategory(int categoryId) {
        try {

            Statement statement = connection.createStatement();

            statement.executeUpdate("delete from car_category where Id='" + categoryId + "'");
            return 1;

        } catch (SQLException ex) {
            return -1;

        }
    }

    public static ArrayList<Car> retriveCars() throws SQLException, IOException {
        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from cars order by Id ");

        ArrayList<Car> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Car(set.getInt("Id"), set.getInt("VIN"), set.getString("PlateNumber"),
                    set.getInt("NumberOfSeats"), set.getString("Maker"), set.getString("ModelName"), set.getInt("ModelYear"),
                    set.getFloat("MeterReading"), set.getInt("CategoryId"), set.getBoolean("IsRented"), set.getBoolean("IsAvaliable")));

        }

        return array;

    }

    public static int addCar(Car car) throws SQLException {

        int vin = car.getVin();
        int id = isCarExist(-1, "VIN", vin);

        if (id == -1) {
            String plateNumber = car.getPlateNumber();
            int id2 = isCarExist(-1, "PlateNumber", plateNumber);

            if (id2 == -1) {
                int seats = car.getSeats();
                String maker = car.getMaker();
                String modelName = car.getModelName();
                int modelYear = car.getModelYear();
                int categoryId = car.getCategoryId();
                float meterReading = car.getOdoMeter();
                boolean rented = car.isRented();
                boolean available = car.isAvailable();
                boolean response = insertCar(vin, plateNumber, seats, maker, modelName, modelYear, categoryId, meterReading, rented, available);
                if (response) {
                    return 1;
                } else {
                    return -1;
                }
            } else {
                return -3;
            }

        } else {
            return -2;
        }

    }

    private static int isCarExist(int id, String attribute, int data) throws SQLException {
        PreparedStatement statement = connection.prepareCall("select Id from cars where " + attribute + " = ? and Id != ? ");

        statement.setInt(1, data);
        statement.setInt(2, id);
        ResultSet set = statement.executeQuery();
        if (set.next()) {
            return set.getInt("Id");
        }

        return -1;
    }

    private static int isCarExist(int id, String attribute, String data) throws SQLException {
        PreparedStatement statement = connection.prepareCall("select Id from cars where " + attribute + " = ? and Id != ? ");

        statement.setString(1, data);
        statement.setInt(2, id);
        ResultSet set = statement.executeQuery();
        if (set.next()) {
            return set.getInt("Id");
        }

        return -1;
    }

    private static boolean insertCar(int vin, String plateNumber, int seats, String maker, String modelName, int modelYear, int categoryId, float meterReading, boolean rented, boolean available) {
        try {
            Statement stm = connection.createStatement();

            PreparedStatement statement = connection.prepareStatement("insert into cars (VIN,PlateNumber,NumberOfSeats,Maker"
                    + ",ModelName,ModelYear,MeterReading,IsRented,IsAvaliable,CategoryId) values(?,?,?,?,?,?,?,?,?,?)");
            statement.setInt(1, vin);
            statement.setString(2, plateNumber);
            statement.setInt(3, seats);
            statement.setString(4, maker);
            statement.setString(5, modelName);
            statement.setInt(6, modelYear);
            statement.setFloat(7, meterReading);
            statement.setInt(10, categoryId);
            statement.setBoolean(8, rented);
            statement.setBoolean(9, available);
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {

        }
        return false;
    }

    public static int editCar(Car car) throws SQLException {

        int carId = car.getId();
        int vin = car.getVin();
        int id = isCarExist(carId, "VIN", vin);

        if (id == -1) {
            String plateNumber = car.getPlateNumber();
            int id2 = isCarExist(carId, "PlateNumber", plateNumber);

            if (id2 == -1) {
                int seats = car.getSeats();
                String maker = car.getMaker();
                String modelName = car.getModelName();
                int modelYear = car.getModelYear();
                int categoryId = car.getCategoryId();
                float meterReading = car.getOdoMeter();
                boolean rented = car.isRented();
                boolean available = car.isAvailable();
                boolean response = updateCarStatment(carId, vin, plateNumber, seats, maker, modelName, modelYear, categoryId, meterReading, rented, available);
                if (response) {
                    return 1;
                } else {
                    return -1;
                }
            } else {
                return -3;
            }

        } else {
            return -2;
        }

    }

    private static boolean updateCarStatment(int userId, int vin, String plateNumber, int seats, String maker, String modelName, int modelYear, int categoryId, float meterReading, boolean rented, boolean available) {
        try {

            PreparedStatement statement = connection.prepareStatement("update cars set VIN=?,PlateNumber = ?,NumberOfSeats=?,"
                    + "Maker = ? , ModelName=?,ModelYear=?,MeterReading = ?,CategoryId=?,IsRented = ? ,IsAvaliable=? where Id =?");
            statement.setInt(1, vin);
            statement.setString(2, plateNumber);
            statement.setInt(3, seats);
            statement.setString(4, maker);
            statement.setString(5, modelName);
            statement.setInt(6, modelYear);
            statement.setFloat(7, meterReading);
            statement.setInt(8, categoryId);
            statement.setBoolean(9, rented);
            statement.setBoolean(10, available);
            statement.setInt(11, userId);
            statement.executeUpdate();

            return true;
        } catch (SQLException ex) {

        }
        return false;
    }

    public static int deleteCar(int carId) {
        try {

            Statement statement = connection.createStatement();

            statement.executeUpdate("delete from cars where Id='" + carId + "'");
            return 1;

        } catch (SQLException ex) {
            return -1;

        }
    }

    public static String getCatName(int id) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("select Name from car_category where Id ='" + id + "'");
        while (set.next()) {
            return set.getString("Name");
        }
        return "N/A";
    }

    public static String getCustomerName(int id) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet set = statement.executeQuery("select FirstName, LastName from customer where Id ='" + id + "'");
        while (set.next()) {
            return set.getString("FirstName") + " " + set.getString("LastName");
        }
        return "N/A";
    }

    public static ArrayList<Order> retriveOrders() throws SQLException, IOException, ClassNotFoundException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from orders order by Id ");

        ArrayList<Order> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Order(set.getInt("Id"), set.getInt("CustomerId"), set.getInt("CarId"),
                    set.getFloat("OdoMeterReading"), set.getFloat("RentDistance"), set.getInt("NumberOfDay"), set.getFloat("AdditionalFees"),
                    set.getFloat("TotalCost"), set.getBoolean("CheckOut"), set.getFloat("Payments")));

        }

        return array;
    }

    public static ArrayList<Customers> retriveAvailableCustomers() throws SQLException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from customer where IsActive ='1' and ValidDrivingLicense='1' order by Id ");

        ArrayList<Customers> array = new ArrayList<>();

        while (set.next()) {

            array.add(new Customers(set.getInt("Id"), set.getString("Username"), set.getString("Password"),
                    set.getString("Email"), set.getString("FirstName"), set.getString("LastName"), set.getString("Address"),
                    set.getString("PhoneNumber"), set.getBoolean("IsActive"), set.getBoolean("ValidDrivingLicense")));

        }

        return array;

    }

    public static ArrayList<Integer> retriveAvailableCars() throws SQLException {

        Statement statment = connection.createStatement();
        ResultSet set = statment.executeQuery("select * from cars where IsRented ='0' and IsAvaliable='1' order by Id ");
        int count = 0;
        ArrayList<Integer> list = new ArrayList<>();

        while (set.next()) {

            list.add(set.getInt("Id"));

        }
        return list;

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

    public static int editOrder(Order order) {
        try {
            int orderId = order.getId();
            int customerId = order.getCustomerId();
            int carId = order.getCarId();
            int numberOfDays = order.getNumberOfDays();
            float rentDistance = order.getRentDistance();
            float additionalFees = order.getAdditionalFees();
            float payment = order.getPayment();
            Statement s = connection.createStatement();
            ResultSet set = s.executeQuery("select CarId from orders where Id='" + orderId + "'");
            int prevCarId = 0;
            if (set.next()) {
                prevCarId = set.getInt("CarId");
            }

            PreparedStatement statement = connection.prepareStatement("update orders set CustomerId=?, CarId=?, "
                    + "NumberOfDay=? ,RentDistance=? , AdditionalFees=? where Id =?");
            statement.setInt(1, customerId);
            statement.setInt(2, carId);
            statement.setInt(3, numberOfDays);
            statement.setFloat(4, rentDistance);
            statement.setFloat(5, additionalFees);
            statement.setInt(6, orderId);
            statement.executeUpdate();
            rentCar(prevCarId, 0);
            rentCar(carId, 1);
            updateOrderTotalCost(orderId);
            if (addPayment(orderId, payment) == 1) {
                return 1;
            } else {
                return -2;
            }

        } catch (SQLException ex) {

            return -1;
        }
    }

    private static void updateOrderTotalCost(int id) throws SQLException {

        Statement orderStatement = connection.createStatement();
        ResultSet orderSet = orderStatement.executeQuery("select * from orders where Id='" + id + "'");
        if (orderSet.next()) {

            int carId = orderSet.getInt("CarId");
            int numberOfDays = orderSet.getInt("NumberOfDay");
            float rentDistance = orderSet.getFloat("rentDistance");
            float additionalfees = orderSet.getFloat("AdditionalFees");

            float odoMeter = 0;
            float totalCost = 0;
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

                    totalCost = pricePerDay * numberOfDays + pricePerKm * rentDistance + additionalfees;
                }
            }
            Statement statement = connection.createStatement();
            statement.executeUpdate("update orders set TotalCost ='" + totalCost + "', OdoMeterReading='" + odoMeter + "' where Id ='" + id + "'");

        }
    }

    public static int deleteOrder(int orderId) {

        try {
            Statement s = connection.createStatement();
            ResultSet set = s.executeQuery("select CarId from orders where Id='" + orderId + "'");
            int carId = 0;
            if (set.next()) {
                carId = set.getInt("CarId");
            }

            Statement statement = connection.createStatement();

            statement.executeUpdate("delete from orders where Id='" + orderId + "'");
            rentCar(carId, 0);
            return 1;

        } catch (SQLException ex) {
            return -1;

        }
    }

    public static int addPayment(int id, float payment) {
        try {

            Statement s = connection.createStatement();
            ResultSet set = s.executeQuery("select TotalCost, Payments from orders where Id='" + id + "'");
            if (set.next()) {
                if ((payment) > set.getFloat("TotalCost")) {
                    return -2;
                }

            }

            PreparedStatement statement = connection.prepareStatement("Update orders set Payments = ? where Id = ?");
            statement.setFloat(1, payment);
            statement.setInt(2, id);
            statement.executeUpdate();
            return 1;

        } catch (SQLException ex) {

            try {
                PrintWriter out = new PrintWriter("D:\\edit.txt");
                out.println(ex.toString());
                out.flush();

            } catch (FileNotFoundException ex1) {
                Logger.getLogger(AdminHandler.class.getName()).log(Level.SEVERE, null, ex1);
            }
            return -1;
        }

    }

    public static int checkOut(int orderId) {
        try {
            Statement s = connection.createStatement();
            ResultSet set = s.executeQuery("select Payments, TotalCost from orders where Id='" + orderId + "'");
            if (set.next()) {
                if (set.getFloat("Payments") != set.getFloat("TotalCost")) {
                    return -2;
                }
            }

            int carId = -1;
            float rentDistace = 0;
            Statement statement = connection.createStatement();
            ResultSet orderSet = statement.executeQuery("select CarId , RentDistance from orders where Id ='" + orderId + "'");
            if (orderSet.next()) {
                carId = orderSet.getInt("CarId");
                rentDistace = orderSet.getFloat("RentDistance");
                Statement statement2 = connection.createStatement();
                ResultSet carSet = statement2.executeQuery("select MeterReading from cars where Id ='" + carId + "'");
                if (carSet.next()) {
                    rentDistace += carSet.getFloat("MeterReading");
                    Statement statement3 = connection.createStatement();
                    statement3.executeUpdate("update cars set MeterReading ='" + rentDistace + "' where Id ='" + carId + "'");
                    rentCar(carId, 0);
                    Statement statement4 = connection.createStatement();
                    statement4.executeUpdate("update orders set CheckOut='1' where Id='" + orderId + "'");
                    return 1;
                }
            }
        } catch (SQLException ex) {

            return -1;
        }
        return -1;
    }

    public static ArrayList<Order> rentHistory(String attribute, int id) throws SQLException {

        Statement statment = connection.createStatement();

        ResultSet set = statment.executeQuery("select * from orders where " + attribute + "='" + id + "' order by Id ");

        ArrayList<Order> array = new ArrayList<>();
        while (set.next()) {

            array.add(new Order(set.getInt("Id"), set.getInt("CustomerId"), set.getInt("CarId"),
                    set.getFloat("OdoMeterReading"), set.getFloat("RentDistance"), set.getInt("NumberOfDay"), set.getFloat("AdditionalFees"),
                    set.getFloat("TotalCost"), set.getBoolean("CheckOut"), set.getFloat("Payments")));

        }
        return array;

    }
     public static ArrayList<Customers> searchCustomer(String attribute,String data) throws SQLException {

         data = data.replace("'", "");
         data = data.replace("\"", "");
          
            Statement statment = connection.createStatement();
            ResultSet set = statment.executeQuery("select * from customer where " + attribute + "='" + data + "'");

            
            ArrayList<Customers> array = new ArrayList<>();
            while (set.next()) {

             
                array.add(new Customers(set.getInt("Id"), set.getString("Username"), set.getString("Password"),
                        set.getString("Email"), set.getString("FirstName"), set.getString("LastName"), set.getString("Address"),
                        set.getString("PhoneNumber"), set.getBoolean("IsActive"), set.getBoolean("ValidDrivingLicense")));

            }
            return array;

        
    }
     public static void logout() throws SQLException{
         connection.close();
         connection=null;
     }
}

package dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {
//    public static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
//    public static String dbURL = "jdbc:sqlserver://MSI:1433;databaseName=Project;encrypt=false";
  public static String dbURL = "jdbc:sqlserver://DESKTOP-OI2U5Q4\\MSSQLSERVER2022:49774;databaseName=ASGM_PRJ;encrypt=false";

    public static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String userDB = "sa";
    public static String passDB = "khanhdz2004";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(driverName);
            con = DriverManager.getConnection(dbURL, userDB, passDB);
            return con;
        } catch (Exception ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {
        try (Connection con = getConnection()) {
            if (con != null) {
                System.out.println("Connect Success");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

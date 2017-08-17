package Connection_DB;

import javax.swing.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by yelc on 6/07/17.
 */
public class connectionDB {
    private Connection connection;

    public connectionDB() {
        createConnectionDB();
    }

    public void createConnectionDB(){
        try {
            // check driver
            Class.forName("com.mysql.jdbc.Driver");
            //  create connection with data base
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistemaVentas","root","pass123");
        } catch (ClassNotFoundException | SQLException e) {
            JOptionPane.showMessageDialog(null,"No Se Conecto Con La Base De Datos");
        }
    }

    public Connection getConexion(){
        return connection;
    }
}

package ConexionDB;

import javax.swing.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by yelc on 1/05/17.
 */
public class Conexion {
    Connection sql; // instanciar clase connection
    /**
     *     Constructor
     */
    public Conexion() {
        try {
            // comprobar el driver
            Class.forName("com.mysql.jdbc.Driver");
            //  crear conexion con bd
            sql = DriverManager.getConnection("jdbc:mysql://sql10.freesqldatabase.com:3306/sql10190570","sql10190570","zIXzMbX18B");
        } catch (ClassNotFoundException | SQLException e) {
            JOptionPane.showMessageDialog(null,"No Se Conecto Con La Base De Datos!");
        }
    }

    public Connection getConexion(){
        return sql;
    }
}   

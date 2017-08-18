package ConexionDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

/**
 * Created by yelc on 1/05/17.
 */
public class Consulta extends Conexion{
    private ResultSet resultado;

    public Consulta() {
        super();
    }

    public ResultSet getResultado(String Consulta){
        try {
            //  Crear un objeto preparedstatement
            Statement consulta = super.getConexion().createStatement();
            // Inicializa una consulta y la guarda en rs
            resultado = consulta.executeQuery(Consulta);
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "No Se Realizo Correctamente La Consulta");
        }
        return resultado;
    }
    
 
    public void InsertarBDD(String consulta){
        try {
            Statement obj = super.getConexion().createStatement();
            obj.executeUpdate(consulta);
            //JOptionPane.showMessageDialog(null,"Se han insertado los datos");
        } catch (Exception e) {
        }
        
    }
    public void EliminarBDD(String consulta){
        try {
            Statement obj = super.getConexion().createStatement();
            obj.executeUpdate(consulta);
            JOptionPane.showMessageDialog(null,"Se ha Eliminado al usuario");
        } catch (Exception e) {
        }
        
    }
    
    
}
    
    
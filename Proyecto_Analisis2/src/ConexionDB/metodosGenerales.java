/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ConexionDB;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author yelc
 */
public class metodosGenerales extends Consulta{
    
    private ResultSet resultado;
    
    
    public metodosGenerales(){
        super();
    }
    
    
    public void Datos(JTable tabla, DefaultTableModel modelo,  String consulta) {
        try {
            tabla.setModel(modelo);
            resultado = super.getResultado(consulta);
            while (resultado.next()) {
                String Datos[] = new String[modelo.getColumnCount()];
                for (int i = 0; i < modelo.getColumnCount(); i++) {
                    Datos[i] = resultado.getString(i + 1);
                }
                modelo.addRow(Datos);
            }
            resultado.close();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "error en vista");
        }
    }
    
    public void Datos(){
        
    }
    
}

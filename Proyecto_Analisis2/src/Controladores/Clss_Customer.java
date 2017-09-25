/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import ConexionDB.metodosGenerales;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author yelc
 */
public class Clss_Customer extends metodosGenerales {
    String consulta;
    
        public void getClientes(JTable tabla,String dato) {
            DefaultTableModel modelo = new DefaultTableModel();
            modelo.addColumn("Nombre");
            modelo.addColumn("Apellido");
            modelo.addColumn("Telefono");
            modelo.addColumn("Direccion Personal");
            modelo.addColumn("Direccion Negocio");
            modelo.addColumn("Descripcion Empresa");
                            
            if (dato.isEmpty()) {
                 consulta = "select nombre, apellido, telefono, direccion_personal, direccion_negocio, "
                        + "descripcion_negocio from cliente ";
            }
            else{
                consulta = "select nombre, apellido, telefono, direccion_personal, direccion_negocio, "
                        + "descripcion_negocio from cliente where nombre like '" + dato + "%';";
            }
         
            super.Datos(tabla, modelo , consulta);
    }
        
}

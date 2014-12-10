/**
 * 
 *  Copyright (C) 2010  Juan Jose Luna Espinosa juanjoluna@gmail.com

 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, version 3 of the License.

 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *  
 *  
 * Opciones de la aplicacion
 */
package org.yombo.entorno;

import java.io.*;
import java.util.ArrayList;

public class Opciones {

    private class Opcion {
        public String nombre;
        public String valor;
        public Opcion() {
            // Nada que hacer
        }
        public Opcion( String nombre, String valor ) {
            this.nombre = nombre;
            this.valor = valor;
        }
    }

    private ArrayList<Opcion> opciones;

    public Opciones() {
        opciones = new ArrayList<Opcion>();
    }

    public String getOpcion( String nombreOpcion ) {

        // Devuelve null si la opcion no existe

        int no = opciones.size();
        for ( int i = 0; i < no; i++ ) {
            Opcion opcion = opciones.get( i );
            if ( opcion.nombre.compareTo( nombreOpcion ) == 0 ) {
                return opcion.valor;
            }
        }
        return null;
    }

    public int getNumOpciones() {
    	return opciones.size();
    }
    
    public String getOpcion( int indice ) {
    	return opciones.get( indice ).valor;
    }

    public String getNombreOpcion( int indice ) {
    	return opciones.get( indice ).nombre;
    }

    public void setOpcion( String nombre, String valor ) {
        
        // El valor nunca deberia ser null
        if ( valor == null ) {
            throw new Error( "Tried to set an option (" + nombre + ") with a null value" );
        }
        
        int no = opciones.size();
        for ( int i = 0; i < no; i++ ) {
            Opcion opcion = opciones.get( i );
            if ( opcion.nombre.compareTo( nombre ) == 0 ) {
                opcion.valor = valor;
                return;
            }
        }
        
        // La opcion no esta, crearla y asignarle el valor
        Opcion opcion = new Opcion( nombre, valor );
        opciones.add( opcion );

    }

    public void borrarOpcion( int indice ) {
    	opciones.remove( indice );
    }
    
    public boolean cargar( String path ) {

        // Si el fichero no existe o hay otro error, las opciones quedan vacias

        opciones = new ArrayList<Opcion>();

        BufferedReader input = null;
        try {
            input = new BufferedReader( new FileReader( path ) );
        }
        catch ( FileNotFoundException e ) {
            return false;
        }

        String linea = null;
        try {
            while ( ( linea = input.readLine() ) != null ) {
    
                int i = linea.indexOf('=');
                if ( i != -1 && i > 0 ) {
                    Opcion opcion = new Opcion();
                    opcion.nombre = linea.substring( 0, i );
                    if ( i < linea.length() - 1 ) {
                        opcion.valor = linea.substring( i + 1, linea.length() );
                    }
                    else {
                        opcion.valor = "";
                    }
                    opciones.add( opcion );
                }
            }
        }
        catch ( IOException e ) {
            opciones = new ArrayList<Opcion>();
            return false;
        }

        try {
            input.close();
        }
        catch ( IOException e ) {
            // Nada que hacer
        }
        
        return true;
    }

    public boolean grabar( String path ) {
        BufferedWriter output = null;
        try {
            output = new BufferedWriter( new FileWriter( path ) );
        }
        catch ( IOException e ) {
            // No se puede grabar el fichero de configuracion
            return false;
        }

        try {
            int no = opciones.size();
            for ( int i = 0; i < no; i++ ) {
                Opcion opcion = opciones.get( i );
                String linea = opcion.nombre + "=" + opcion.valor + (i == no -1 ? "" : "\n");
                output.write( linea, 0, linea.length() );
            }
        }
        catch ( IOException e ) {
            return false;
        }

        try {
            output.close();
        }
        catch ( IOException e ) {
            // Nada que hacer
        }
        
        return true;
    }
    
    public String toString() {
        int no = opciones.size();
        if ( no == 0 ) {
            return "Empty options";
        }
        String linea = "";
        for ( int i = 0; i < no; i++ ) {
            Opcion opcion = opciones.get( i );
            linea += opcion.nombre + "=" + opcion.valor + (i == no -1 ? "" : "\n");
        }
        return linea;
    }

	public void anyadirOpciones( ArrayList<String> listaOpciones, Opciones opcionesFuente ) {

		if ( listaOpciones == null || opcionesFuente == null ) {
			return;
		}

		int no = listaOpciones.size();
		for ( int i = 0; i < no; i++ ) {
			String nombre = listaOpciones.get( i );
			String valor = opcionesFuente.getOpcion( nombre );
			if ( valor != null ) {
				this.setOpcion( nombre, valor );
			}
			else {
				this.setOpcion( nombre, "" );
			}
		}
		
	}

}

/**
 * 
 *  Copyright (C) 2014  Juan Jose Luna Espinosa juanjoluna@gmail.com

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
 *  Servidor de ficheros locales
 */

package org.yombo.red.servidorficheros;

import java.io.File;

import org.yombo.log.Log;

public class ServidorFicherosLocal implements ServidorFicheros {

	public ServidorFicherosLocal() {
		// Nada que hacer
	}

	@Override
	public void getFichero( String path, String nombre, ListenerServidorFicheros listener ) {

		String s = path + nombre;
		
		File f = new File( s );

		String error = null;
		if ( ! f.exists() ) {
			error = "Error: Local file not found: " + s;
		}

		listener.ficheroListo( error, path, nombre );

	}
	
	@Override
	public void getDirectorio( String pathDirectorio, String nombreDirectorio, ListenerServidorFicheros listener ) {

		String s = pathDirectorio + nombreDirectorio;

		File f = new File( s );

		String error = null;
		String [] nombresFicheros = null; 
		boolean ficherosSonDirectorios[] = null;

		if ( ! f.exists() ) {
			error = "Error: Local directory not found: " + s;
		}
		else if ( ! f.isDirectory() ) {
			error = "Error: Local directory path is not a directory: " + s;
		}
		else {
	
			nombresFicheros = f.list();
			
			int nf = nombresFicheros.length;
			if ( nf > 0 ) {
				ficherosSonDirectorios = new boolean[ nf ];
				for ( int i = 0; i < nf; i++ ) {
					String sf = s + "/" + nombresFicheros[ i ];
					ficherosSonDirectorios[ i ] = new File( sf ).isDirectory();
				}
			}
		}

		listener.directorioListo( error, pathDirectorio, nombreDirectorio, nombresFicheros, ficherosSonDirectorios );

	}

}

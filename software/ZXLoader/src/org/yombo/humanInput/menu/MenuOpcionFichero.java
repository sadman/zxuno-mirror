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
 *  Opcion de menu que representa un fichero dentro de una lista de ficheros
 */

package org.yombo.humanInput.menu;

import org.yombo.red.servidorficheros.ListenerServidorFicheros;
import org.yombo.red.servidorficheros.ServidorFicheros;

public class MenuOpcionFichero extends MenuOpcion implements ListenerServidorFicheros {

	private static final long serialVersionUID = 1L;
	
	// Mensaje que se muestra mientras esta cargando el fichero
	public String refreshingString;
	
	// Path y nombre logicos
	public String pathFichero;
	public String nombreFichero;
	
	// Path y nombre locales, devueltos por el servidor de ficheros
	public String pathFicheroLocal;
	public String nombreFicheroLocal;

	public ServidorFicheros servidorFicheros;

	private boolean ficheroListo;
	public String errorCarga;
	private boolean llamarListener;

	public MenuOpcionFichero() {
		// Nada que hacer
	}
	
	public void reset() {
		// Solo llamar cuendo ha terminado (por ejemplo si ha habido error)
		ficheroListo = false;
		errorCarga = null;
	}

	@Override
	public void activar() {

		menu.opcionActiva = this;

		if ( ! ficheroListo ) {
			errorCarga = null;
			servidorFicheros.getFichero( pathFichero, nombreFichero, this );
		}

		llamarListener = true;
	}

	@Override
	public void seleccionar() {
		// Nada que hacer
	}

	@Override
	public void abajo() {
		// Nada que hacer
	}

	@Override
	public void arriba() {
		// Nada que hacer
	}

	@Override
	public void tick( double tiempo, double dt ) {

		if ( llamarListener && ficheroListo ) {
			if ( menu.opcionActiva == this ) {
				menu.listener.opcionSeleccionada( this );
				cancelar();
				menu.cerrar();
			}
			llamarListener = false;
		}
	}

	@Override
	public void rellenarTexto() {

		if ( ! ficheroListo ) {

			String l[] = menu.texto.cadenas;
			int i = 0;

			if ( errorCarga != null ) {
				l[ i++ ] = errorCarga;
			}
			else {
				l[ i++ ] = refreshingString;
				l[ i++ ] = "Please wait.";
			}

			int nl = l.length;
			while ( i < nl ) {
				l[ i++ ] = null;
			}			
		}
	}

	@Override
	public void ficheroListo( String error, String pathFichero, String nombreFichero ) {

		if ( error != null ) {
			errorCarga = error;
		}
		else {
			pathFicheroLocal = pathFichero;
			nombreFicheroLocal = nombreFichero;
		}

		ficheroListo = true;
	}

	@Override
	public void directorioListo( String error, String pathDirectorio, String nombreDirectorio, String[] nombresFicheros, boolean ficherosSonDirectorios[] ) {
		// Nada que hacer
	}
}

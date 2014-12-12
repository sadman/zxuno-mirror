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
 *  Opcion de menu
 */

package org.yombo.humanInput.menu;

import java.io.Serializable;

public class MenuOpcion implements Serializable {

	private static final long serialVersionUID = 1L;

	public Menu menu;

	// Identificador unico en todo el menu
	public int identificador;

	// Nombre que se muestra en la lista de opciones que contiene la opcion
	public String nombre;

	// Descripcion de la accion, mostrada como primera linea
	public String titulo;
	
	// Indica que al activarse se cierra el menu
	public boolean cerrarMenuAlActivar;
	
	// Indica que al activarse se vuelve a la opcion de vuelta
	public boolean opcionVueltaAlActivar;
	
	// Opcion que se activa al terminar esta. Puede ser null, entonces se cierra el menu
	public MenuOpcion opcionVuelta;

	public MenuOpcion() {
		identificador = -1;
		cerrarMenuAlActivar = true;
	}

	public void activar() {

		// Hace activa la opcion. Reimplementar en subclases.
		// Comportamiento por defecto para una opcion de clickar y listo:
		// La opcion no se hace activa. Se llama a listener.
		
		menu.listener.opcionSeleccionada( this );

		if ( cerrarMenuAlActivar ) {
			menu.cerrar();
		}
		else if ( opcionVueltaAlActivar ) {
			opcionVuelta.activar();
		}
	}
	
	public void cancelar() {
		
		// Cancela la opcion. Por defecto se vuelve a la accion de vuelta, o si es null se cierra el menu.
		if ( opcionVuelta != null ) {
			opcionVuelta.activar();
		}
		else {
			menu.cerrar();
		}
	}

	public void seleccionar() {

		// Este metodo se llama al pulsar el boton "seleccionar" para la opcion activa del menu.
		// Reimplementar en subclases.
	}

	public void abajo() {
		
		// Este metodo se llama al pulsar el boton "abajo" para la opcion activa del menu.
		// Reimplementar en subclases, por defecto no se hace nada
	}

	public void arriba() {
		
		// Este metodo se llama al pulsar el boton "arriba" para la opcion activa del menu.
		// Reimplementar en subclases, por defecto no se hace nada
	}

	public void tick( double tiempo, double dt ) {
		// Reimplementar en subclases
	}

	public void rellenarTexto() {
		
		// Rellena texto en el objeto3d del menu.
		// Reimplementar en subclases
	}
	
	public MenuOpcion buscarOpcionIdentificador( int id ) {
		if ( id == identificador ) {
			return this;
		}
		return null;
	}

	@Override
	public String toString() {
		return nombre;
	}

}

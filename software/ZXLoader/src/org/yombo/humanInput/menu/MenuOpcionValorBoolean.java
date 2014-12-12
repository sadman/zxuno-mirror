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
 *  Opcion de menu que configura un valor boleano
 */

package org.yombo.humanInput.menu;

import java.io.Serializable;

public class MenuOpcionValorBoolean extends MenuOpcion implements Serializable {

	private static final long serialVersionUID = 1L;

	public String cadenaMensaje;

	// Texto mostrado segun valor true/false
	public String cadenaTrue;
	public String cadenaFalse;

	public boolean valor;

	public MenuOpcionValorBoolean() {
		cerrarMenuAlActivar = false;
	}

	@Override
	public void activar() {

		valor = menu.listener.getValorMenuOpcionBoolean( this );

		menu.opcionActiva = this;

	}

	@Override
	public void seleccionar() {

		menu.listener.opcionSeleccionada( this );

		opcionVuelta.activar();

	}

	@Override
	public void abajo() {

		valor = ! valor;
		
	}

	@Override
	public void arriba() {

		valor = ! valor;

	}

	@Override
	public void rellenarTexto() {

		String [] l = menu.texto.cadenas;
		int totalLineas = l.length;

		int i = 0;
		if ( titulo != null ) {
			l[ i++ ] = titulo;
			l[ i++ ] = null;
		}
		
		l[ i++ ] = cadenaMensaje + ( valor ? cadenaTrue : cadenaFalse );

		while ( i < totalLineas ) {
			l[ i++ ] = null;
		}
	}

}

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
 *  Opcion de menu que configura un valor double
 */

package org.yombo.humanInput.menu;

import java.io.Serializable;

public class MenuOpcionValorInt extends MenuOpcion implements Serializable {

	private static final long serialVersionUID = 1L;

	public boolean seleccionarAlActivar;
	
	public String cadenaMensaje;
	
	public int valor;
	public int incremento;
	public int valorMinimo;
	public int valorMaximo;

	public MenuOpcionValorInt() {
		cerrarMenuAlActivar = false;
	}

	@Override
	public void activar() {

		if ( seleccionarAlActivar ) {
			seleccionar();
		}
		else {
			
			valor = menu.listener.getValorMenuOpcionInt( this );
		
			menu.opcionActiva = this;
		}

	}

	@Override
	public void seleccionar() {

		menu.listener.opcionSeleccionada( this );
		
		opcionVuelta.activar();

	}

	@Override
	public void abajo() {
		
		valor -= incremento;
		if ( valor < valorMinimo ) {
			valor = valorMinimo;
		}
		
	}

	@Override
	public void arriba() {
		
		valor += incremento;
		if ( valor > valorMaximo ) {
			valor = valorMaximo;
		}
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
		
		String s = cadenaMensaje;
		l[ i++ ] = s;

		while ( i < totalLineas ) {
			l[ i++ ] = null;
		}
	}

}

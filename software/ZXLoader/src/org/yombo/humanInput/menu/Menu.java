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
 *  Menu de aplicacion
 */

package org.yombo.humanInput.menu;

import java.io.Serializable;

import org.yombo.texto.ObjetoTexto;

public class Menu implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public MenuListener listener;

	public ObjetoTexto texto;
	
	public MenuOpcion opcionPrincipal;

	public MenuOpcion opcionActiva;

	// Visible y activado
	private boolean activado;

	private boolean petCancelar;
	private boolean petSeleccionar;
	private boolean petArriba;
	private boolean petAbajo;

	public Menu() {
		
	}

	public boolean getActivado() {
		return activado;
	}

	public void cerrar() {
		activado = false;
		listener.eventoVisibilidadMenu( false );
	}

	public void peticionCancelar() {

		// El metodo se llama peticionCancelar, pero tambien abre el menu!

		petCancelar = true;
	}
	
	public void peticionSeleccionar() {

		if ( ! activado ) {
			return;
		}

		petSeleccionar = true;

	}

	public void peticionMenuAbajo() {
		
		if ( ! activado ) {
			return;
		}
		
		petAbajo = true;
	}
	
	public void peticionMenuArriba() {
		
		if ( ! activado ) {
			return;
		}
		
		petArriba = true;

	}

	public void tick( double tiempo, double dt ) {

		if ( petCancelar ) {
			if ( activado ) {
				if ( opcionActiva != null ) {
					// Aqui puede que se cierre el menu o no (llamando a cerrar())
					opcionActiva.cancelar();
				}
			}
			else {
				activado = true;
				listener.eventoVisibilidadMenu( true );
			}

			petCancelar = false;
		}

		if ( ! activado ) {
			return;
		}

		if ( opcionActiva != null ) {

			if ( petSeleccionar ) {
				opcionActiva.seleccionar();
				petSeleccionar = false;
			}

			if ( petArriba ) {
				opcionActiva.arriba();
				petArriba = false;
			}

			if ( petAbajo ) {
				opcionActiva.abajo();
				petAbajo = false;
			}

			opcionActiva.tick( tiempo, dt );

			if ( activado ) {
				opcionActiva.rellenarTexto();
			}

		}

	}
	
	public MenuOpcion buscarOpcionIdentificador( int id ) {
		return opcionPrincipal.buscarOpcionIdentificador( id );
	}

}

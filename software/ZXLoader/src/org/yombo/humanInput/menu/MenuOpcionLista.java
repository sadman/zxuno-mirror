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

import java.util.ArrayList;

public class MenuOpcionLista extends MenuOpcion {

	private static final long serialVersionUID = 1L;

	public ArrayList<MenuOpcion> opciones;
	
	public boolean scrollCiclico;

	public int indiceOpcionSeleccionada;
	
	// Indice de la opcion visualizada en la primera linea
	public int indiceOpcionVisualizada;
	
	// Variables calculadas
	private int totalLineas;
	private int numOpciones;
	private int numLineasMostrar;
	private int numOpcionesMostrar;
	private boolean mostrarPuntosInicio;
	private boolean mostrarPuntosFinal;

	public MenuOpcionLista() {
		
		opciones = new ArrayList<MenuOpcion>();
		
		scrollCiclico = true;
	}
	
	@Override
	public void activar() {

		menu.opcionActiva = this;

	}

	@Override
	public void seleccionar() {

		// Este check lo he puesto para que no pete cuando la lista esta vacia
		if ( indiceOpcionSeleccionada >= 0 && indiceOpcionSeleccionada < opciones.size() ) {
			// Activa la opcion
			opciones.get( indiceOpcionSeleccionada ).activar();
		}

	}

	@Override
	public void abajo() {

		calcularOpcionesMostradas();

		indiceOpcionSeleccionada++;

		int no = opciones.size();

		if ( indiceOpcionSeleccionada >= no ) {
			if ( scrollCiclico ) {
				indiceOpcionSeleccionada = 0;
			}
			else {
				indiceOpcionSeleccionada  = no - 1;
			}
		}

		if ( indiceOpcionSeleccionada < indiceOpcionVisualizada ) {
			indiceOpcionVisualizada = indiceOpcionSeleccionada;
		}
		else if ( indiceOpcionSeleccionada >= indiceOpcionVisualizada + numOpcionesMostrar ) {
			int d = 0;
			if ( indiceOpcionVisualizada == 0 ) {
				d = 1;
			}
			else if ( indiceOpcionSeleccionada > indiceOpcionVisualizada + numOpcionesMostrar ) {
				d = -1;
			}
			indiceOpcionVisualizada = indiceOpcionSeleccionada - numOpcionesMostrar + 1 + d;
		}

	}

	@Override
	public void arriba() {

		calcularOpcionesMostradas();

		indiceOpcionSeleccionada--;

		if ( indiceOpcionSeleccionada < 0 ) {
			if ( scrollCiclico ) {
				indiceOpcionSeleccionada = opciones.size() - 1;
			}
			else {
				indiceOpcionSeleccionada = 0;
			}
		}

		if ( indiceOpcionSeleccionada < indiceOpcionVisualizada ) {
			indiceOpcionVisualizada = indiceOpcionSeleccionada;
		}
		else if ( indiceOpcionSeleccionada >= indiceOpcionVisualizada + numOpcionesMostrar ) {
			indiceOpcionVisualizada = indiceOpcionSeleccionada - numOpcionesMostrar + 1;
		}
	}

	@Override
	public void rellenarTexto() {

		String [] l = menu.texto.cadenas;

		// Calcula variables
		calcularOpcionesMostradas();

		int i = 0;
		if ( titulo != null ) {
			l[ i++ ] = titulo;
			l[ i++ ] = null;
		}

		if( mostrarPuntosInicio ) {
			l[ i++ ] = "...";
		}
		
		int iOpcion = indiceOpcionVisualizada;
		int no = numOpcionesMostrar;
		while ( no > 0 ) {
			String s = opciones.get( iOpcion ).nombre;
			if( indiceOpcionSeleccionada == iOpcion ) {
				s = anyadirTagSeleccion( s );
			}
			l[ i++ ] = s;
			iOpcion++;
			no--;
		}
		
		if( mostrarPuntosFinal ) {
			l[ i++ ] = "...";
		}
		
		while ( i < totalLineas ) {
			l[ i++ ] = null;
		}
	}

	public String anyadirTagSeleccion( String s ) {
		return "--> " + s;
	}

	private void calcularOpcionesMostradas() {

		// Calcula variables de indices y numero de opciones visibles en pantalla

		String [] l = menu.texto.cadenas;

		totalLineas = l.length;

		int i = 0;
		if ( titulo != null ) {
			i+= 2;
		}

		numOpciones = opciones.size();
		numLineasMostrar = totalLineas - i;

		numOpcionesMostrar = numOpciones;
		mostrarPuntosInicio = false;
		mostrarPuntosFinal = false;
		if ( numOpciones > numLineasMostrar ) {
			numOpcionesMostrar = numLineasMostrar;
			if ( indiceOpcionVisualizada > 0 ) {
				numOpcionesMostrar--;
				mostrarPuntosInicio = true;
			}
			if ( indiceOpcionVisualizada + numOpcionesMostrar < numOpciones ) {
				numOpcionesMostrar--;
				mostrarPuntosFinal = true;
			}
		}
	}
}

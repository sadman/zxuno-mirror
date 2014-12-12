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
 *  Opcion de menu que muestra una intro (pantallas de texto sucesivas)
 */

package org.yombo.humanInput.menu;

import java.util.ArrayList;

public class MenuOpcionIntro extends MenuOpcion {

	private static final long serialVersionUID = 1L;

	public ArrayList<PantallaMenuOpcionIntro> pantallas;
	
	public int pantallaActual;

	// TODO cambiar a tiempo absoluto, al inicio se recoge en tick()
	public double tiempoRestantePantalla;
	
	public MenuOpcionIntro() {
		pantallas = new ArrayList<PantallaMenuOpcionIntro>();
	}

	@Override
	public void activar() {

		menu.opcionActiva = this;

		setPantallaActual( 0 );

	}

	@Override
	public void seleccionar() {

		siguientePantalla();

	}

	@Override
	public void tick( double tiempo, double dt ) {

		tiempoRestantePantalla -= dt;
		
		if ( tiempoRestantePantalla < 0.0d ) {
			siguientePantalla();
		}

	}

	@Override
	public void rellenarTexto() {

		String [] l = menu.texto.cadenas;
		int totalLineas = l.length;

		PantallaMenuOpcionIntro p = pantallas.get( pantallaActual );
		String [] lineas = p.texto;
		int numLineas = lineas.length;

		int numLineasMostrar = Math.min( totalLineas, numLineas );

		int i = 0;
		while ( i < numLineasMostrar ) {
			l[ i ] = lineas[ i ];
			i++;
		}

		while ( i < totalLineas ) {
			l[ i++ ] = null;
		}

	}

	private void setPantallaActual( int i ) {
		pantallaActual = i;
		tiempoRestantePantalla = pantallas.get( i ).tiempoAMostrar;
	}

	private void siguientePantalla() {
		
		pantallaActual++;
		
		if ( pantallaActual >= pantallas.size() ) {
			cancelar();
		}
		else {
			setPantallaActual( pantallaActual );
		}
	}

}

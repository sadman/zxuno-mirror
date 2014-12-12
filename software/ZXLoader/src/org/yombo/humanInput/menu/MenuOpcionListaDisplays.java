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
 *  Opcion de menu que implementa una lista de displays
 */

package org.yombo.humanInput.menu;

import java.awt.DisplayMode;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;

import org.yombo.entorno.Entorno;

public class MenuOpcionListaDisplays extends MenuOpcionLista {

	private static final long serialVersionUID = 1L;

	public Entorno entorno;
	
	public MenuOpcionListaDisplays() {
		// Nada que hacer
	}

	@Override
	public void activar() {

		cargarOpcionesDisplays();

		menu.opcionActiva = this;

	}

	protected void cargarOpcionesDisplays() {

		opciones.clear();		

		GraphicsEnvironment graphicsEnvironment = GraphicsEnvironment.getLocalGraphicsEnvironment();
       	GraphicsDevice [] gda = graphicsEnvironment.getScreenDevices();
       	for ( int i = 0; i < gda.length; i++ ) {
        	GraphicsDevice gd = gda[ i ];
        	DisplayMode dm = gd.getDisplayMode();
        	MenuOpcionDisplay opcionDisplay = new MenuOpcionDisplay();
        	opcionDisplay.menu = menu;
        	opcionDisplay.valor = gd.getIDstring();
        	opcionDisplay.nombre = opcionDisplay.valor + " Resolution: " + dm.getWidth() + " x " + dm.getHeight() + ", " + dm.getRefreshRate() + " Hz";
        	opcionDisplay.identificador = identificador;
        	opcionDisplay.opcionVuelta = opcionVuelta;
        	opcionDisplay.entorno = entorno;
            opciones.add( opcionDisplay );

            if ( opcionDisplay.valor.equals( entorno.displayId ) ) {
            	indiceOpcionSeleccionada = i;
            }
       	}
	}
}

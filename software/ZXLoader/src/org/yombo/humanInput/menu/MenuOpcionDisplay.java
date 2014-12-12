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
 *  Opcion de menu para elegir un display
 */

package org.yombo.humanInput.menu;

import java.io.Serializable;

import org.yombo.entorno.Entorno;

public class MenuOpcionDisplay extends MenuOpcion implements Serializable {

	private static final long serialVersionUID = 1L;

	public String valor;
	public Entorno entorno;

	public MenuOpcionDisplay() {
		// Nada que hacer
	}

	@Override
	public void activar() {

		entorno.displayId = valor;
		entorno.grabarFicheroConfiguracion();
		
		opcionVuelta.activar();

	}

}

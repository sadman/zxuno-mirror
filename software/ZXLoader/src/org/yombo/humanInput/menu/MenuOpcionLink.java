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

public class MenuOpcionLink extends MenuOpcion implements Serializable {

	private static final long serialVersionUID = 1L;

	public MenuOpcion opcionLinkada;
	
	public MenuOpcionLink() {
		// Nada que hacer
	}

	@Override
	public void activar() {

		// Activa la opcion linkada (esta opcion nunca llega a estar activa)
		opcionLinkada.activar();

	}

}

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
 *  Servidor de ficheros
 */

package org.yombo.red.servidorficheros;

public interface ServidorFicheros {

	// Los paths suministrados en getFichero() y getDirectorio() son paths logicos,
	// mientras que los que se devuelven en el listener son paths locales.

	public void getFichero( String path, String nombre, ListenerServidorFicheros listener );
	
	public void getDirectorio( String pathDirectorio, String nombreDirectorio, ListenerServidorFicheros listener );

}

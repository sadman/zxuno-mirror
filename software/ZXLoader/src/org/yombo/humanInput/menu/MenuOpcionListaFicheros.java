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
 *  Opcion de menu que implementa un directorio (lista de ficheros)
 */

package org.yombo.humanInput.menu;

import java.util.Collections;
import java.util.Comparator;

import org.yombo.red.servidorficheros.ListenerServidorFicheros;
import org.yombo.red.servidorficheros.ServidorFicheros;

public class MenuOpcionListaFicheros extends MenuOpcionLista implements ListenerServidorFicheros, Comparator<MenuOpcion> {

	private static final long serialVersionUID = 1L;

	// Mensaje que se muestra cuando la lista esta cargando
	public String refreshingString;
	
	// Nombre de la opcion "atras" o "back" creada.
	// Puede ser null (no se crea, en ese caso opcionVuelta debe ser forzosamente no null)
	public String backString;
	
	// Path y nombre logicos
	public String pathDirectorio;
	public String nombreDirectorio;
	
	public ServidorFicheros servidorFicheros;

	private boolean directorioListo;
	public String errorCarga;

	public MenuOpcionListaFicheros() {
		// Nada que hacer
	}

	@Override
	public void activar() {

		menu.opcionActiva = this;

		if ( ! directorioListo ) {
			errorCarga = null;
			servidorFicheros.getDirectorio( pathDirectorio, nombreDirectorio, this );
		}

	}

	@Override
	public void seleccionar() {

		if ( directorioListo ) {
			super.seleccionar();
		}

	}

	@Override
	public void abajo() {

		if ( directorioListo ) {
			super.abajo();
		}

	}

	@Override
	public void arriba() {
		
		if ( directorioListo ) {
			super.arriba();
		}

	}

	@Override
	public void rellenarTexto() {

		if ( directorioListo ) {
			super.rellenarTexto();
		}
		else {

			String l[] = menu.texto.cadenas;
			int i = 0;

			if ( errorCarga != null ) {
				l[ i++ ] = errorCarga;
			}
			else {
				l[ i++ ] = refreshingString;
				l[ i++ ] = "Please wait.";
			}

			int nl = l.length;
			while ( i < nl ) {
				l[ i++ ] = null;
			}			
		}

	}

	@Override
	public void ficheroListo( String error, String pathFichero, String nombreFichero ) {
		// Nada que hacer
	}

	@Override
	public void directorioListo( String error, String pathDirectorio, String nombreDirectorio, String[] nombresFicheros, boolean[] ficherosSonDirectorios ) {

		if ( error != null ) {
			errorCarga = error;
			return;
		}

		opciones.clear();		

		if ( backString != null ) {
			MenuOpcionLink opcionBack = new MenuOpcionLink();
			opcionBack.menu = menu;
			opcionBack.nombre = backString;
			opcionBack.opcionLinkada = opcionVuelta;
			opciones.add( opcionBack );
		}

        // Ordeno ya los directorios al principio para que tarde menos en ordenar despues
        int nf = nombresFicheros.length;
        for ( int i = 0; i < nf; i++ ) {
        	String nombreFichero = nombresFicheros[ i ];
        	if ( ficherosSonDirectorios[ i ] ) {
        		MenuOpcionListaFicheros opcionDirectorio = new MenuOpcionListaFicheros();
        		opcionDirectorio.menu = menu;
        		opcionDirectorio.nombre = nombreFichero + "/";
        		opcionDirectorio.identificador = identificador;
        		opcionDirectorio.opcionVuelta = this;
        		opcionDirectorio.pathDirectorio = this.pathDirectorio + this.nombreDirectorio + "/";
        		opcionDirectorio.nombreDirectorio = nombreFichero;
        		opcionDirectorio.servidorFicheros = servidorFicheros;
        		opcionDirectorio.refreshingString = refreshingString;
        		opcionDirectorio.backString = backString;
        		opcionDirectorio.scrollCiclico = scrollCiclico;
        		opciones.add( opcionDirectorio );
        	}
        }
        for ( int i = 0; i < nf; i++ ) {
        	String nombreFichero = nombresFicheros[ i ];
        	if ( ! ficherosSonDirectorios[ i ] ) {
	        	MenuOpcionFichero opcionFichero = new MenuOpcionFichero();
	        	opcionFichero.menu = menu;
	            opcionFichero.nombre = nombreFichero;
	            opcionFichero.identificador = identificador;
	            opcionFichero.opcionVuelta = this;
	            opcionFichero.pathFichero = this.pathDirectorio + this.nombreDirectorio + "/";
	            opcionFichero.nombreFichero = nombreFichero;
	            opcionFichero.servidorFicheros = servidorFicheros;
	            opcionFichero.refreshingString = refreshingString;
	            opciones.add( opcionFichero );
        	}
        }

        Collections.sort( opciones, this );

        directorioListo = true;

	}

	@Override
	public int compare( MenuOpcion o1, MenuOpcion o2 ) {
		
		int tipo1 = -1;
		int tipo2 = -1;
		Class<? extends MenuOpcion> c1 = o1.getClass().asSubclass( MenuOpcion.class );//(Class<MenuOpcion>)o1.getClass();
		Class<? extends MenuOpcion> c2 = o2.getClass().asSubclass( MenuOpcion.class );//(Class<MenuOpcion>)o2.getClass();

		if ( c1.isAssignableFrom( MenuOpcionListaFicheros.class ) ) {
			tipo1 = 0; 
		}
		else if ( c1.isAssignableFrom( MenuOpcionFichero.class ) ) {
			tipo1 = 1; 
		}

		if ( c2.isAssignableFrom( MenuOpcionListaFicheros.class ) ) {
			tipo2 = 0; 
		}
		else if ( c2.isAssignableFrom( MenuOpcionFichero.class ) ) {
			tipo2 = 1; 
		}

		if ( tipo1 != tipo2 ) {
			return tipo1 < tipo2 ? -1 : 1;
		}
		
		if ( tipo1 == 0 ) {
			return ((MenuOpcionListaFicheros)o1).nombreDirectorio.compareTo( ((MenuOpcionListaFicheros)o2).nombreDirectorio );
		}
		else if ( tipo1 == 1 ) {
			return ((MenuOpcionFichero)o1).nombreFichero.compareTo( ((MenuOpcionFichero)o2).nombreFichero );
		}

		return 0;
	}

	public boolean getDirectorioListo() {
		return directorioListo;
	}

	public void setDirectorioListo( boolean listo ) {
		directorioListo = listo;
	}

}

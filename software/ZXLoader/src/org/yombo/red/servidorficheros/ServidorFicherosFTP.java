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
 *  Servidor de ficheros locales
 */

package org.yombo.red.servidorficheros;

import java.io.File;
import java.io.IOException;

import it.sauronsoftware.ftp4j.FTPAbortedException;
import it.sauronsoftware.ftp4j.FTPClient;
import it.sauronsoftware.ftp4j.FTPDataTransferException;
import it.sauronsoftware.ftp4j.FTPException;
import it.sauronsoftware.ftp4j.FTPFile;
import it.sauronsoftware.ftp4j.FTPIllegalReplyException;
import it.sauronsoftware.ftp4j.FTPListParseException;

public class ServidorFicherosFTP extends Thread implements ServidorFicheros {

	protected ListenerServidorFicheros listener;
	
	public boolean terminar;

	// Parametros de configuracion
	public String serverString;
	public String logString;
	public String directorioInicial;
	public String pathLocalAGuardar;

	// Path logico del fichero actual (ruta en el servidor FTP) bajo directorioInicial
	protected String pathFichero;
	protected String nombreFichero;
	public boolean esDirectorio;
	
	protected FTPClient clienteFTP;
	
	public ServidorFicherosFTP() {
		clienteFTP = new FTPClient();
	}

	@Override
	public void getFichero( String path, String nombre, ListenerServidorFicheros listener ) {

		boolean enUso = false;
		synchronized( this ) {
			if ( this.listener != null ) {
				enUso = true;
			}
			else {
				this.listener = listener;
				pathFichero = path;
				nombreFichero = nombre;
				esDirectorio = false;
				this.notify();
			}
		}

		if ( enUso ) {
			// Error, servidor en uso
			listener.ficheroListo( "Error: server in use.", null, null );
		}

	}

	@Override
	public void getDirectorio( String pathDirectorio, String nombreDirectorio, ListenerServidorFicheros listener ) {

		boolean enUso = false;
		synchronized( this ) {
			if ( this.listener != null ) {
				enUso = true;
			}
			else {
				this.listener = listener;
				pathFichero = pathDirectorio;
				nombreFichero = nombreDirectorio;
				esDirectorio = true;
				this.notify();
			}
		}

		if ( enUso ) {
			// Error, servidor en uso
			listener.ficheroListo( "Error: server in use.", null, null );
		}
		
	}

	@Override
	public void run() {
		
		while ( ! terminar ) {

			boolean ejecutar = false;
			synchronized ( this ) {
				if ( listener != null ) {
					ejecutar = true;
				}
				else {
					try {
						this.wait();
					}
					catch ( InterruptedException e ) {
						// Nada que hacer
					}
				}
			}
			if ( ejecutar ) {
				ejecutarAccion();
			}
		}
	}

	private void ejecutarAccion() {

		if ( esDirectorio ) {
			cargarDirectorio();
		}
		else {
			cargarFichero();
		}
		
		pathFichero = null;
		nombreFichero = null;
		esDirectorio = true;
		listener = null;
	}
	
	protected void cargarFichero() {

		String pathDirectorioLocal = pathLocalAGuardar + pathFichero;
		String pathCompletoLocal = pathDirectorioLocal + nombreFichero;

		// Mira si existe el fichero en local
		File fich = new File( pathCompletoLocal );
		if ( fich.exists() ) {
			// Existe, ya esta listo
			listener.ficheroListo( null, pathDirectorioLocal, nombreFichero );
			return;
		}
		
		boolean conectado = false;
		try {
			clienteFTP.connect( serverString );
			conectado = true;
		} catch ( FTPException e ) {
		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		}
		if ( ! conectado ) {
			listener.ficheroListo( "Error connecting to server.", null, null );
			return;
		}

		boolean logueado = false;
		try {
			clienteFTP.login( "anonymous", logString );
			logueado = true;
		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		} catch ( FTPException e ) {
		}
		
		if ( ! logueado ) {
			listener.ficheroListo( "Error while logging in to server.", null, null );
			return;
		}

		boolean operacionOk = false;
		try {
			String directorioRaiz = clienteFTP.currentDirectory();
			String pathDirectorioCD = directorioRaiz + directorioInicial + pathFichero;

			// Cambia al directorio en el servidor FTP
			clienteFTP.changeDirectory( pathDirectorioCD );

			// Descarga el fichero
			clienteFTP.download( nombreFichero, fich );

			listener.ficheroListo( null, pathDirectorioLocal, nombreFichero );
			operacionOk = true;

		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		} catch ( FTPException e ) {
		} catch ( FTPDataTransferException e ) {
		} catch ( FTPAbortedException e ) {
		}
		finally {
			
			try {
				clienteFTP.disconnect( true );
			} catch ( IllegalStateException e ) {
			} catch ( IOException e ) {
			} catch ( FTPIllegalReplyException e ) {
			} catch ( FTPException e ) {
			}

			if ( ! operacionOk ) {
				listener.ficheroListo( "Error downloading file.", null, null );
			}
		}

	}

	protected void cargarDirectorio() {

		boolean conectado = false;
		try {
			clienteFTP.connect( serverString );
			conectado = true;
		} catch ( FTPException e ) {
		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		}
		if ( ! conectado ) {
			listener.directorioListo( "Error connecting to server.", null, null, null, null );
			return;
		}

		boolean logueado = false;
		try {
			clienteFTP.login( "anonymous", logString );
			logueado = true;
		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		} catch ( FTPException e ) {
		}
		
		if ( ! logueado ) {
			listener.directorioListo( "Error while logging in to server.", null, null, null, null );
			return;
		}

		boolean operacionOk = false;
		try {
			String directorioRaiz = clienteFTP.currentDirectory();
			String s1 = nombreFichero + "/";
			String pathDirectorioCD = directorioRaiz + directorioInicial + pathFichero + s1;
			String pathDirectorioLocal = pathLocalAGuardar + pathFichero;
			String pathCompletoLocal = pathDirectorioLocal + s1;

			// Crea directorio local
			boolean directorioExiste = false;
			File fich = new File( pathCompletoLocal );
			if ( ! fich.exists() ) {
				if ( ! fich.mkdir() ) {
					listener.directorioListo( "Error creating local directory.", null, null, null, null );
					return;
				}
			}
			else {
				if ( ! fich.isDirectory() ) {
					listener.directorioListo( "Error creating local directory (file already exists)", null, null, null, null );
					return;
				}
				else {
					directorioExiste = true;
				}
			}

			// Cambia al directorio en el servidor FTP
			clienteFTP.changeDirectory( pathDirectorioCD );

			String nombresFicheros[] = null;
			boolean ficherosSonDirectorios[] = null;

			// Obtiene listado del directorio
			FTPFile[] list = clienteFTP.list();
			int nf = list.length;
			if ( nf > 0 ) {
				int numFicherosValidos = 0;
				for ( int i = 0; i < nf; i++ ) {
					FTPFile f = list[ i ];
					int tipo = f.getType();
					if ( tipo == FTPFile.TYPE_DIRECTORY ) {
						numFicherosValidos++;
					}
					else if ( tipo == FTPFile.TYPE_FILE ) {
						numFicherosValidos++;
					}
				}
				
				nombresFicheros = new String[ numFicherosValidos ];
				ficherosSonDirectorios = new boolean[ numFicherosValidos ];

				int iv = 0;
				for ( int i = 0; i < nf; i++ ) {
					FTPFile f = list[ i ];
					int tipo = f.getType();
					if ( tipo == FTPFile.TYPE_DIRECTORY ) {
						nombresFicheros[ iv ] = f.getName();
						ficherosSonDirectorios[ iv ] = true;
						iv++;
					}
					else if ( tipo == FTPFile.TYPE_FILE ) {
						nombresFicheros[ iv ] = f.getName();
						ficherosSonDirectorios[ iv ] = false;
						iv++;
					}
				}
			}

			listener.directorioListo( null, pathDirectorioLocal, nombreFichero, nombresFicheros, ficherosSonDirectorios );
			operacionOk = true;

		} catch ( IllegalStateException e ) {
		} catch ( IOException e ) {
		} catch ( FTPIllegalReplyException e ) {
		} catch ( FTPException e ) {
		} catch ( FTPDataTransferException e ) {
		} catch ( FTPAbortedException e ) {
		} catch ( FTPListParseException e ) {
		}
		finally {
			
			try {
				clienteFTP.disconnect( true );
			} catch ( IllegalStateException e ) {
			} catch ( IOException e ) {
			} catch ( FTPIllegalReplyException e ) {
			} catch ( FTPException e ) {
			}

			if ( ! operacionOk ) {
				listener.directorioListo( "Error downloading directory.", null, null, null, null );
			}
		}
	}

	public void terminarServidor() {
		terminar = true;
		synchronized ( this ) {
			this.notify();
			
		}
	}
}

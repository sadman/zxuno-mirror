package org.yombo.texto;

import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.GraphicsEnvironment;
import java.io.File;
import java.io.IOException;

import org.yombo.log.Log;
import org.yombo.utils.Constantes;

public class UtilsFuentes {

	public static void registrarFuenteDesdeFichero( String nombreFichero ) {
		
		// nombreFichero es path bajo Constantes.PATH_FUENTES
		String path = Constantes.PATH_FUENTES + nombreFichero;

		try {
			GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
			ge.registerFont( Font.createFont( Font.TRUETYPE_FONT, new File( path ) ) );
		}
		catch ( IOException e ) {
			Log.log( "Error: I/O Error while registering truetype font file: " + path );
		}
		catch ( FontFormatException e ) {
			Log.log( "Error: Font Format Exception while registering truetype font file: " + path );
		}
		
	}
}

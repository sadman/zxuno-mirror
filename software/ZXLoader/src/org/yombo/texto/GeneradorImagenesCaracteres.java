package org.yombo.texto;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;

import org.yombo.log.Log;
import org.yombo.log.LoggerStdout;
import org.yombo.motor3d.texto.GestorTexto;
import org.yombo.utils.Constantes;
import org.yombo.utils.UtilsImagen;

public class GeneradorImagenesCaracteres {

	public static final String pathFuente = "Rapscallion/RAPSCALL.ttf";
	public static final String nombreFuente = "Rapscallion";
	//public static final int tamFuente = 96;
	public static final int tamFuente = 36;
	public static final int estiloFuente = Font.PLAIN;
	
	
	
	private static BufferedImage imagenDummy;
	
	public static void main(String[] args) {

		Log.addLogger( new LoggerStdout() );

		//new GeneradorImagenesCaracteres().generarDigitos();
		new GeneradorImagenesCaracteres().generarImagenPrueba();

	}

	public void generarImagenPrueba() {
		
		UtilsFuentes.registrarFuenteDesdeFichero( pathFuente );

		Font fuente = new Font( nombreFuente, estiloFuente, tamFuente );

		UtilsImagen.grabarImagenPNG( "prueba.png", generarImagenDeCadena( "Va de retro", fuente ) );
	}

	public void generarDigitos() {
		
		UtilsFuentes.registrarFuenteDesdeFichero( pathFuente );

		Font fuente = new Font( nombreFuente, estiloFuente, tamFuente );

		for ( int i = 0; i < 10; i++ ) {
			String caracter = "" + i;
			UtilsImagen.grabarImagenPNG( caracter + ".png", generarImagenDeCadena( caracter, fuente ) );
			System.out.println( "Grabada imagen " + new File( caracter + ".png" ).getAbsolutePath() );
		}

	}

	public BufferedImage generarImagenDeCadena( String cadena, Font fuente ) {

		String [] cadenas = cadena.split( "\n" );
		
		Graphics2D g2Dummy = null;
		int ascent = 0;
    	int lineHeight = 0;
    	int descent = 0;
    	int leading = 0;
    	int avance = 0;

        if ( imagenDummy == null ) {
        	imagenDummy = new BufferedImage( 10, 10, BufferedImage.TYPE_INT_ARGB );
        }
        g2Dummy = imagenDummy.createGraphics();

    	FontMetrics m = g2Dummy.getFontMetrics( fuente );
    	ascent = m.getAscent();
    	lineHeight = m.getHeight();
    	descent = m.getDescent();
    	leading = m.getLeading();
    	avance = m.charWidth( 'M' );

    	int tamXCaracter = avance;
    	int tamYCaracter = lineHeight;

    	int numLineas = cadenas.length;
    	int maxTamX = 0;
    	for ( int l = 0; l < numLineas; l++ ) {
    		int t = cadenas[ l ].length();
    		if ( maxTamX < t ) {
    			maxTamX = t;
    		}
    	}

    	int tamXImagen = tamXCaracter * maxTamX;
    	int tamYImagen = tamYCaracter * numLineas;
    	
//    	int tamXImagen = 256;
//    	int tamYImagen = 192;
    	
    	BufferedImage imgResult = new BufferedImage( tamXImagen, tamYImagen, BufferedImage.TYPE_INT_ARGB );

    	
        Graphics2D g2 = imgResult.createGraphics();

        g2.setFont( fuente );

        Color clLetras = new Color( 0xFF000000, true );
        Color clBackGround = new Color( 0xFFFFFFFF, true );

    	g2.setColor( clLetras );
    	g2.setBackground( clBackGround );

    	g2.clearRect( 0, 0, tamXImagen, tamYImagen );

    	int yLinea = ascent;
    	for ( int iLinea = 0; iLinea < numLineas; iLinea++ ) {
    	
    		g2.drawString( cadenas[ iLinea ], 0, yLinea );

    		yLinea+= tamYCaracter;
    	}

    	
    	return imgResult;

	}
}

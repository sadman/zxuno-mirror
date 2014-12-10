/* 
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
 *  Aplicacion ZXLoader
 */
package org.yombo.apps.zxloader;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTree;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeCellRenderer;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

import org.yombo.entorno.Opciones;
import org.yombo.humanInput.menu.Menu;
import org.yombo.humanInput.menu.MenuListener;
import org.yombo.humanInput.menu.MenuOpcion;
import org.yombo.humanInput.menu.MenuOpcionFichero;
import org.yombo.humanInput.menu.MenuOpcionLista;
import org.yombo.humanInput.menu.MenuOpcionListaFicheros;
import org.yombo.log.Log;
import org.yombo.red.servidorficheros.ServidorFicherosFTP;
import org.yombo.red.servidorficheros.ServidorFicherosLocal;

public class ZXLoader implements TreeSelectionListener, MenuListener, ActionListener {

	public static final String VERSION = "1.0";
	
	public static final String TITULO = "ZXLauncher v" + VERSION;
	
	public static final String PATH_CONFIG = "../ZXLoader.conf";

	public JFrame frame;
	
	public JTree arbol;
	public DefaultMutableTreeNode raiz; 
	public DefaultTreeModel modeloArbol; 

	public ServidorFicherosLocal servidorLocal;
	public ServidorFicherosFTP servidorFTP;

	public Menu menu;
	
	public ImageIcon iconoZX; 
	
	public boolean terminar;
	
	private int setSeleccionado; // 0 o 1
	private String comandoTape1;
	private String comandoSnapshot1;
	private String comandoTape2;
	private String comandoSnapshot2;
	
	private boolean peticionAbrirDirectorio;
	private MenuOpcionListaFicheros opcionPeticionAbrirDirectorio;
	private DefaultMutableTreeNode nodoPadrePeticionAbrirDirectorio;
	
	private JRadioButton radioSet1;
	private JRadioButton radioSet2;
	private TextField tfComandoTape1;
	private TextField tfComandoSnapshot1;
	private TextField tfComandoTape2;
	private TextField tfComandoSnapshot2;
	
	private Process proceso;

	private byte [] bufer = new byte[ 256 * 1024 ];
	
	public static void main( String[] args ) {
		
        System.out.println("ZXLauncher v" + VERSION );
        System.out.println("Copyright (C) 2014  Juan Jose Luna Espinosa juanjoluna@gmail.com");
        System.out.println("");
        System.out.println("This program is free software: you can redistribute it and/or modify");
        System.out.println("it under the terms of the GNU General Public License as published by");
        System.out.println("the Free Software Foundation, version 3 of the License.");
        System.out.println("");
        System.out.println("This program is distributed in the hope that it will be useful,");
        System.out.println("but WITHOUT ANY WARRANTY; without even the implied warranty of");
        System.out.println("MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the");
        System.out.println("GNU General Public License for more details.");
        System.out.println("");
        System.out.println("You should have received a copy of the GNU General Public License");
        System.out.println("along with this program.  If not, see <http://www.gnu.org/licenses/>.");
        System.out.println("");
        
		ZXLoader zxLoader = new ZXLoader();

		zxLoader.cicloAplicacion();
	}

	public ZXLoader() {

		cargarOpciones();		

        servidorLocal = new ServidorFicherosLocal();
        
        servidorFTP = new ServidorFicherosFTP();
//        servidorFTP.serverString = "127.0.0.1";
//        servidorFTP.directorioInicial = "";
        servidorFTP.serverString = "ftp.worldofspectrum.org";
        servidorFTP.directorioInicial = "pub/sinclair/";
        servidorFTP.logString = "ZXLoader_v" + VERSION;
        servidorFTP.pathLocalAGuardar =  "../data/misc/zxloader/ftp/";
        servidorFTP.start();

		frame = new JFrame( TITULO );
        frame.setSize( new Dimension( 800, 600 ) );

        JPanel contentPane = new JPanel( new BorderLayout() );
        contentPane.setOpaque( true );

        iconoZX = new ImageIcon( "../data/images/zxloader/zx.png" );

        crearArbol();

        JScrollPane scrollPaneArbol = new JScrollPane( arbol );

        
        JPanel panelOpciones = new JPanel();
        panelOpciones.setLayout( new BoxLayout( panelOpciones, BoxLayout.PAGE_AXIS ) );
        panelOpciones.setBorder( BorderFactory.createEmptyBorder( 20, 20, 20, 20 ) );

        JPanel panelSet = new JPanel();
        panelSet.setBorder( BorderFactory.createTitledBorder( "Select emulator" ) );
        radioSet1 = new JRadioButton( "Emulator 1" );
        radioSet1.setActionCommand( "1" );
        radioSet1.addActionListener( this );
        radioSet2 = new JRadioButton( "Emulator 2" );
        radioSet2.setActionCommand( "2" );
        radioSet2.addActionListener( this );
        panelSet.add( Box.createRigidArea( new Dimension( 0, 20 ) ) );
        panelSet.add( radioSet1 );
        panelSet.add( Box.createRigidArea( new Dimension( 0, 20 ) ) );
        panelSet.add( radioSet2 );
        panelSet.add( Box.createRigidArea( new Dimension( 0, 20 ) ) );
        panelOpciones.add( panelSet );
        ButtonGroup group = new ButtonGroup();
        group.add( radioSet1 );
        group.add( radioSet2 );
        
        JPanel panelSet1 = new JPanel();
        panelSet1.setBorder( BorderFactory.createTitledBorder( "Emulator 1 options. Insert <path> literally in a command to specify Spectrum file being loaded." ) );
        GridBagLayout gridbag1 = new GridBagLayout();
        panelSet1.setLayout( gridbag1 );
        tfComandoTape1 = new TextField();
        anyadirLabelTextField( "Emulator command for tapes:", tfComandoTape1, panelSet1 );
        tfComandoSnapshot1 = new TextField();
        anyadirLabelTextField( "Emulator command for snapshots:", tfComandoSnapshot1, panelSet1 );
        panelOpciones.add( Box.createRigidArea( new Dimension( 0, 50 ) ) );
        panelOpciones.add( panelSet1 );

        JPanel panelSet2 = new JPanel();
        panelSet2.setBorder( BorderFactory.createTitledBorder( "Emulator 2 options. Insert <path> literally in a command to specify Spectrum file being loaded." ) );
        GridBagLayout gridbag2 = new GridBagLayout();
        panelSet2.setLayout( gridbag2 );
        tfComandoTape2 = new TextField();
        anyadirLabelTextField( "Emulator command for tapes:", tfComandoTape2, panelSet2 );
        tfComandoSnapshot2 = new TextField();
        anyadirLabelTextField( "Emulator command for snapshots:", tfComandoSnapshot2, panelSet2 );
        panelOpciones.add( Box.createRigidArea( new Dimension( 0, 50 ) ) );
        panelOpciones.add( panelSet2 );

        JPanel panelSave = new JPanel();
        panelSave.setBorder( BorderFactory.createTitledBorder( "Save options" ) );
        JButton buttonSave = new JButton( "Save options" );
        buttonSave.setActionCommand( "save" );
        buttonSave.addActionListener( this );
        panelSave.add( buttonSave );
        panelOpciones.add( panelSave );

        JPanel panelAbout = new JPanel();
        panelAbout.setLayout( new BoxLayout( panelAbout, BoxLayout.PAGE_AXIS ) );
        panelAbout.setBorder( BorderFactory.createEmptyBorder( 20, 20, 20, 20 ) );
        JTextArea ta = new JTextArea();
        ta.setEditable( false );
        String about = "ZXLauncher v" + VERSION + "\n" +
        "Copyright (C) 2014  Juan Jose Luna Espinosa\n" +
        "\n" +
        "This program is free software: you can redistribute it and/or modify\n" +
        "it under the terms of the GNU General Public License as published by\n" +
        "the Free Software Foundation, version 3 of the License.\n" +
        "\n" +
        "This program is distributed in the hope that it will be useful,\n" +
        "but WITHOUT ANY WARRANTY; without even the implied warranty of\n" +
        "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n" +
        "GNU General Public License for more details.\n" +
        "\n" +
        "You should have received a copy of the GNU General Public License\n" +
        "along with this program.  If not, see <http://www.gnu.org/licenses/>.\n";
        ta.setText( about );
        panelAbout.add( ta );

        JTabbedPane tabs = new JTabbedPane();
        tabs.addTab( "Spectrum files", iconoZX, scrollPaneArbol, "Select Spectrum files here");
        tabs.addTab( "Options", new ImageIcon( "../data/images/zxloader/tools.png" ), panelOpciones, "Options");
        tabs.addTab( "About...", null, panelAbout, "About...");
        
        contentPane.add( tabs, BorderLayout.CENTER);

        frame.setContentPane( contentPane );

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        ponerDatosEnGUI();
        
        frame.setVisible(true);

	}
	
	private void anyadirLabelTextField( String label, TextField tf, JPanel padre ) {

		GridBagConstraints c = new GridBagConstraints();
		c.anchor = GridBagConstraints.EAST;
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.fill = GridBagConstraints.NONE;
        c.weightx = 0.0;
        padre.add( new JLabel( label ), c );

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.fill = GridBagConstraints.HORIZONTAL;
        c.weightx = 1.0;
        padre.add( tf, c );
	}

	private void crearArbol() {

		menu = new Menu();
		menu.listener = this;

		MenuOpcionLista opcionPrincipal = new MenuOpcionLista();
        opcionPrincipal.menu = menu;
        opcionPrincipal.nombre = "All";
        opcionPrincipal.identificador = 0;

		MenuOpcionListaFicheros opcionDirLocal = new MenuOpcionListaFicheros();
		opcionDirLocal.menu = menu;
		opcionDirLocal.nombre = "Local file";
		opcionDirLocal.identificador = 0;
		opcionDirLocal.servidorFicheros = servidorLocal;
		opcionDirLocal.pathDirectorio = "../data/misc/zxloader/";
		opcionDirLocal.nombreDirectorio = "local";
		opcionPrincipal.opciones.add( opcionDirLocal );
		
		MenuOpcionLista opcionCargarRemoto = new MenuOpcionLista();
        opcionCargarRemoto.menu = menu;
        opcionCargarRemoto.nombre = "worldofspectrum.org";
        opcionCargarRemoto.identificador = 0;
        opcionPrincipal.opciones.add( opcionCargarRemoto );

        MenuOpcionListaFicheros opcionCargarGames = new MenuOpcionListaFicheros();
        opcionCargarGames.menu = menu;
        opcionCargarGames.nombre = "Games";
        opcionCargarGames.identificador = 0;
        opcionCargarGames.servidorFicheros = servidorFTP;
        opcionCargarGames.pathDirectorio = "";
        opcionCargarGames.nombreDirectorio = "games";
        opcionCargarRemoto.opciones.add( opcionCargarGames );

        MenuOpcionListaFicheros opcionCargarDemos = new MenuOpcionListaFicheros();
        opcionCargarDemos.menu = menu;
        opcionCargarDemos.nombre = "Demos...";
        opcionCargarDemos.identificador = 0;
        opcionCargarDemos.servidorFicheros = servidorFTP;
        opcionCargarDemos.pathDirectorio = "";
        opcionCargarDemos.nombreDirectorio = "demos";
        opcionCargarDemos.titulo = "Demos directory";
        opcionCargarRemoto.opciones.add( opcionCargarDemos );

        MenuOpcionListaFicheros opcionCargarMisc = new MenuOpcionListaFicheros();
        opcionCargarMisc.menu = menu;
        opcionCargarMisc.nombre = "Misc...";
        opcionCargarMisc.identificador = 0;
        opcionCargarMisc.servidorFicheros = servidorFTP;
        opcionCargarMisc.pathDirectorio = "";
        opcionCargarMisc.nombreDirectorio = "misc";
        opcionCargarRemoto.opciones.add( opcionCargarMisc );

        raiz = new DefaultMutableTreeNode( opcionPrincipal, true );

        modeloArbol = new DefaultTreeModel( raiz );
        //modeloArbol.addTreeModelListener(new MyTreeModelListener() );

        arbol = new JTree( modeloArbol );
        //arbol.setEditable(true);
        arbol.getSelectionModel().setSelectionMode( TreeSelectionModel.SINGLE_TREE_SELECTION );
        arbol.setShowsRootHandles( true );

        DefaultTreeCellRenderer renderer = new DefaultTreeCellRenderer();
        renderer.setLeafIcon( this.iconoZX );
        arbol.setCellRenderer(renderer);
        
        arbol.addTreeSelectionListener( this );
        
        abrirDirectorio( opcionPrincipal, raiz );
	}

	private void cicloAplicacion() {

		while ( ! terminar ) {

			// Mira si ha terminado el proceso y pone la variable a null
			if ( proceso != null ) {
				boolean procesoTerminado = false;
				try {
					proceso.exitValue();
					procesoTerminado = true;
				}
				catch ( IllegalThreadStateException e ) {
					// Nada que hacer
				}
				if ( procesoTerminado ) {
					proceso = null;
					frame.setTitle( TITULO + " - Ready" );
				}
			}

			procesarPeticiones();

			MenuOpcion opcionActiva = menu.opcionActiva;
			if ( opcionActiva != null ) {
				opcionActiva.tick( 0.0d,  0.0d );
			}

			try {
				Thread.sleep( 250 );
			} catch (InterruptedException e) {
				// Nada que hacer
			}
		}
		
	}

	private void procesarPeticiones() {

		if ( peticionAbrirDirectorio ) {
			boolean listo = opcionPeticionAbrirDirectorio.getDirectorioListo();
			boolean error = opcionPeticionAbrirDirectorio.errorCarga != null;
			if ( listo ) {
				abrirDirectorio( opcionPeticionAbrirDirectorio, nodoPadrePeticionAbrirDirectorio );				
			}
			if ( listo || error ) {
				peticionAbrirDirectorio = false;
			}
		}

	}

	private void hacerPeticionAbrirDirectorio( MenuOpcionListaFicheros opcion, DefaultMutableTreeNode nodo ) {
		if ( peticionAbrirDirectorio ) {
			return;
		}
		peticionAbrirDirectorio = true;
		opcionPeticionAbrirDirectorio = opcion;
		nodoPadrePeticionAbrirDirectorio = nodo;
	}

	private void abrirDirectorio( MenuOpcionLista opcion, DefaultMutableTreeNode nodoPadre ) {
		
		int no = opcion.opciones.size();
		if ( no > 0 ) {
		
			for ( int i = 0; i < no; i++ ) {
				MenuOpcion opcion1 = opcion.opciones.get( i );
				anyadirNodo( opcion1, nodoPadre );
			}
			
			// Hace scroll para que se vea el primer hijo (y abre el padre)
		    arbol.scrollPathToVisible( new TreePath( ((DefaultMutableTreeNode)nodoPadre.getChildAt( 0 )).getPath() ) );
		}
		
	}

	private void anyadirNodo( MenuOpcion opcion, DefaultMutableTreeNode nodoPadre ) {

		DefaultMutableTreeNode nodo = new DefaultMutableTreeNode( opcion );

	    modeloArbol.insertNodeInto( nodo, nodoPadre, nodoPadre.getChildCount() );

	}

    public void cargarPrograma( String path, String nombre ) {
    	String f = nombre.toLowerCase();
    	if ( esFicheroSpectrum( f ) ) {
    		cargarProgramaFicheroSpectrum( path, nombre );
    	}
    	else if ( f.endsWith(".zip") )  {
    		cargarProgramaZip( path, nombre );
    	}
    }

    public boolean esFicheroSpectrum( String f ) {
    	return f.endsWith( ".tzx") || f.endsWith( ".tap" ) || f.endsWith( ".z80" ) || f.endsWith( ".sna" ) || f.endsWith( ".szx" );
    }
    
    public boolean esFicheroCintaSpectrum( String f ) {
    	return f.endsWith( ".tzx") || f.endsWith( ".tap" );
    }

    private void cargarProgramaFicheroSpectrum( String path, String nombre ) {

    	if ( proceso != null ) {
    		return;
    	}

    	boolean esCinta = esFicheroCintaSpectrum( nombre.toLowerCase() );
    	
    	String cmd = null;
    	if ( setSeleccionado == 0 ) {
    		if ( esCinta ) {
    			cmd = comandoTape1;
    		}
    		else {
    			cmd = comandoSnapshot1;
    		}
    	}
    	else {
    		if ( esCinta ) {
    			cmd = comandoTape2;
    		}
    		else {
    			cmd = comandoSnapshot2;
    		}
    	}
    	
    	if ( cmd == null || "".equals( cmd ) ) {
    		return;
    	}

    	String [] params = cmd.split( " " );

    	String pathCompleto = path + nombre;
    	File fichero = new File( pathCompleto );
    	if ( fichero.exists() && fichero.isFile() ) {
    		try {
    			pathCompleto = fichero.getCanonicalPath();
    		}
    		catch ( IOException e ) {
    			// Nada que hacer
    		}
    	}
    	int np = params.length;
    	for ( int i = 0; i < np; i++ ) {
    		params[ i ] = params[ i ].replace( "<path>", pathCompleto );
    	}

    	try {

    		File f = new File( params[ 0 ] );
			File d = f.getParentFile();
			
			if ( d != null ) {
				params[ 0 ] = f.getCanonicalPath();
			}

    		ProcessBuilder pb = new ProcessBuilder( params );

			if ( d != null ) {
				pb.directory( d );
			}

			pb.inheritIO();
			
			proceso = pb.start();
			
			frame.setTitle( TITULO + " - Running process..." );

		} catch ( IOException e ) {
			// Nada que hacer
			System.out.println("IO Exception creating process: " + e );
		}
    }

    private void cargarProgramaZip( String path, String nombre ) {
    	
    	String s1 = path + nombre;

		String nombreEntrada = null;
        try {
        	InputStream is = new FileInputStream( s1 );
        	ZipInputStream zis = new ZipInputStream( is );
        	ZipEntry entrada = null;
        	try {
				while ( ( entrada = zis.getNextEntry() ) != null ) {
					String n = entrada.getName();
					if ( esFicheroSpectrum( n.toLowerCase() ) ) {
						if ( nombreEntrada == null || nombreEntrada.compareTo( n ) > 0 ) {
							nombreEntrada = n;
						}
					}
				}
        	} finally {
        		zis.close();
	        }
			
			if ( nombreEntrada == null ) {
				Log.log( "No Spectrum files found in zip file: " + nombre );
				return;
			}
			
			String s2 = path + nombreEntrada;
			File fich = new File( s2 );
			if ( ! fich.exists() ) {
				
	        	InputStream is2 = new FileInputStream( s1 );
	        	ZipInputStream zis2 = new ZipInputStream( is2 );
	        	entrada = null;
	        	try {
					while ( ( entrada = zis2.getNextEntry() ) != null ) {
						String n = entrada.getName();
						if ( nombreEntrada.equals( n ) ) {
							FileOutputStream fos = null; 
							try {
			                    fos = new FileOutputStream( s2 );
			                    int longitud = 0;
			                    while ( ( longitud = zis2.read( bufer ) ) > 0 ) {
			                        fos.write( bufer, 0, longitud );
			                    }
			                } finally {
			                    if ( fos != null) {
			                    	fos.close();
			                    }
			                }
						}
					}
	        	} finally {
	        		zis2.close();
		        }
			}

			cargarProgramaFicheroSpectrum( path, nombreEntrada );
			
		} catch (IOException e) {
			Log.log( "Error: IOEexception loading zip file: " + e.getMessage() );
			return;
		}
    }
	
	@Override
	public void eventoVisibilidadMenu( boolean visible ) {
		// Nada que hacer
	}

	@Override
	public void opcionSeleccionada( MenuOpcion opcion ) {

		if ( opcion.getClass().isAssignableFrom( MenuOpcionFichero.class ) ) {
			MenuOpcionFichero opcion1 = (MenuOpcionFichero)opcion;
			cargarPrograma( opcion1.pathFicheroLocal, opcion1.nombreFicheroLocal );
		}

	}

	@Override
	public double getValorMenuOpcionDouble( MenuOpcion opcion ) {
		return 0;
	}

	@Override
	public boolean getValorMenuOpcionBoolean( MenuOpcion opcion ) {
		return false;
	}

	@Override
	public int getValorMenuOpcionInt( MenuOpcion opcion ) {
		return 0;
	}

	@Override
	public String getValorMenuOpcionString( MenuOpcion opcion ) {
		return null;
	}

	@Override
	public void valueChanged( TreeSelectionEvent arg0 ) {

		// Seleccion

		DefaultMutableTreeNode nodo = (DefaultMutableTreeNode)arbol.getLastSelectedPathComponent();

		if ( nodo == null ) {
			return;
		}

		MenuOpcion opcion = (MenuOpcion)nodo.getUserObject();

		if ( MenuOpcionListaFicheros.class.isAssignableFrom( opcion.getClass() ) ) {
			MenuOpcionListaFicheros opcion1 = (MenuOpcionListaFicheros)opcion;
			if ( ! opcion1.getDirectorioListo() ) {
				hacerPeticionAbrirDirectorio( opcion1, nodo );
			}
		}
		else if ( MenuOpcionLista.class.isAssignableFrom( opcion.getClass() ) ) {
			MenuOpcionLista opcion1 = (MenuOpcionLista)opcion;
			if ( nodo.getChildCount() == 0 ) {
				abrirDirectorio( opcion1, nodo );
			}
		}

		opcion.activar();

	}

	@Override
	public void actionPerformed( ActionEvent e ) {

		if ( "save".equals( e.getActionCommand() ) ) {
			salvarOpciones();
		}
		else {
			if ( radioSet1.isSelected() ) {
				setSeleccionado = 0;
			}
			else {
				setSeleccionado = 1;
			}
		}
		
	}

	private void salvarOpciones() {

		cogerDatosDeGUI();
		
		Opciones opciones = new Opciones();
		config2Opciones( opciones );
		opciones.grabar( PATH_CONFIG );

	}
	
	private void cargarOpciones() {

		setSeleccionado = 0;
		comandoTape1 = "fuse --tape <path>";
		comandoSnapshot1= "fuse --snapshot <path>";
		comandoTape2 = "";
		comandoSnapshot2= "";
		
		Opciones opciones = new Opciones();
		opciones.cargar( PATH_CONFIG );
		opciones2Config( opciones );
		
		opciones = new Opciones();
		config2Opciones( opciones );
		opciones.grabar( PATH_CONFIG );
	}

	private void config2Opciones(Opciones opciones) {

		opciones.setOpcion( "emulator", "" + setSeleccionado );
		opciones.setOpcion( "cmdTape1", comandoTape1 );
		opciones.setOpcion( "cmdSnapshot1", comandoSnapshot1 );
		opciones.setOpcion( "cmdTape2", comandoTape2 );
		opciones.setOpcion( "cmdSnapshot2", comandoSnapshot2 );
	}

	private void opciones2Config( Opciones opciones ) {

		String opc = opciones.getOpcion( "emulator" );
		if ( opc != null ) {
			setSeleccionado = opc.equals( "0" ) ? 0 : 1;
		}
		opc = opciones.getOpcion( "cmdTape1" );
		if ( opc != null ) {
			comandoTape1 = opc;
		}
		opc = opciones.getOpcion( "cmdSnapshot1" );
		if ( opc != null ) {
			comandoSnapshot1 = opc;
		}
		opc = opciones.getOpcion( "cmdTape2" );
		if ( opc != null ) {
			comandoTape2 = opc;
		}
		opc = opciones.getOpcion( "cmdSnapshot2" );
		if ( opc != null ) {
			comandoSnapshot2 = opc;
		}
	}
	
	private void cogerDatosDeGUI() {
		setSeleccionado = radioSet1.isSelected() ? 0 : 1;
		comandoTape1 = tfComandoTape1.getText();
		comandoSnapshot1 = tfComandoSnapshot1.getText();
		comandoTape2 = tfComandoTape2.getText();
		comandoSnapshot2 = tfComandoSnapshot2.getText();
	}
	
	private void ponerDatosEnGUI() {
		if ( setSeleccionado == 0 ) {
			radioSet1.setSelected( true );
		}
		else {
			radioSet2.setSelected( true );
		}
		tfComandoTape1.setText( comandoTape1 );
		tfComandoSnapshot1.setText( comandoSnapshot1 );
		tfComandoTape2.setText( comandoTape2 );
		tfComandoSnapshot2.setText( comandoSnapshot2 );
	}
}
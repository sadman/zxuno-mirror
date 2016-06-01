<?php mail('_@antoniovillena.es, administracion@zxuno.com', 'Formulario de Contacto',
          "  Nombre:   $_POST[author]\n".
          "  Email:    $_POST[email]\n".
          "  Asunto:   $_POST[asunto]\n".
          "  Mensaje:\n$_POST[comment]\n\n",
          "Reply-To: $_POST[email]\nMIME-Version:1.0\nContent-type:text/plain;charset=utf-8\n")?>
<?php if ($_GET['lang']=='es'){
    echo file_get_contents('header.html')?>
    <div id="menu">
      <a href="index.shtml"      style="width:50px">Inicio</a>
      <span>·</span>
      <a href="http://zxuno.com/forum" target="_blank" style="width:40px">Foro</a>
      <span>·</span>
      <a href="maquina.shtml"    style="width:95px">La Máquina</a>
      <span>·</span>
      <a href="descarga.shtml"   style="width:78px">Descarga</a>
      <span>·</span>
      <a href="media.shtml"      style="width:52px">Media</a>
      <span>·</span>
      <a href="faq.shtml"        style="width:45px">FAQ</a>
      <span>·</span>
      <span                      style="width:75px">Contacto</span>
      <span>·</span>
      <a href="contacto_e.shtml" style="width:62px">[English]</a></div>
    <div id="main">
      Gracias por contactar con nosotros. En pocos días recibirá nuestra respuesta.</div>
<?php echo file_get_contents('footer.html');
  }
  else{
    echo file_get_contents('header_e.html')?>
    <div id="menu" style="width:620px">
      <a href="index_e.shtml"    style="width:52px">Home</a>
      <span>·</span>
      <a href="http://zxuno.com/forum" target="_blank" style="width:55px">Forum</a>
      <span>·</span>
      <a href="maquina_e.shtml"  style="width:102px">The Machine</a>
      <span>·</span>
      <a href="descarga_e.shtml" style="width:81px">Download</a>
      <span>·</span>
      <a href="media_e.shtml"    style="width:52px">Media</a>
      <span>·</span>
      <a href="faq_e.shtml"      style="width:45px">FAQ</a>
      <span>·</span>
      <span                      style="width:65px">Contact</span>
      <span>·</span>
      <a href="contacto.shtml"   style="width:63px">[Spanish]</a></div>
    <div id="main">
      Thank you for contact with us. Briefly you\'ll receive our answer.</div>
<?php echo file_get_contents('footer_e.html');
  }
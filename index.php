<?php
// le code pilotant la transformation
include( dirname(__FILE__).'/Tei2docx.php' );
// Soumission en post
if ( isset($_POST['post']) ) {
  echo Toff_tei2docx::doPost();
  exit();
}
?><!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8"/>
    <title>Toff : TEI vers document office, docx</title>
    <link rel="stylesheet" type="text/css" href="//oeuvres.github.io/Teinte/tei2html.css" />
  </head>
  <body>
    <div id="article">
      <header id="header">
        <h1>Toff</h1>
      </header>
      <div id="contenu">

    <h1>Toff, reprendre du <a href="//www.tei-c.org/release/doc/tei-p5-doc/fr/html/REF-ELEMENTS.html">TEI</a> au traitement de textes (docx)</h1>
    <p class="byline">par <a onmouseover="this.href='mailto'+'\x3A'+'frederic.glorieux'+'\x40'+'fictif.org'" href="#">Frédéric Glorieux</a></p>
    <form enctype="multipart/form-data" method="POST" name="odt">
      <input type="hidden" name="post" value="post"/>
      <input type="file" size="70" name="tei" accept="text/xml"/>
      <input type="submit" name="download" value="Télécharger"/>
    </form>
    <article class="text" style="width: 80ex; ">
      <p>Ce programme permet de reprendre des fichiers XML/TEI avec un traitement de textes (Microsoft.Word, LibreOffice, OpenOffice, ou autre application acceptant le format docx).
      Il faut toutefois comprendre, et accepter, que le format XML permet des structures plus complexes que ce qu’autorise une interface bureautique, par exemple sur les attributs, ou les imbrications, si bien que la transformation vers docx peut conduire à des pertes de structure (mais pas de texte). Le logiciel a été testé sur des textes de littérature (poésie, théâtre, roman, théorie avec notes…), le risque de perte est plus important pour par exemple des éditions critiques complexes (ex : plusieurs niveau de notes). Quel que soit le soin porté au programme, il y a un risque inévitable de de fichier docx non conforme (LibreOffice est plus tolérant que Microsoft.Word).</p>
    </article>
    </div>
  </body>
</html>

<?php
// le code pilotant la transformation
include( dirname(__FILE__).'/Tei2docx.php' );
// Soumission en post
if ( isset($_POST['post']) ) {
  echo Reteint_tei2docx::doPost();
  exit();
}
?><!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8"/>
    <title>Reteint : TEI vers document office, docx</title>
    <link rel="stylesheet" type="text/css" href="//oeuvres.github.io/Teinte/tei2html.css" />
  </head>
  <body>
    <div id="article">
      <header id="header">
        <h1>Reteint, TEI ► docx</h1>
      </header>
      <div id="contenu">

    <h1>Reteint, reprendre du <a href="//www.tei-c.org/release/doc/tei-p5-doc/fr/html/REF-ELEMENTS.html">TEI</a> au traitement de textes (docx)</h1>
    <p class="byline">par <a onmouseover="this.href='mailto'+'\x3A'+'frederic.glorieux'+'\x40'+'fictif.org'" href="#">Frédéric Glorieux</a></p>
    <form enctype="multipart/form-data" method="POST" name="odt">
      <input type="hidden" name="post" value="post"/>
      <input type="file" size="70" name="tei" accept="text/xml"/>
      <input type="submit" name="download" value="Télécharger"/>
    </form>
    <article class="text" style="width: 80ex; ">
      <p><a href="https://github.com/oeuvres/Reteint">Reteint</a> transforme un fichier XML/TEI en docx (format traitement de textes compatible avec Microsoft.Word, LibreOffice, OpenOffice…), en assurant un stylage optimal pour un retour du document bureautique vers TEI (avec par exemple <a href="http://github.com/oeuvres/Odette">Odette</a>).
      Attention cependant, XML/TEI est un format plus complexe que docx, c’est une conversion avec risque de pertes en structure (mais pas en texte).
      C’est un complément nécessaire à toute bibliothèque TEI, afin de faciliter la réutilisation des textes.
      Ce logiciel est activement développé et utilisé pour l’édition de textes littéraires (poésie, théâtre, roman, discours…), par exemple sur <a href="https://github.com/oeuvres/">Oeuvres</a>, <a href="https://github.com/dramacode/">Dramacode</a>, <a href="https://github.com/obvil/">Obvil</a>, ou <a href="https://github.com/ebalzac/">eBalzac</a>.
      Dans une chaîne de travail, ce logiciel permet de faire contribuer des éditeurs qui ne maitrisent pas l’édition XML/TEI, alors que le texte TEI a déjà été établi, en perdant le moins possible de travail entre les conversions.
      Ainsi des éditeurs critiques peuvent enrichir un texte avec notes dans leur logiciel familier (généralement Microsoft.Word), en évitant les copier/coller fastidieux entre les balises.</p>
      <p>
      Suite à la complexité possible des documents XML/TEI, il y a un risque inévitable de produire des fichiers docx non conforme, en ce cas, prévenez le développeur, <a onmouseover="this.href='mailto'+'\x3A'+'frederic.glorieux'+'\x40'+'fictif.org'" href="#">Frédéric Glorieux</a> se fera un plaisir d’enrichir son programme d’un nouveau cas.</p>
    </article>
    </div>
  </body>
</html>

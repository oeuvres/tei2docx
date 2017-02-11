<?php
/**
 * Class adhoc pour générer un docx à partir d’un XML/TEI
 */

set_time_limit(-1);
// included file, do nothing
if (isset($_SERVER['SCRIPT_FILENAME']) && basename($_SERVER['SCRIPT_FILENAME']) != basename(__FILE__));
else if (isset($_SERVER['ORIG_SCRIPT_FILENAME']) && realpath($_SERVER['ORIG_SCRIPT_FILENAME']) != realpath(__FILE__));
// direct command line call, work
else if (php_sapi_name() == "cli") Toff_Tei2docx::doCli();

class Toff_Tei2docx {

  static function doCli() {
    array_shift($_SERVER['argv']); // shift first arg, the script filepath
    if (!count($_SERVER['argv'])) exit('
usage    : php -f Toff_Tei2docx.php (dstdir/)? srcdir/*.xml
    ');

    $destdir = "";
    $lastc = substr($_SERVER['argv'][0], -1);
    if ('/' == $lastc || '\\' == $lastc) {
      $destdir = array_shift($_SERVER['argv']);
      $destdir = rtrim($destdir, '/\\').'/';
      if (!file_exists($destdir)) {
        mkdir($destdir, 0775, true);
        @chmod($dir, 0775);  // let @, if www-data is not owner but allowed to write
      }
    }

    while($glob = array_shift($_SERVER['argv']) ) {
      foreach(glob($glob) as $srcfile) {
        if (!$destdir) $destdir = dirname( $srcfile ) . '/';
        $destname = $destdir . pathinfo( $srcfile, PATHINFO_FILENAME);
        $dest = $destname.'.docx';
        $i = 0;
        $rename = $dest;
        while ( file_exists( $rename ) ) {
          if ( !$i ) echo "File $rename already exists, ";
          $i++;
          $rename = $destname . '_' . $i . '.docx';
        }
        if ( $i ) {
          rename( $dest, $rename );
          echo "renamed to $rename\n";
        }
        echo "$srcfile > $dest\n";
        self::docx($srcfile, $dest);
      }
    }

  }
  static function dom($src, $xml="") {
    $dom = new DOMDocument("1.0", "UTF-8");
    $dom->preserveWhiteSpace = false;
    $dom->formatOutput=true;
    $dom->substituteEntities=true;
    if ($xml) $dom->loadXML($xml,  LIBXML_NOENT | LIBXML_NONET | LIBXML_NOWARNING ); // no warn for <?xml-model
    else $dom->load($src,  LIBXML_NOENT | LIBXML_NONET | LIBXML_NOWARNING );
    return $dom;
  }

  static function docx($src, $dst) {
    $filename = pathinfo ($src, PATHINFO_FILENAME);
    $dom=self::dom($src);
    copy(dirname(__FILE__).'/template.docx', $dst);
    $zip = new ZipArchive;
    $zip->open($dst);

    $xml=self::xsl(dirname(__FILE__).'/tei2docx-comments.xsl', $dom, null, array('filename'=>$filename));
    $zip->addFromString('word/comments.xml', $xml);

    $xml=self::xsl(dirname(__FILE__).'/tei2docx.xsl', $dom, null, array('filename'=>$filename));
    $zip->addFromString('word/document.xml', $xml);

    $xml=self::xsl(dirname(__FILE__).'/tei2docx-fn.xsl', $dom, null, array('filename'=>$filename));
    $zip->addFromString('word/footnotes.xml', $xml);

    $xml=self::xsl(dirname(__FILE__).'/tei2docx-rels.xsl', $dom, null, array('filename'=>$filename));
    $zip->addFromString('word/_rels/document.xml.rels', $xml);

    $xml=self::xsl(dirname(__FILE__).'/tei2docx-fnrels.xsl', $dom, null, array('filename'=>$filename));
    $zip->addFromString('word/_rels/footnotes.xml.rels', $xml);

    $zip->close();

  }

  /**
   * Transformation xsl
   */
  static function xsl($xslFile, $dom, $dst=null, $pars=null) {
    $xsl = new DOMDocument("1.0", "UTF-8");
    $xsl->load($xslFile);
    $proc = new XSLTProcessor();
    $proc->importStyleSheet($xsl);
    // transpose params
    if($pars && count($pars)) foreach ($pars as $key => $value) $proc->setParameter('', $key, $value);
    // we should have no errors here
    if ($dst) $proc->transformToUri($dom, $dst);
    else return $proc->transformToXML($dom);
  }
}

?>

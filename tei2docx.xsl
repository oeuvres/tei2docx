<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
   xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
   xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
   xmlns:o="urn:schemas-microsoft-com:office:office"
   xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
   xmlns:v="urn:schemas-microsoft-com:vml"
   xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
   xmlns:w10="urn:schemas-microsoft-com:office:word"
   xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
   xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
   xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
   xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
   xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
   xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
   xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
   xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
   
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="tei"
  >
  <!-- indent "no", needed for OOo -->
  <xsl:output encoding="UTF-8" indent="no" method="xml"/>
  <xsl:strip-space elements="tei:TEI tei:TEI.2 tei:body tei:castList tei:div tei:div1 tei:div2  tei:docDate tei:docImprint tei:docTitle tei:fileDesc tei:front tei:group tei:index tei:listWit tei:publicationStmp tei:publicationStmt tei:sourceDesc tei:SourceDesc tei:sources tei:text tei:teiHeader tei:text tei:titleStmt"/>
  <xsl:preserve-space elements="tei:l tei:s tei:p"/>
  <xsl:param name="filename">tei</xsl:param>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:template match="/">
    <w:document>
      <w:body>
        <xsl:apply-templates select="*"/>
      </w:body>
    </w:document>
  </xsl:template>
  <!-- traverser -->
  <xsl:template match="tei:body | tei:front  | tei:sp | tei:teiHeader | tei:TEI | tei:text | *[ancestor::tei:teiHeader]">
    <xsl:apply-templates select="*|comment()"/>
  </xsl:template>
  <xsl:template match=" tei:div | tei:div1 | tei:div2 | tei:div3 | tei:div4 | tei:div5 | tei:div6 | tei:div7" priority="0">
    <xsl:if test="local-name(*[local-name() != 'index'][1]) != 'head'">
      <w:p>
        <w:pPr>
          <w:pStyle w:val="Titre{count(ancestor-or-self::tei:div)}"/>
        </w:pPr>
        <xsl:call-template name="anchor"/>
        <!--
        <w:r>
          <w:t xml:space="preserve">
            <xsl:text>[</xsl:text>
            <xsl:choose>
              <xsl:when test="@xml:id">
                <xsl:value-of select="@xml:id"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="substring(normalize-space(.), 0, 50)"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>]</xsl:text>
          </w:t>
        </w:r>
        -->
      </w:p>
    </xsl:if>
    <xsl:apply-templates select="*|comment()"/>
  </xsl:template>
  <!-- Métadonnées -->
  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:title">
    <xsl:call-template name="term">
      <xsl:with-param name="key">title</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:author">
    <xsl:call-template name="term">
      <xsl:with-param name="key">creator</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:fileDesc/tei:titleStmt/tei:editor">
    <xsl:call-template name="term">
      <xsl:with-param name="key">editor</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:editionStmt/tei:respStmt">
    <xsl:call-template name="term">
      <xsl:with-param name="key">copyeditor</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:publicationStmt/tei:publisher">
    <xsl:call-template name="term">
      <xsl:with-param name="key">publisher</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:publicationStmt/tei:date">
    <xsl:call-template name="term">
      <xsl:with-param name="key">issued</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:publicationStmt/tei:idno">
    <xsl:call-template name="term">
      <xsl:with-param name="key">idno</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:availability"/>
  <xsl:template match="tei:sourceDesc/tei:bibl">
    <xsl:call-template name="term">
      <xsl:with-param name="key">source</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:creation/tei:date">
    <xsl:call-template name="term">
      <xsl:with-param name="key">created</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:language">
    <xsl:call-template name="term">
      <xsl:with-param name="key">language</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="tei:textClass/tei:keywords/tei:term">
    <xsl:call-template name="term">
      <xsl:with-param name="key">subject</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="term">
    <xsl:param name="key">Key</xsl:param>
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="term"/>
      </w:pPr>
      <w:r>
        <w:t xml:space="preserve"><xsl:value-of select="$key"/> : </w:t>
      </w:r>
      <xsl:choose>
        <xsl:when test="@when">
          <w:r>
            <w:t>
              <xsl:value-of select="@when"/>
            </w:t>
          </w:r>
        </xsl:when>
        <xsl:when test="@notAfter|@notBefore">
          <w:r>
            <w:t>
              <xsl:value-of select="@notAfter"/>
              <xsl:text>-</xsl:text>
              <xsl:value-of select="@notBefore"/>
            </w:t>
          </w:r>
        </xsl:when>
        <xsl:when test="@ident">
          <w:r>
            <w:t>
              <xsl:value-of select="@ident"/>
            </w:t>
          </w:r>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </w:p>
  </xsl:template>
  <!-- Pas de mise en forme -->
  <xsl:template match="tei:s">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- Conserver les identifiants -->
  <xsl:template name="anchor">
    <!-- identifier of a parent div on first child block -->
    <xsl:if test="../@xml:id and (self::tei:head or not(preceding-sibling::*[. != '']))">
      <w:bookmarkStart w:name="{../@xml:id}">
        <xsl:attribute name="w:id">
          <xsl:number count="node()" level="any"/>
        </xsl:attribute>
      </w:bookmarkStart>
      <w:bookmarkEnd>
        <xsl:attribute name="w:id">
          <xsl:number count="node()" level="any"/>
        </xsl:attribute>
      </w:bookmarkEnd>
    </xsl:if>
    <xsl:if test="@xml:id">
      <w:bookmarkStart w:name="{@xml:id}">
        <xsl:attribute name="w:id">
          <xsl:number count="node()" level="any"/>
        </xsl:attribute>
      </w:bookmarkStart>
      <w:bookmarkEnd>
        <xsl:attribute name="w:id">
          <xsl:number count="node()" level="any"/>
        </xsl:attribute>
      </w:bookmarkEnd>
    </xsl:if>
  </xsl:template>
  <xsl:template match="tei:head" name="head">
    <xsl:variable name="count">
      <xsl:choose>
        <!-- not the first head of the section -->
        <!-- ???
        <xsl:when test="count(parent::*/*[1] | .) = 2"/>
        -->
        <xsl:when test="parent::tei:body | parent::tei:front | parent::tei:back">principal</xsl:when>
        <xsl:when test="parent::tei:div1">1</xsl:when>
        <xsl:when test="parent::tei:div2">2</xsl:when>
        <xsl:when test="parent::tei:div3">3</xsl:when>
        <xsl:when test="parent::tei:div">
          <xsl:value-of select="count(ancestor::tei:div)"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$lf"/>
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Titre{$count}"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:table">
    <xsl:value-of select="$lf"/>
    <xsl:value-of select="$lf"/>
    <xsl:value-of select="$lf"/>
    <w:tbl>
      <w:tblPr>
        <w:tblStyle w:val="Grilledutableau"/>
        <w:tblW w:type="auto" w:w="0"/>
        <w:tblLook w:firstColumn="1" w:firstRow="1" w:lastColumn="0" w:lastRow="0" w:noHBand="0" w:noVBand="1" w:val="04A0"/>
      </w:tblPr>
      <w:tblGrid>
        <xsl:for-each select="tei:row[1]/tei:cell">
          <w:gridCol/>
        </xsl:for-each>
      </w:tblGrid>
      <xsl:apply-templates select="tei:row"/>
    </w:tbl>
  </xsl:template>
  <xsl:template match="tei:row">
    <xsl:value-of select="$lf"/>
    <xsl:value-of select="$lf"/>
    <w:tr>
      <xsl:apply-templates select="tei:cell"/>
    </w:tr>
  </xsl:template>
  <xsl:template match="tei:cell">
    <xsl:value-of select="$lf"/>
    <w:tc>
      <xsl:choose>
        <xsl:when test="not(tei:p) and not(tei:list)">
          <xsl:call-template name="p"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </w:tc>
  </xsl:template>
  <!-- éléments génériques de niveau bloc -->
  <xsl:template match=" tei:back/* | tei:body/* | tei:div/* | tei:div1/* | tei:div2/* | tei:div3/* | tei:div4/* | tei:front/* | tei:sp/*" name="block" priority="-1">
    <xsl:param name="style" select="local-name()"/>
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="{$style}"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:l" name="l">
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle>
          <xsl:attribute name="w:val">
            <xsl:choose>
              <xsl:when test="ancestor::tei:quote">quotel</xsl:when>
              <xsl:otherwise>l</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </w:pStyle>
        <xsl:call-template name="rend-p">
          <xsl:with-param name="rend" select="concat(@rend, ' ', parent::*/@rend, ' ', ancestor::tei:quote/@rend)"/>
        </xsl:call-template>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:lg">
    <xsl:value-of select="$lf"/>
    <xsl:apply-templates/>
    <!-- séparateur vide de strophe -->
    <xsl:if test="following-sibling::*[1][self::tei:lg]">
      <xsl:value-of select="$lf"/>
      <w:p>
        <w:pPr>
          <w:pStyle>
            <xsl:attribute name="w:val">
              <xsl:choose>
                <xsl:when test="ancestor::tei:quote">quotel</xsl:when>
                <xsl:otherwise>l</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </w:pStyle>
          <xsl:call-template name="rend-p"/>
        </w:pPr>
        <xsl:call-template name="anchor"/>
      </w:p>
    </xsl:if>
  </xsl:template>
  <!-- Index mark, TODO -->
  <xsl:template match="tei:index"/>
  <xsl:template match="tei:note">
    <xsl:choose>
      <!-- Note de niveau caractère -->
      <xsl:when test="not(parent::tei:body | parent::tei:div | parent::tei:div1 | parent::tei:div2 | parent::tei:div3 | parent::tei:div4 | parent::tei:div5 | parent::tei:div6 | parent::tei:div7 | parent::tei:div8 | parent::tei:div9 | parent::tei:sp)">
        <w:r>
          <w:rPr>
            <w:rStyle w:val="Appelnotedebasdep"/>
          </w:rPr>
          <w:footnoteReference w:id="1">
            <xsl:attribute name="w:id">
              <xsl:call-template name="id"/>
            </xsl:attribute>
          </w:footnoteReference>
        </w:r>
      </xsl:when>
      <!-- note de niveau paragraphe -->
      <xsl:when test="text()[normalize-space(.) != ''] or tei:hi or tei:emph">
        <xsl:value-of select="$lf"/>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="note"/>
          </w:pPr>
          <w:r>
            <w:br/>
          </w:r>
          <w:r>
            <w:rPr>
              <w:rStyle w:val="alert"/>
            </w:rPr>
            <w:t>
              <xsl:text>[</xsl:text>
              <xsl:value-of select="@n|@xml:id"/>
              <xsl:text>]</xsl:text>
            </w:t>
          </w:r>
          <w:r>
            <w:tab/>
          </w:r>
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </w:p>
      </xsl:when>
      <!-- note regroupant des blocs -->
      <xsl:otherwise>
        <xsl:apply-templates select="comment()"/>
        <xsl:for-each select="*">
          <xsl:choose>
            <xsl:when test="self::tei:quote | self::tei:l | self::tei:lg">
              <xsl:if test="position() = 1">
                <w:p>
                  <xsl:call-template name="anchor"/>
                  <w:r>
                    <w:rPr>
                      <w:rStyle w:val="alert"/>
                    </w:rPr>
                    <w:t>
                      <xsl:text>[</xsl:text>
                      <xsl:value-of select="../@n|../@xml:id"/>
                      <xsl:text>]</xsl:text>
                    </w:t>
                  </w:r>
                </w:p>
              </xsl:if>
              <xsl:apply-templates select="."/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$lf"/>
              <w:p>
                <w:pPr>
                  <xsl:choose>
                    <xsl:when test="self::tei:p">
                      <w:pStyle w:val="note"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <w:pStyle w:val="{local-name()}"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </w:pPr>
                <xsl:if test="position() = 1">
                  <w:r>
                    <w:br/>
                  </w:r>
                  <w:r>
                    <w:rPr>
                      <w:rStyle w:val="alert"/>
                    </w:rPr>
                    <w:t>
                      <xsl:text>[</xsl:text>
                      <xsl:value-of select="../@n|../@xml:id"/>
                      <xsl:text>]</xsl:text>
                    </w:t>
                  </w:r>
                  <w:r>
                    <w:tab/>
                  </w:r>
                  <xsl:call-template name="anchor"/>
                </xsl:if>
                <xsl:apply-templates/>
              </w:p>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  <xsl:template match="tei:argument | tei:figure">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  <xsl:template match="tei:argument/* | tei:figure/* | tei:quote/tei:p">
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="{local-name()}"/>
        <xsl:call-template name="rend-p"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>

  <!-- Style sémantique de niveau bloc ou caractère -->
  <xsl:template match="tei:bibl | tei:stage">
    <xsl:value-of select="$lf"/>
    <xsl:choose>
      <!-- niveau caractère -->
      <xsl:when test="parent::tei:p or  ../text()[normalize-space(.) != '']">
        <w:r>
          <w:rPr>
            <w:rStyle w:val="{local-name()}-c"/>
          </w:rPr>
          <w:t>
            <xsl:value-of select="."/>
          </w:t>
        </w:r>
      </xsl:when>
      <!-- niveau bloc -->
      <xsl:otherwise>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="{local-name()}"/>
            <xsl:call-template name="rend-p"/>
          </w:pPr>
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:quote/tei:label">
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="quote"/>
        <w:ind w:firstLine="0"/>
        <w:jc w:val="center"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:p | tei:list[@type='dialogue']/tei:item" name="p">
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <xsl:choose>
          <xsl:when test="parent::tei:note">
            <w:pStyle w:val="Notedebasdepage"/>
          </xsl:when>
          <xsl:otherwise>
            <w:pStyle w:val="p"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="rend-p"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:if test="parent::tei:note and not(preceding-sibling::*)">
        <w:r>
          <w:rPr>
            <w:rStyle w:val="Appelnotedebasdep"/>
          </w:rPr>
          <w:footnoteRef/>
          <w:tab/>
        </w:r>
      </xsl:if>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:speaker">
    <xsl:value-of select="$lf"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="speaker"/>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <xsl:template match="tei:lb">
    <!-- tabulation en cas de justification -->
    <xsl:choose>
      <xsl:when test="ancestor::tei:ab"/>
      <xsl:when test="ancestor::tei:label"/>
      <xsl:when test="ancestor::tei:head"/>
      <xsl:when test="parent::*/@rend[contains(., 'center')]"/>
      <xsl:otherwise>
        <w:r>
          <w:tab/>
        </w:r>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$lf"/>
    <w:r>
      <w:br/>
    </w:r>
  </xsl:template>
  <!-- saut de page -->
  <xsl:template match="tei:pb">
    <xsl:choose>
      <xsl:when test="../text()[normalize-space(.) != '']">
        <xsl:call-template name="anchor"/>
        <w:r>
          <w:rPr>
             <w:rStyle w:val="{local-name()}"/>
           </w:rPr>
          <w:t>
            <xsl:text>[</xsl:text>
            <xsl:choose>
              <xsl:when test="@n and @n != ''">
                <xsl:text>p. </xsl:text>
                <xsl:value-of select="@n"/>
              </xsl:when>
              <xsl:when test="@xml:id">
                <xsl:value-of select="@xml:id"/>
              </xsl:when>
            </xsl:choose>
            <xsl:text>]</xsl:text>
          </w:t>
        </w:r>
      </xsl:when>
      <xsl:otherwise>
        <w:p>
          <xsl:call-template name="anchor"/>
          <w:r>
            <w:rPr>
               <w:rStyle w:val="{local-name()}"/>
             </w:rPr>
            <w:t>
              <xsl:text>[</xsl:text>
              <xsl:choose>
                <xsl:when test="@n and @n != ''">
                  <xsl:text>p. </xsl:text>
                  <xsl:value-of select="@n"/>
                </xsl:when>
                <xsl:when test="@xml:id">
                  <xsl:value-of select="@xml:id"/>
                </xsl:when>
              </xsl:choose>
              <xsl:text>]</xsl:text>
            </w:t>
          </w:r>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Listes -->
  <xsl:template match="tei:list | tei:listBibl | tei:castList">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:item | tei:castItem">
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Paragraphedeliste"/>
        <w:numPr>
          <w:ilvl w:val="0"/>
          <w:numId w:val="3"/>
        </w:numPr>
      </w:pPr>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  <!-- mise en forme inline -->
  <xsl:template name="rend-c">
    <xsl:param name="rend" select="@rend"/>
    <xsl:variable name="string" select="concat(' ', normalize-space($rend), ' ')"/>
    <xsl:if test="contains($string, ' i ') or contains($string, ' ital')">
      <w:i/>
    </xsl:if>
    <xsl:if test="contains($string, ' u ') or contains($string, ' under') or contains($string, ' sous') ">
      <w:u w:val="single"/>
    </xsl:if>
    <xsl:if test="contains($string, ' sc ') or contains($string, ' small-caps ') or contains($string, ' smallcaps ')  or contains($string, ' pc ')">
      <w:smallCaps/>
    </xsl:if>
    <xsl:if test="contains(concat(' ', ../@rend, ' '), 'small')">
      <w:highlight w:val="yellow"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="rend-p">
    <xsl:param name="rend" select="@rend"/>
    <xsl:variable name="string" select="concat(' ', normalize-space($rend), ' ')"/>
    <xsl:choose>
      <xsl:when test="contains($string, ' margin ')">
        <w:ind w:left="2000"/>
      </xsl:when>
      <xsl:when test="contains($string, ' center ')">
        <w:ind w:firstLine="0" w:left="0" w:right="0"/>
        <w:jc w:val="center"/>
      </xsl:when>
      <xsl:when test="contains($string, ' right ')">
        <w:jc w:val="right"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- éléments génériques de niveau caractère -->
  <xsl:template match="tei:item/* | tei:l/* | tei:p/* | tei:head/* | tei:emph | tei:hi | tei:name | tei:resp" priority="0">
    <xsl:param name="style"/>
    <w:r>
      <xsl:variable name="rPr">
        <xsl:choose>
          <xsl:when test="self::tei:hi and $style">
            <w:rStyle w:val="{$style}"/>
          </xsl:when>
          <xsl:when test="self::tei:emph">
            <w:i/>
          </xsl:when>
          <xsl:when test="self::tei:hi"/>
          <xsl:otherwise>
            <w:rStyle w:val="{local-name()}"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="rend-c">
          <!-- Faut-il ici calculer de l’héhritage ? Ex: ital dans ital ? -->
          <xsl:with-param name="rend" select="@rend"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="count($rPr)">
        <w:rPr>
          <xsl:copy-of select="$rPr"/>
        </w:rPr>
      </xsl:if>
      <!-- mauvais hack -->
      <xsl:variable name="pre">
        <xsl:choose>
          <xsl:when test="self::tei:resp">
            <xsl:text> (</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="post">
        <xsl:choose>
          <xsl:when test="self::tei:resp">
            <xsl:text>) </xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <w:t xml:space='preserve'><xsl:value-of select="$pre"/><xsl:value-of select="."/><xsl:value-of select="$post"/></w:t>
    </w:r>
  </xsl:template>
  <!-- citation, de niveau bloc ou caractère -->
  <xsl:template match="tei:quote">
    <xsl:choose>
      <!-- conteneur de blocs -->
      <xsl:when test="not(text()[normalize-space(.) != '']) and (tei:p|tei:l|tei:lg|tei:label)">
        <xsl:value-of select="$lf"/>
        <xsl:apply-templates>
          <xsl:with-param name="id" select="@xml:id"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- niveau caractère -->
      <xsl:when test="parent::tei:p or ../text()[normalize-space(.) != ''] or ../tei:hi">
        <xsl:call-template name="anchor"/>
        <xsl:apply-templates>
          <xsl:with-param name="style" select="local-name()"/>
        </xsl:apply-templates>
      </xsl:when>
      <!-- bloc -->
      <xsl:otherwise>
        <xsl:value-of select="$lf"/>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="{local-name()}"/>
            <xsl:call-template name="rend-p"/>
          </w:pPr>
          <xsl:call-template name="anchor"/>
          <xsl:apply-templates/>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- -->
  <xsl:template match="tei:epigraph">
    <!-- pb avec epigraph/cit/quote/p -->
    <xsl:for-each select=".//tei:p | .//tei:bibl">
      <xsl:value-of select="$lf"/>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="epigraph"/>
          <xsl:if test="self::tei:bibl">
            <w:jc w:val="right"/>
          </xsl:if>
        </w:pPr>
        <xsl:call-template name="anchor"/>
        <xsl:apply-templates/>
      </w:p>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="tei:titlePage/*">
    <xsl:call-template name="block"/>
  </xsl:template>
  <xsl:template match="tei:hi[starts-with(@rend, 'sup')]">
    <xsl:param name="style"/>
    <w:r>
      <w:rPr>
        <xsl:if test="$style">
          <w:rStyle w:val="{$style}"/>
        </xsl:if>
        <w:vertAlign w:val="superscript"/>
      </w:rPr>
      <w:t>
        <xsl:value-of select="."/>
      </w:t>
    </w:r>
  </xsl:template>
  <xsl:template match="tei:hi[starts-with(@rend, 'sub')]">
    <xsl:param name="style"/>
    <w:r>
      <w:rPr>
        <xsl:if test="$style">
          <w:rStyle w:val="{$style}"/>
        </xsl:if>
        <w:vertAlign w:val="subscript"/>
      </w:rPr>
      <w:t>
        <xsl:value-of select="."/>
      </w:t>
    </w:r>
  </xsl:template>
  <xsl:template match="tei:title">
    <w:r>
      <w:rPr>
        <w:rStyle w:val="title-c"/>
      </w:rPr>
      <w:t>
        <xsl:value-of select="."/>
      </w:t>
    </w:r>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:param name="style"/>
    <xsl:param name="rend">
      <xsl:choose>
        <xsl:when test="ancestor::tei:note">
          <xsl:for-each select="ancestor::*[ancestor::tei:note]">
            <xsl:value-of select="@rend"/>
            <xsl:text> </xsl:text>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="ancestor::tei:div">
          <xsl:for-each select="ancestor::*[ancestor-or-self::tei:div]">
            <xsl:value-of select="@rend"/>
            <xsl:text> </xsl:text>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:param>
    <!-- impossible to efficently test here in XSLT1 -->
    <xsl:variable name="rPr">
      <w:rPr>
        <xsl:if test="$style">
          <w:rStyle w:val="{$style}"/>
        </xsl:if>
        <xsl:call-template name="rend-c">
          <xsl:with-param name="rend" select="$rend"/>
        </xsl:call-template>
      </w:rPr>
    </xsl:variable>
    <xsl:choose>
      <!-- 
      <xsl:when test="normalize-space(.)='' and (not(following-sibling::node()) or not(preceding-sibling::node()))"/>
      -->
      <xsl:when test="normalize-space(.)=''">
        <w:r>
          <xsl:copy-of select="$rPr"/>
          <w:t xml:space="preserve"> </w:t>
        </w:r>
      </xsl:when>
      <xsl:otherwise>
        <w:r>
          <xsl:copy-of select="$rPr"/>
          <!-- start with space -->
          <xsl:variable name="pre">
            <xsl:choose>
              <!-- premier caractère n’est pas un espace, ne rien faire -->
              <xsl:when test="normalize-space(substring(.,1, 1)) != ''"/>
              <!-- premier nœud texte du bloc, pas d’espace en début de paragraphe -->
              <xsl:when test="starts-with( local-name(../..), 'div') and position() = 1"/>
              <xsl:otherwise>
                <xsl:text> </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="post">
            <xsl:choose>
              <xsl:when test="position() = last() and ancestor-or-self::tei:s">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="normalize-space(substring(.,string-length(.), 1)) != ''"/>
              <xsl:when test="starts-with( local-name(../..), 'div') and position() = last()"/>
              <xsl:otherwise>
                <xsl:text> </xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <w:t xml:space="preserve"><xsl:value-of select="$pre"/><xsl:value-of select="normalize-space(.)"/><xsl:value-of select="$post"/></w:t>
        </w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- | *[@target] | *[@ref] -->
  <xsl:template match="tei:ref | tei:graphic[@url]">
    <!-- target is created with tei2docx-rels.xsl -->
    <xsl:variable name="target" select="(@target|@url|@ref)[1]"/>
    <w:hyperlink>
      <xsl:choose>
        <xsl:when test="starts-with($target, '#')">
          <xsl:attribute name="w:anchor">
            <xsl:value-of select="substring($target, 2)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="r:id">
            <xsl:call-template name="id"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test=".=''">
          <w:r>
            <w:rPr>
              <w:rStyle w:val="LienInternet"/>
            </w:rPr>
            <w:t>
              <xsl:value-of select="$target"/>
            </w:t>
          </w:r>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates>
            <xsl:with-param name="style">
              <xsl:choose>
                <!-- Style sémantique autre que lien ? -->
                <xsl:when test="false()">
                  <xsl:value-of select="local-name()"/>
                </xsl:when>
                <xsl:otherwise>LienInternet</xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </w:hyperlink>
  </xsl:template>
  <xsl:template name="id">
    <xsl:choose>
      <xsl:when test="self::comment()">
        <!-- Bug number, ne prend pas comment -->
        <xsl:number count="node()" level="any"/>  
      </xsl:when>
      <xsl:when test="self::tei:ref">
        <xsl:text>ref</xsl:text>
        <xsl:number level="any"/>  
      </xsl:when>
      <xsl:when test="self::tei:note">
        <xsl:number level="any"/>  
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="generate-id()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Utile ou parasite ? -->
  <xsl:template match="comment()">
    <xsl:comment>
      <xsl:value-of select="."/>
    </xsl:comment>
    <xsl:choose>
      <xsl:when test="ancestor::*[text()[normalize-space(.) != '']]">
        <w:r>
          <w:rPr>
            <w:rStyle w:val="Marquedecommentaire"/>
          </w:rPr>
          <w:commentReference>
            <xsl:attribute name="w:id">
              <xsl:call-template name="id"/>
            </xsl:attribute>
          </w:commentReference>
        </w:r>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$lf"/>
        <w:p>
          <w:pPr>
            <w:pStyle w:val="Marquedecommentaire"/>
          </w:pPr>
          <w:r>
            <w:commentReference>
              <xsl:attribute name="w:id">
                <xsl:call-template name="id"/>
              </xsl:attribute>
            </w:commentReference>
          </w:r>
        </w:p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:transform>
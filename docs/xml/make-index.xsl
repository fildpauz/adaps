<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : make-index.xsl
    Created on : December 30, 2016, 11:04 AM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" version="4.0"/>
    <xsl:variable name="rootnode" select="/"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <xsl:element name="html">
            <xsl:element name="head">
                <xsl:call-template name="print-head-element"/>
            </xsl:element>
            <xsl:element name="body">
                <xsl:call-template name="print-header-div"/>
                <xsl:call-template name="print-content-div"/>
                <xsl:call-template name="print-footer-div"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="process-documents">
        <xsl:call-template name="process-book-documents">
            <xsl:with-param name="booknum" select="1"/>
        </xsl:call-template>
        <xsl:call-template name="process-book-documents">
            <xsl:with-param name="booknum" select="2"/>
        </xsl:call-template>
        <xsl:call-template name="process-other-documents"/>
    </xsl:template>
    
    <xsl:template name="process-book-documents">
        <xsl:param name="booknum"/>
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>w3-theme-l1 w3-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="h2">
                <xsl:attribute name="class">
                    <xsl:text>w3-padding-medium w3-text-shadow</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="document('arise_structure.xml')//book[@number=$booknum]/@shorttext"/>
            </xsl:element>
            <xsl:for-each select="document('arise_structure.xml')//book[@number=$booknum]/section">
                <xsl:sort select="@number"/>
                <xsl:variable name="sectionnum" select="@number"/>
                <xsl:if test="$rootnode//document/info[@type='arise']/arise-info[@book=$booknum][@section=$sectionnum]">
                    <xsl:call-template name="process-section-documents">
                        <xsl:with-param name="booknum" select="$booknum"/>
                        <xsl:with-param name="sectionnum" select="$sectionnum"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="process-section-documents">
        <xsl:param name="booknum"/>
        <xsl:param name="sectionnum"/>
        <xsl:variable name="sectionid" select="concat('b', $booknum, '-s', $sectionnum)"/>
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>w3-accordion w3-theme-l4 w3-border-top</xsl:text>
            </xsl:attribute>
            <xsl:element name="button">
                <xsl:attribute name="class">
                    <xsl:text>w3-btn-block w3-left-align w3-theme-l2 w3-padding-medium w3-margin-0</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="onclick">
                    <xsl:text>myFunction('</xsl:text>
                    <xsl:value-of select="$sectionid"/>
                    <xsl:text>')</xsl:text>
                </xsl:attribute>
                <xsl:element name="h3">
                    <xsl:value-of select="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/@index"/>
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/@title"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$sectionid"/>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>w3-accordion-content w3-container</xsl:text>
                </xsl:attribute>
                <xsl:for-each select="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/unit">
                    <xsl:sort select="@number"/>
                    <xsl:variable name="unitnum" select="@number"/>
                    <xsl:if test="$rootnode//document/info[@type='arise']/arise-info[@book=$booknum][@section=$sectionnum][@unit=$unitnum]">
                        <xsl:call-template name="process-unit-documents">
                            <xsl:with-param name="booknum" select="$booknum"/>
                            <xsl:with-param name="sectionnum" select="$sectionnum"/>
                            <xsl:with-param name="unitnum" select="$unitnum"/>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="process-unit-documents">
        <xsl:param name="booknum"/>
        <xsl:param name="sectionnum"/>
        <xsl:param name="unitnum"/>
        <xsl:variable name="unitid" select="concat('b', $booknum, '-s', $sectionnum, '-u', $unitnum)"/>
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>w3-accordion w3-theme-l4 w3-border-top</xsl:text>
            </xsl:attribute>
            <xsl:element name="button">
                <xsl:attribute name="class">
                    <xsl:text>w3-btn-block w3-left-align w3-theme-l3 w3-padding-small w3-margin-0</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="onclick">
                    <xsl:text>myFunction('</xsl:text>
                    <xsl:value-of select="$unitid"/>
                    <xsl:text>')</xsl:text>
                </xsl:attribute>
                <xsl:element name="h4">
                    <xsl:if test="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/unit[@number=$unitnum]/@index">
                        <xsl:value-of select="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/unit[@number=$unitnum]/@index"/>
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="document('arise_structure.xml')//book[@number=$booknum]/section[@number=$sectionnum]/unit[@number=$unitnum]/@title"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$unitid"/>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>w3-accordion-content w3-container</xsl:text>
                </xsl:attribute>
                <xsl:element name="ul">
                    <xsl:attribute name="class">
                        <xsl:text>w3-ul</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each select="$rootnode//document[child::info[@type='arise'][child::arise-info[@book=$booknum][@section=$sectionnum][@unit=$unitnum]]]">
                        <xsl:sort select="@page"/>
                        <xsl:sort select="@part"/>
                        <xsl:sort select="@item"/>
                        <xsl:apply-templates select="self::document"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="process-other-documents">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>w3-theme-l1</xsl:text>
            </xsl:attribute>
            <xsl:element name="h2">
                <xsl:attribute name="class">
                    <xsl:text>w3-padding-medium w3-text-shadow</xsl:text>
                </xsl:attribute>
                <xsl:text>Other</xsl:text>
            </xsl:element>
            <xsl:if test="//document/info[@type='science-news']">
                <xsl:call-template name="process-other-document-type">
                    <xsl:with-param name="type">science-news</xsl:with-param>
                    <xsl:with-param name="label">Science news</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="//document/info[@type='wikipedia']">
                <xsl:call-template name="process-other-document-type">
                    <xsl:with-param name="type">wikipedia</xsl:with-param>
                    <xsl:with-param name="label">Wikipedia articles</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="//document/info[@type='textbook']">
                <xsl:call-template name="process-other-document-type">
                    <xsl:with-param name="type">textbook</xsl:with-param>
                    <xsl:with-param name="label">Textbook extracts</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="//document/info[@type='research-article']">
                <xsl:call-template name="process-other-document-type">
                    <xsl:with-param name="type">research-article</xsl:with-param>
                    <xsl:with-param name="label">Research article extracts</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="process-other-document-type">
        <xsl:param name="type"/>
        <xsl:param name="label"/>
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>w3-accordion w3-theme-l4 w3-border-top</xsl:text>
            </xsl:attribute>
            <xsl:element name="button">
                <xsl:attribute name="class">
                    <xsl:text>w3-btn-block w3-left-align w3-theme-l2 w3-padding-medium w3-margin-0</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="onclick">
                    <xsl:text>myFunction('</xsl:text>
                    <xsl:value-of select="$type"/>
                    <xsl:text>')</xsl:text>
                </xsl:attribute>
                <xsl:element name="h3">
                    <xsl:value-of select="$label"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="$type"/>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>w3-accordion-content w3-container</xsl:text>
                </xsl:attribute>
                <xsl:element name="ul">
                    <xsl:attribute name="class">
                        <xsl:text>w3-ul</xsl:text>
                    </xsl:attribute>
                    <xsl:for-each select="//document[child::info[@type=$type]]">
                        <xsl:sort select="title"/>
                        <xsl:apply-templates select="self::document"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="document">
        <xsl:element name="li">
            <xsl:attribute name="class">
                <xsl:text>w3-padding-tiny w3-margin-0 w3-border-top</xsl:text>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>./docs/html/</xsl:text>
                    <xsl:value-of select="@id"/>
                    <xsl:text>.html</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="title"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="print-head-element">
        <xsl:element name="title">
            <xsl:text>ADAPS - Academic Document Annotation and Presentation Schema</xsl:text>
        </xsl:element>
        <xsl:element name="meta">
            <xsl:attribute name="name">
                <xsl:text>viewport</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="content">
                <xsl:text>width=device-width, initial-scale=1</xsl:text>
            </xsl:attribute>
        </xsl:element>
        <xsl:element name="link">
            <xsl:attribute name="rel">
                <xsl:text>stylesheet</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="href">
                <!-- remove 'https' in following? -->
                <xsl:text>./css/w3.css</xsl:text>
            </xsl:attribute>
        </xsl:element>
        <xsl:element name="link">
            <xsl:attribute name="rel">
                <xsl:text>stylesheet</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="href">
                <!-- remove 'https' in following? -->
                <xsl:text>./css/w3-theme-blue-grey.css</xsl:text>
            </xsl:attribute>
        </xsl:element>
        <xsl:element name="script">
            <xsl:text>
                function myFunction(id) {
                var x = document.getElementById(id);
                if (x.className.indexOf("w3-show") == -1) {
                x.className += " w3-show";
                } else { 
                x.className = x.className.replace(" w3-show", "");
                }
                }
            </xsl:text>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="print-header-div">
        <xsl:element name="div">
            <xsl:attribute name="id">
                <xsl:text>header</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>w3-container w3-theme-d2 w3-center</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="style">
                <!--<xsl:text>height: 300px;</xsl:text>-->
            </xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>w3-margin</xsl:text>
                </xsl:attribute>
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:text>./images/adaps_logo.png</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>w3-round-large w3-image w3-animate-opacity</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="style">
                        <!--<xsl:text>max-widtht: 300px;</xsl:text>-->
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:text>ADAPS logo</xsl:text>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>w3-margin</xsl:text>
                </xsl:attribute>
                <xsl:element name="h1">
                    <xsl:attribute name="class">
                        <xsl:text>w3-text-shadow</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Academic Document Annotation and Presentation Schema</xsl:text>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="print-content-div">
        <xsl:element name="div">
            <xsl:attribute name="id">
                <xsl:text>content</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>w3-container</xsl:text>
            </xsl:attribute>
            <xsl:call-template name="print-intro-text"/>
            <xsl:call-template name="process-documents"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="print-intro-text">
        <xsl:element name="p">ADAPS is designed to be a vehicle for giving an enhanced presentation
            of many of the texts used in <i>Academic Reading in Science and
                Engineering, Books 1 and 2 (ARiSE1, ARiSE2)</i> in order to enable a
            closer study of academic texts with respect to the various linguistic
            features of texts studied in the textbooks. Click on one of the
            following texts to study it in detail.</xsl:element>
    </xsl:template>
    
    <xsl:template name="print-footer-div">
        <xsl:element name="div">
            <xsl:attribute name="id">
                <xsl:text>footer</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>w3-container w3-theme-d4 w3-margin-top</xsl:text>
            </xsl:attribute>
            <xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:text>./images/adaps_icon.png</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>w3-round-small w3-image w3-left w3-margin</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="style">
                    <xsl:text>max-height: 1.5em;</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:text>ADAPS icon</xsl:text>
                </xsl:attribute>
            </xsl:element>
            <xsl:element name="p">
                <xsl:attribute name="class">
                    <xsl:text>w3-text-shadow</xsl:text>
                </xsl:attribute>
                <xsl:text>ADAPS</xsl:text>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>

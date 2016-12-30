<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : make-index.xsl
    Created on : December 30, 2016, 11:04 AM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <xsl:element name="html">
            <xsl:element name="head">
                <xsl:element name="title">
                    <xsl:text>ADAPS index</xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:element name="body">
                <xsl:apply-templates select="//document"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="document">
        <xsl:element name="p">
            <xsl:number/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="title"/>
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
                <xsl:text>https://www.w3schools.com/lib/w3.css</xsl:text>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>

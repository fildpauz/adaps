<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : aggregate_documents.xsl
    Created on : December 30, 2016, 4:36 PM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <xsl:element name="documents">
            <xsl:apply-templates select="//file">
                <xsl:sort select="name"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="file">
        <xsl:variable name="path" select="@path"/>
        <xsl:variable name="id" select="@name"/>
        <xsl:element name="document">
            <xsl:attribute name="id">
                <xsl:value-of select="$id"/>
            </xsl:attribute>
            <xsl:attribute name="path">
                <xsl:value-of select="$path"/>
            </xsl:attribute>
            <xsl:apply-templates select="document($path)/document/*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

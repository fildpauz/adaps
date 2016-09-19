<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : annotate.xsl
    Created on : September 18, 2016, 7:27 PM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8" doctype-system="../../../xml/adaps.dtd"/>

    <xsl:template match="sentence">
        <xsl:copy>
            <xsl:attribute name="par-function">
                <xsl:text>topic|supporting|concluding</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="abbr">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="ancestor::sentence[1]/@id"/>
                <xsl:text>-b</xsl:text>
                <xsl:number value="count(preceding::abbr[ancestor::sentence[1][descendant::abbr[generate-id(.)=generate-id(current())]]])+1" format="01"/>
            </xsl:attribute>
            <xsl:attribute name="info"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="term">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="ancestor::sentence[1]/@id"/>
                <xsl:text>-e</xsl:text>
                <xsl:number value="count(preceding::term[ancestor::sentence[1][descendant::term[generate-id(.)=generate-id(current())]]])+1" format="01"/>
            </xsl:attribute>
            <xsl:attribute name="info"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="connector">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="ancestor::sentence[1]/@id"/>
                <xsl:text>-c</xsl:text>
                <xsl:number value="count(preceding::connector[ancestor::sentence[1][descendant::connector[generate-id(.)=generate-id(current())]]])+1" format="01"/>
            </xsl:attribute>
            <xsl:attribute name="type"/>
            <xsl:attribute name="info"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="anaphor">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:value-of select="ancestor::sentence[1]/@id"/>
                <xsl:text>-a</xsl:text>
                <xsl:number value="count(preceding::anaphor[ancestor::sentence[1][descendant::anaphor[generate-id(.)=generate-id(current())]]])+1" format="01"/>
            </xsl:attribute>
            <xsl:attribute name="info"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

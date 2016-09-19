<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : attach-ids.xsl
    Created on : September 18, 2016, 10:24 AM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8" doctype-system="../../../xml/adaps.dtd"/>

    <xsl:template match="document|title|citation|url|body">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="paragraph">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:text>p</xsl:text>
                <xsl:number value="position()" format="01"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sentence">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:text>p</xsl:text>
                <xsl:number value="count(ancestor::paragraph/preceding-sibling::paragraph)+1" format="01"/>
                <xsl:text>-s</xsl:text>
                <xsl:if test="parent::sentence">
                    <xsl:number value="count(parent::sentence/preceding-sibling::sentence)+1" format="01"/>
                    <xsl:text>-</xsl:text>
                </xsl:if>
                <xsl:number value="position()" format="01"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t">
        <xsl:copy>
            <xsl:attribute name="id">
                <xsl:text>p</xsl:text>
                <xsl:number value="count(ancestor::paragraph/preceding-sibling::paragraph)+1" format="01"/>
                <xsl:text>-s</xsl:text>
                <xsl:if test="parent::sentence/parent::sentence">
                    <xsl:number value="count(parent::sentence/parent::sentence/preceding-sibling::sentence)+1" format="01"/>
                    <xsl:text>-</xsl:text>
                </xsl:if>
                <xsl:number value="count(parent::sentence/preceding-sibling::sentence)+1" format="01"/>
                <xsl:text>-t</xsl:text>
                <xsl:number value="count(preceding-sibling::t)+1" format="01"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

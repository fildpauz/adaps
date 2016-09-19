<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : classify-words.xsl
    Created on : September 18, 2016, 1:54 PM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8" doctype-system="../../../xml/adaps.dtd"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:template match="t">
        <xsl:variable name="token" select="translate(., $uppercase, $lowercase)"/>
        <xsl:variable name="first-letter" select="translate(substring(., 1, 1), $uppercase, $lowercase)"/>
        <xsl:copy>
            <xsl:copy-of select="@id"/>
            <xsl:if test="document('../../../tools/word-lists.xml')/vocabulary/sublist[@first-letter=$first-letter]/word[text() = $token]">
                <xsl:attribute name="type">
                    <xsl:value-of select="document('../../../tools/word-lists.xml')/vocabulary/sublist[@first-letter=$first-letter]/word[text() = $token]/@tags"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : collate-word-lists.xsl
    Created on : September 18, 2016, 2:56 PM
    Author     : Ralph
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:template match="LISTS">
        <xsl:element name="vocabulary">
            <xsl:for-each select="INDEX/SUBLIST">
                <xsl:variable name="first-letter" select="translate(@FIRST-LETTER, $uppercase, $lowercase)"/>
                <xsl:message>
                    <xsl:value-of select="$first-letter"/>
                </xsl:message>
                <xsl:element name="sublist">
                    <xsl:attribute name="first-letter">
                        <xsl:value-of select="$first-letter"/>
                    </xsl:attribute>
                    <xsl:for-each select="//WORD[translate(substring(., 1, 1), $uppercase, $lowercase) = $first-letter]">
                        <xsl:sort select="." lang="en" data-type="text" order="ascending"/>
                        <xsl:call-template name="make-word-node"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="make-word-node">
        <xsl:element name="word">
            <xsl:attribute name="family">
                <xsl:value-of select="translate(ancestor::FAMILY/@HEADWORD, $uppercase, $lowercase)"/>
            </xsl:attribute>
            <xsl:attribute name="tags">
                <xsl:call-template name="parse-tags">
                    <xsl:with-param name="tags" select="ancestor::FAMILY/@TAGS"/>
                </xsl:call-template>
            </xsl:attribute>
            <xsl:if test="@POS">
                <xsl:attribute name="pos">
                    <xsl:value-of select="@POS"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="translate(., $uppercase, $lowercase)"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="parse-tags">
        <xsl:param name="tags"/>
        <xsl:choose>
            <xsl:when test="contains($tags, ',')">
                <xsl:call-template name="parse-awl-tags">
                    <xsl:with-param name="tag" select="substring-before($tags, ',')"/>
                </xsl:call-template>
                <xsl:text>,</xsl:text>
                <xsl:call-template name="parse-awl-tags">
                    <xsl:with-param name="tag" select="substring-after($tags, ',')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="starts-with($tags, 'General Service List')">
                <xsl:text>GSL-</xsl:text>
                <xsl:value-of select="normalize-space(substring($tags, string-length($tags)))"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="parse-awl-tags">
        <xsl:param name="tag"/>
        <xsl:choose>
            <xsl:when test="starts-with($tag, 'Coxhead AWL Sublist')">
                <xsl:text>Coxhead-AWL-</xsl:text>
                <xsl:value-of select="normalize-space(substring($tag, string-length($tag)-1))"/>
            </xsl:when>
            <xsl:when test="starts-with($tag, 'AR AWL Sublist')">
                <xsl:text>AR-AWL-</xsl:text>
                <xsl:value-of select="normalize-space(substring($tag, string-length($tag)-1))"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

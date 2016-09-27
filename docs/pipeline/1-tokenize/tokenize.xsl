<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : tokenize.xsl
    Created on : September 17, 2016, 2:51 PM
    Author     : Ralph
    Description:
        Structure a document into paragraphs, sentences, and word tokens
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="utf-8" doctype-system="../../../xml/adaps.dtd"/>
    <xsl:variable name="end-punctuation" select="'.!?'"/>

    <xsl:template match="document">
        <xsl:copy>
            <xsl:apply-templates select="child::*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="title|citation|url">
        <xsl:copy>
            <xsl:value-of select="."/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:call-template name="make-paragraphs">
                <xsl:with-param name="text" select="."/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="make-paragraphs">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="string-length(normalize-space($text)) = 0"/>
            <xsl:when test="not(contains($text, '&#10;&#10;')) and string-length(normalize-space($text)) > 0">
                <xsl:element name="paragraph">
                    <xsl:call-template name="make-sentences">
                        <xsl:with-param name="text" select="normalize-space($text)"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="paragraph">
                    <xsl:call-template name="make-sentences">
                        <xsl:with-param name="text" select="normalize-space(substring-before($text, '&#10;&#10;'))"/>
                    </xsl:call-template>
                </xsl:element>
                <xsl:call-template name="make-paragraphs">
                    <xsl:with-param name="text" select="substring-after($text, '&#10;&#10;')"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="make-sentences">
        <xsl:param name="text"/>
<!--        <xsl:message>
            <xsl:value-of select="$text"/>
        </xsl:message>-->
        <xsl:variable name="slength">
            <xsl:call-template name="get-sentence-length">
                <xsl:with-param name="text" select="$text"/>
            </xsl:call-template>
        </xsl:variable>
<!--        <xsl:message>
            <xsl:value-of select="$slength"/>
        </xsl:message>-->
        <xsl:choose>
            <xsl:when test="$slength = string-length($text)">
                <xsl:element name="sentence">
                    <xsl:call-template name="make-tokens">
                        <xsl:with-param name="text" select="normalize-space($text)"/>
                    </xsl:call-template>
                    <!--<xsl:value-of select="$text"/>-->
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="sentence">
                    <xsl:call-template name="make-tokens">
                        <xsl:with-param name="text" select="normalize-space(substring($text, 1, $slength))"/>
                    </xsl:call-template>
                    <!--<xsl:value-of select="substring($text, 1, $slength)"/>-->
                </xsl:element>
                <xsl:call-template name="make-sentences">
                    <xsl:with-param name="text" select="normalize-space(substring($text, $slength+1))"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="make-tokens">
        <xsl:param name="text"/>
        <xsl:variable name="last-char" select="substring($text, string-length($text), 1)"/>
        <xsl:choose>
            <xsl:when test="starts-with($text, '&#8220;') or
                            starts-with($text, '&#145;') or
                            starts-with($text, '(') or
                            starts-with($text, '[') or
                            starts-with($text, '{')">
                <xsl:element name="punc">
                    <xsl:value-of select="substring($text, 1, 1)"/>
                </xsl:element>
                <xsl:call-template name="make-tokens">
                    <xsl:with-param name="text" select="normalize-space(substring($text, 2))"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($text, ' ')">
                <xsl:call-template name="make-tokens">
                    <xsl:with-param name="text" select="normalize-space(substring-before($text, ' '))"/>
                </xsl:call-template>
                <xsl:call-template name="make-tokens">
                    <xsl:with-param name="text" select="normalize-space(substring-after($text, ' '))"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$last-char = '&#8221;' or
                            $last-char = '&#146;' or
                            $last-char = ')' or
                            $last-char = ']' or
                            $last-char = '}' or
                            $last-char = '.' or
                            $last-char = '!' or
                            $last-char = '?' or
                            $last-char = ',' or
                            $last-char = ':' or
                            $last-char = ';' ">
                <xsl:call-template name="make-tokens">
                    <xsl:with-param name="text" select="normalize-space(substring($text, 1, string-length($text)-1))"/>
                </xsl:call-template>
                <xsl:element name="punc">
                    <xsl:value-of select="substring($text, string-length($text), 1)"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="t">
                    <xsl:value-of select="$text"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="get-sentence-length">
        <xsl:param name="text"/>
        <xsl:variable name="mtext" select="concat(translate($text, '!?', '..'), ' ')"/>
<!--        <xsl:message>
            <xsl:value-of select="$mtext"/>
        </xsl:message>-->
        <xsl:variable name="period-index-1">
            <xsl:choose>
                <xsl:when test="contains($mtext, '. ')">
                    <xsl:value-of select="string-length(substring-before($mtext, '. '))+1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string-length($text)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="period-index-2">
            <xsl:choose>
                <xsl:when test="contains($mtext, '.&#8221; ')">
                    <xsl:value-of select="string-length(substring-before($mtext, '.&#8221; '))+2"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string-length($text)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="period-index-3">
            <xsl:choose>
                <xsl:when test="contains($mtext, '.&#146; ')">
                    <xsl:value-of select="string-length(substring-before($mtext, '.&#146; '))+2"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string-length($text)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
<!--        <xsl:message>
            <xsl:value-of select="concat($period-index-1, ' ', $period-index-2, ' ', $period-index-3)"/>
        </xsl:message>-->
        <xsl:choose>
            <xsl:when test="$period-index-1 &lt; $period-index-2">
                <xsl:choose>
                    <xsl:when test="$period-index-1 &lt; $period-index-3">
                        <xsl:value-of select="$period-index-1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$period-index-3"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$period-index-2 &lt; $period-index-3">
                        <xsl:value-of select="$period-index-2"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$period-index-3"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

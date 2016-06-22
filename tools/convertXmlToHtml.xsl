<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" />
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	<xsl:template match="document">
		<xsl:element name="html">
			<xsl:element name="head">
				<xsl:element name="title">
					<xsl:text>ADAPS - </xsl:text>
					<xsl:apply-templates select="title" />
				</xsl:element>
				<xsl:call-template name="print-header-info" />
			</xsl:element>
			<xsl:apply-templates select="body" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="paragraph">
		<xsl:variable name="paragraphID" select="@id" />
		<xsl:element name="div">
			<xsl:attribute name="class">
				<xsl:text>paragraph-wrapper</xsl:text>
			</xsl:attribute>
			<xsl:element name="p">
				<xsl:attribute name="id">
					<xsl:value-of select="$paragraphID" />
				</xsl:attribute>
				<xsl:attribute name="class">
					<xsl:text>paragraph</xsl:text>
				</xsl:attribute>
				<xsl:apply-templates select="child::node()" />
			</xsl:element>
		</xsl:element>
		<xsl:for-each select=".//t[@type='AWL']">
			<xsl:variable name="tokenID" select="@id" />
			<xsl:element name="div">
				<xsl:attribute name="id">
					<xsl:value-of select="concat($tokenID, '-popup')"/>
				</xsl:attribute>
				<xsl:attribute name="class">
					<xsl:text>ui-content</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="data-role">
					<xsl:text>popup</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="data-arrow">
					<xsl:text>t</xsl:text>
				</xsl:attribute>
				<xsl:text>This is an AWL word: </xsl:text>
				<xsl:value-of select="."/>
				<xsl:text>!</xsl:text>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="sentence">
		<xsl:variable name="sentenceID" select="@id" />
		<xsl:element name="span">
			<xsl:attribute name="id">
				<xsl:value-of select="$sentenceID" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:text>sentence </xsl:text>
				<xsl:value-of select="@par-function" />
			</xsl:attribute>
			<xsl:apply-templates select="*[1]" />
		</xsl:element>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="t">
		<xsl:variable name="tokenID" select="@id" />
		<xsl:variable name="type" select="@type" />
		<xsl:element name="span">
			<xsl:attribute name="id">
				<xsl:value-of select="$tokenID" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:text>token </xsl:text>
				<xsl:value-of select="translate($type, $uppercase, $lowercase)" />
			</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:value-of select="." />
			</xsl:attribute>
			<xsl:value-of select="." />
		</xsl:element>
		<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="punc">
		<xsl:choose>
			<xsl:when test=". = '('">
				<xsl:text> </xsl:text>
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:when test=". = '&#8220;'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:when test="contains('),.', .)">
				<xsl:value-of select="." />
				<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test=". = '&#8221;'">
				<xsl:value-of select="." />
				<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="contains(':;', .)">
				<xsl:value-of select="." />
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:when test=". = '—'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="." />
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="abbr|term">
		<xsl:variable name="abbreviationID" select="@id" />
		<xsl:variable name="definitionStartID" select="substring-before(@info, ':')" />
		<xsl:variable name="definitionEndID" select="substring-after(@info, ':')" />
		<xsl:variable name="type">
			<xsl:choose>
				<xsl:when test="self::abbr">
					<xsl:text>abbreviation</xsl:text>
				</xsl:when>
				<xsl:when test="self::term">
					<xsl:text>technical-term</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>OTHER</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="span">
			<xsl:attribute name="id">
				<xsl:value-of select="$abbreviationID" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:value-of select="$type" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:text>Definition: </xsl:text>
				<xsl:call-template name="get-text-in-a-range">
					<xsl:with-param name="currentID" select="$definitionStartID" />
					<xsl:with-param name="endID" select="$definitionEndID" />
					<xsl:with-param name="text">
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="*[1]" />
		</xsl:element>
		<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="anaphor">
		<xsl:variable name="anaphorID" select="@id" />
		<xsl:variable name="antecedentStartID" select="substring-before(@info, ':')" />
		<xsl:variable name="antecedentEndID" select="substring-after(@info, ':')" />
		<xsl:element name="span">
			<xsl:attribute name="id">
				<xsl:value-of select="$anaphorID" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:text>anaphor</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:text>Antecedent: </xsl:text>
				<xsl:call-template name="get-text-in-a-range">
					<xsl:with-param name="currentID" select="$antecedentStartID" />
					<xsl:with-param name="endID" select="$antecedentEndID" />
					<xsl:with-param name="text">
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="*[1]" />
		</xsl:element>
		<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="connector">
		<xsl:variable name="connectorID" select="@id" />
		<xsl:variable name="connectorType" select="@type" />
		<xsl:variable name="lhsStartID"
			select="substring-before(substring-before(@info, ','), ':')" />
		<xsl:variable name="lhsEndID"
			select="substring-after(substring-before(@info, ','), ':')" />
		<xsl:variable name="rhsStartID"
			select="substring-before(substring-after(@info, ','), ':')" />
		<xsl:variable name="rhsEndID"
			select="substring-after(substring-after(@info, ','), ':')" />
		<xsl:element name="span">
			<xsl:attribute name="id">
				<xsl:value-of select="$connectorID" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:text>connector</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:text>Connector type: </xsl:text>
				<xsl:value-of select="translate($connectorType, $lowercase, $uppercase)" />
				<xsl:text>&#10;&#10;* Idea 1: </xsl:text>
				<xsl:call-template name="get-text-in-a-range">
					<xsl:with-param name="currentID" select="$lhsStartID" />
					<xsl:with-param name="endID" select="$lhsEndID" />
					<xsl:with-param name="text">
					</xsl:with-param>
				</xsl:call-template>
				<xsl:text>&#10;&#10;* Idea 2: </xsl:text>
				<xsl:call-template name="get-text-in-a-range">
					<xsl:with-param name="currentID" select="$rhsStartID" />
					<xsl:with-param name="endID" select="$rhsEndID" />
					<xsl:with-param name="text">
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="*[1]" />
		</xsl:element>
		<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="emph">
		<xsl:element name="span">
			<xsl:attribute name="style">
				<xsl:text>font-style: italic;</xsl:text>
			</xsl:attribute>
			<xsl:apply-templates select="*[1]" />
		</xsl:element>
		<xsl:if test="following-sibling::*[position()=1][not(self::punc)]">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="following-sibling::*[position()=1]" />
	</xsl:template>

	<xsl:template match="body">
		<xsl:copy>
			<xsl:call-template name="print-site-header" />
			<xsl:element name="div">
				<xsl:attribute name="id">
					<xsl:text>content</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="data-role">
					<xsl:text>main</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="class">
					<xsl:text>ui-content</xsl:text>
				</xsl:attribute>
				<xsl:element name="div">
					<xsl:attribute name="id">
						<xsl:text>title</xsl:text>
					</xsl:attribute>
					<xsl:element name="h1">
						<xsl:value-of select="normalize-space(../title)" />
					</xsl:element>
				</xsl:element>
				<xsl:apply-templates select="node()|@*" />
				<xsl:element name="div">
					<xsl:attribute name="id">
						<xsl:text>citations</xsl:text>
					</xsl:attribute>
					<xsl:element name="h2">
						<xsl:text>Citation</xsl:text>
					</xsl:element>
					<xsl:element name="p">
						<xsl:attribute name="class">
							<xsl:text>citation</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="normalize-space(../citation)" />
						<xsl:text> (</xsl:text>
						<xsl:element name="a">
							<xsl:attribute name="href">
								<xsl:value-of select="normalize-space(../url)" />
							</xsl:attribute>
							<xsl:text>link</xsl:text>
						</xsl:element>
						<xsl:text>)</xsl:text>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:call-template name="print-site-footer"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="get-text-in-a-range">
		<xsl:param name="currentID" />
		<xsl:param name="endID" />
		<xsl:param name="text" />
		<xsl:for-each select="//t[@id=$currentID]">
			<xsl:variable name="currentText" select="." />
			<xsl:choose>
				<xsl:when test="($currentID=$endID) and (string-length($text) = 0)">
					<xsl:value-of select="$text" />
				</xsl:when>
				<xsl:when test="$currentID = $endID">
					<xsl:value-of select="normalize-space(concat($text, ' ', $currentText))" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="nextID" select="following::t[position()=1]/@id" />
					<xsl:call-template name="get-text-in-a-range">
						<xsl:with-param name="currentID" select="$nextID" />
						<xsl:with-param name="endID" select="$endID" />
						<xsl:with-param name="text"
							select="concat($text, ' ', $currentText)" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="print-header-info">
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
				<xsl:text>http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="script">
			<xsl:attribute name="src">
				<xsl:text>http://code.jquery.com/jquery-1.11.3.min.js</xsl:text>
<!-- 				<xsl:text>https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js</xsl:text> -->
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="script">
			<xsl:attribute name="src">
				<xsl:text>http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="link">
			<xsl:attribute name="rel">
				<xsl:text>stylesheet</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:text>../../css/adaps-doc-style.css</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="script">
			<xsl:attribute name="src">
				<xsl:text>../../js/adaps-library.js</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">
				<xsl:text>text/javascript</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="print-site-header">
		<xsl:element name="div">
			<xsl:attribute name="id">
				<xsl:text>header</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="data-role">
				<xsl:text>header</xsl:text>
			</xsl:attribute>
			<xsl:element name="p">
				<xsl:text>&#8212; Academic Document Annotation and Presentation System (ADAPS) &#8212;</xsl:text>
			</xsl:element>
			<xsl:call-template name="print-control-buttons" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="print-site-footer">
		<xsl:element name="div">
			<xsl:attribute name="data-role">
				<xsl:text>Footer</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="print-control-buttons">
		<xsl:element name="div">
			<xsl:attribute name="id">
				<xsl:text>control-buttons</xsl:text>
			</xsl:attribute>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>awl-button</xsl:text>
				</xsl:attribute>
				<xsl:text>AWL on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>gsl1-button</xsl:text>
				</xsl:attribute>
				<xsl:text>GSL1 on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>gsl2-button</xsl:text>
				</xsl:attribute>
				<xsl:text>GSL2 on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>abbr-button</xsl:text>
				</xsl:attribute>
				<xsl:text>Abbreviations on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>term-button</xsl:text>
				</xsl:attribute>
				<xsl:text>Technical terms on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>connector-button</xsl:text>
				</xsl:attribute>
				<xsl:text>Connectors on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>topic-button</xsl:text>
				</xsl:attribute>
				<xsl:text>Topic sentences on</xsl:text>
			</xsl:element>
			<xsl:element name="button">
				<xsl:attribute name="id">
					<xsl:text>all-button</xsl:text>
				</xsl:attribute>
				<xsl:text>All on</xsl:text>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="node()|@*">
		<xsl:value-of select="normalize-space(.)" />
	</xsl:template>
</xsl:stylesheet>
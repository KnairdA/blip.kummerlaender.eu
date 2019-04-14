<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"
/>

<xsl:variable name="root" select="datasource"/>

<xsl:template match="/">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="author"             content="{$root/meta/author}" />
	<meta name="description"        content="{$root/meta/description}" />
	<meta name="robots"             content="all"/>
	<meta name="viewport"           content="width=device-width,initial-scale=1.0"/>

	<link rel="stylesheet"    type="text/css"             href="/main.css" />
	<link rel="shortcut icon" type="image/x-icon"         href="/favicon.ico" />
	<link rel='alternate'     type='application/atom+xml' href='/atom.xml'/>

	<xsl:if test="//*[(self::p or self::span) and @class = 'math']">
		<link rel="stylesheet" type="text/css" href="https://static.kummerlaender.eu/katex/katex.min.css" />
	</xsl:if>

	<title>
		<xsl:call-template name="title-text"/> @ <xsl:value-of select="$root/meta/title"/>
	</title>
</head>
<body>
	<div id="content">
		<div class="large menuhead">
			<h1>
				<xsl:value-of select="$root/meta/title"/>
			</h1>
			<ul>
				<li>
					<a href="https://blog.kummerlaender.eu">blog</a>
				</li>
				<li>
					<a href="https://code.kummerlaender.eu">code</a>
				</li>
				<li>
					<a href="https://tree.kummerlaender.eu">tree</a>
				</li>
			</ul>
		</div>

		<xsl:apply-templates />
	</div>
</body>
</html>
</xsl:template>

<xsl:template match="text()|@*"/>

</xsl:stylesheet>

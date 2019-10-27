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

<xsl:include href="[utility/master.xsl]"/>
<xsl:include href="[utility/xhtml.xsl]"/>
<xsl:include href="[utility/date-time.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="00_content/meta.xml"  target="meta"/>
	<datasource type="support" mode="full" source="03_sort/timeline.xml" target="timeline"/>
	<target     mode="plain"   value="index.html"/>
</xsl:variable>

<xsl:template name="title-text">
	<xsl:text>Page 0</xsl:text>
</xsl:template>

<xsl:template match="timeline/entry[@type='commit']">
	<h3>
		<span class="arrow">
			<xsl:text>» </xsl:text>
		</span>
		<a href="{$root/meta/repository_base}/{@repo}/commit/?id={@hash}">
			<xsl:value-of select="title"/>
		</a>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> at </xsl:text>
			<xsl:value-of select="date/@time"/>
		<xsl:text> | </xsl:text>
		<a href="{$root/meta/repository_base}/{@repo}/">
			<xsl:value-of select="@repo"/>
		</a>
		<xsl:text> | </xsl:text>
		<a href="{$root/meta/repository_base}/{@repo}/commit/?id={@hash}">
			<xsl:value-of select="substring(@hash,0,7)"/>
		</a>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="$root/meta/author"/>
	</span>

	<xsl:apply-templates select="content/node()" mode="xhtml"/>
</xsl:template>

<xsl:template match="timeline/entry[@type='unstructured']">
	<h3>
		<span class="arrow">
			<xsl:text>» </xsl:text>
		</span>
		<a href="{title/@href}">
			<xsl:value-of select="title"/>
		</a>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> at </xsl:text>
			<xsl:value-of select="date/@time"/>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="$root/meta/author"/>
	</span>

	<xsl:apply-templates select="content/node()" mode="xhtml"/>
</xsl:template>

<xsl:template match="timeline">
	<div>
		<xsl:apply-templates select="entry[position() &lt;= $root/meta/limits/display]"/>
	</div>

	<div id="pagination">
		<span>
			<a class="pagination-next" href="/1">
				<xsl:text>older »</xsl:text>
			</a>
		</span>
	</div>
</xsl:template>

</xsl:stylesheet>

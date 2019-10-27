<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/master.xsl]"/>
<xsl:include href="[utility/xhtml.xsl]"/>
<xsl:include href="[utility/date-time.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="iterate" source="04_meta/paginated_timeline.xml" target="page"/>
	<datasource type="support" mode="full"    source="00_content/meta.xml"            target="meta"/>
	<datasource type="support" mode="full"    source="03_sort/timeline.xml"          target="timeline"/>
	<target     mode="xpath"   value="concat($datasource/page/entry/@index, '/index.html')"/>
</xsl:variable>

<xsl:template name="title-text">
	<xsl:text>Page </xsl:text>
	<xsl:value-of select="$root/page/entry/@index"/>
</xsl:template>

<xsl:template match="page/entry">
	<div>
		<xsl:apply-templates select="blip"/>
	</div>

	<div id="pagination">
		<xsl:if test="@index = 1">
			<span>
				<a class="pagination-previous" href="/">
					<xsl:text>« newer</xsl:text>
				</a>
			</span>
		</xsl:if>
		<xsl:if test="@index &lt; 1">
			<span>
				<a class="pagination-previous" href="/{@index - 1}">
					<xsl:text>« newer</xsl:text>
				</a>
			</span>
		</xsl:if>
		<xsl:if test="@index &lt; @total - 1">
			<span>
				<a class="pagination-next" href="/{@index + 1}">
					<xsl:text>older »</xsl:text>
				</a>
			</span>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="entry/blip">
	<xsl:variable name="handle" select="@handle"/>

	<xsl:apply-templates select="$root/timeline/entry[@hash = $handle]" mode="resolve"/>
</xsl:template>

<xsl:template match="timeline/entry" mode="resolve">
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

</xsl:stylesheet>

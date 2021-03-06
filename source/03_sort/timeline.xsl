<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="02_merge/timeline.xml" target="timeline"/>
	<target     mode="plain" value="timeline.xml"/>
</xsl:variable>

<xsl:template match="@* | node()" mode="copy">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()" mode="copy"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="timeline">
	<xsl:apply-templates select="entry" mode="copy">
		<xsl:sort select="date"       data-type="text" order="descending"/>
		<xsl:sort select="date/@time" data-type="text" order="descending"/>
	</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>

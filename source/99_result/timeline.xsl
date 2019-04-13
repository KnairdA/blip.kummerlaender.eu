<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="xml"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="no"
/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="03_merge/timeline.xml"  target="timeline"/>
	<datasource type="support" mode="full" source="00_content/meta.xml"    target="meta"/>
	<target     mode="plain"   value="timeline.xml"/>
</xsl:variable>

<xsl:variable name="root" select="/datasource"/>

<xsl:template match="timeline/entry">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="datasource">
	<timeline>
		<xsl:apply-templates select="timeline/entry[position() &lt;= $root/meta/limits/raw]"/>
	</timeline>
</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="03_sort/timeline.xml" target="timeline"/>
	<datasource type="support" mode="full" source="00_content/meta.xml"   target="meta"/>
	<target     mode="plain" value="paginated_timeline.xml"/>
</xsl:variable>

<xsl:variable name="page_size" select="/datasource/meta/limits/display"/>
<xsl:variable name="total" select="ceiling(count(datasource/timeline/entry) div $page_size)"/>

<xsl:template match="timeline/entry[(position() mod $page_size = 1) and (position() &gt; $page_size)]">
	<entry index="{floor(position() div $page_size)}" total="{$total}">
		<xsl:apply-templates mode="group" select=". | following-sibling::entry[not(position() > ($page_size - 1))]"/>
	</entry>
</xsl:template>

<xsl:template match="timeline/entry" mode="group">
	<blip handle="{@hash}"/>
</xsl:template>

</xsl:stylesheet>

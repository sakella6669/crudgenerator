<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="config/parameters">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<project-module type="WEB" name="]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[" id="myeclipse.1279201740628" context-root="/]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA["
	j2ee-spec="1.4" archive="]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[.war">
	<attributes>
		<attribute name="webrootdir" value="WebRoot" />
	</attributes>
</project-module>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>


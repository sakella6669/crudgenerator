<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="model">
    <root>eclipse.preferences.version=1
validator.Checked=WebRoot/WEB-INF/spring/spring.xml<xsl:for-each select="package">,WebRoot/WEB-INF/spring/spring-<xsl:value-of select="@name" />.xml</xsl:for-each>
validator.Unchecked=
    </root>
  </xsl:template>
</xsl:stylesheet>

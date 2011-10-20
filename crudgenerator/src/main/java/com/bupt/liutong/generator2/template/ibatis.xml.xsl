<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
  extension-element-prefixes="string">
  <xsl:template match="model">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE sqlMapConfig      
      PUBLIC "-//ibatis.apache.org//DTD SQL Map Config 2.0//EN"      
      "http://ibatis.apache.org/dtd/sql-map-config-2.dtd">
<sqlMapConfig>
	<settings useStatementNamespaces="true" />
	
	<sqlMap resource="com/bupt/liutong/core/sqlmap/common.xml" />
	<sqlMap resource="com/bupt/liutong/core/sqlmap/config.xml" />]]>
	<xsl:for-each select="package">
	<xsl:for-each select="table">
		<xsl:text>&lt;sqlMap resource="</xsl:text><xsl:value-of select="//model/parameters/parameter[@id='baseDir']/@value"/>/<xsl:value-of select="../@name"/>/sqlmap/gen/gen_<xsl:value-of select="@name"/><![CDATA[.xml" />]]>
	</xsl:for-each>
	</xsl:for-each>
<![CDATA[</sqlMapConfig>]]>
    </root> 
  </xsl:template>
</xsl:stylesheet>
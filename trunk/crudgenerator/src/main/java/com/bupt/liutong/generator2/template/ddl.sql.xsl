<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="table">
    <root>
DROP TABLE IF EXISTS `<xsl:value-of select="@name"/>`;
CREATE TABLE `<xsl:value-of select="@name"/>` (
  <xsl:for-each select="column">
    `<xsl:value-of select="@field"/>` <xsl:value-of select="@dbType"/><xsl:if test="@length!=''">(<xsl:value-of select="@length"/>)</xsl:if>
    <xsl:if test="string:isEmptyOrTrue(@notNull)">
      NOT NULL
      <xsl:if test="string:isTrue(@autoIncrement)">
        auto_increment
      </xsl:if>
      <xsl:if test="string:isEmptyOrFalse(@autoIncrement)">
      	<xsl:if test="string:isNotEmpty(@defaultValue)">
      	  <xsl:if test="@javaType='String'">default '<xsl:value-of select="@defaultValue"/>'</xsl:if>
      	  <xsl:if test="@javaType!='String'">default <xsl:value-of select="@defaultValue"/></xsl:if>
      	</xsl:if>
      </xsl:if> 
    </xsl:if>
    <xsl:if test="string:isFalse(@notNull)">
      default NULL
    </xsl:if>,
  </xsl:for-each>
  PRIMARY KEY  (`<xsl:value-of select="column[@isPrimary='true']/@name"/>`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    </root>
  </xsl:template>
</xsl:stylesheet>
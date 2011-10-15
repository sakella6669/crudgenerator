<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="table">
    <root>
      package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.form;
      
      import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.form.<xsl:value-of select="string:firstLetterLower(parameters/parameter[@id='genPrefixUpper']/@value)"/>.<xsl:value-of select="parameters/parameter[@id='genPrefixUpper']/@value"/><xsl:value-of select="@clazz"/>Form;
      
      public class <xsl:value-of select="@clazz"/>Form extends <xsl:value-of select="parameters/parameter[@id='genPrefixUpper']/@value"/><xsl:value-of select="@clazz"/>Form {
      
      }
    </root>
  </xsl:template>
</xsl:stylesheet>
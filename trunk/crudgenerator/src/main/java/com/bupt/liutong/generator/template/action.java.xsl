<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="table">
    <root>
package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.action;

import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.bo.<xsl:value-of select="@clazz"/>Bo;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.action.gen.Gen<xsl:value-of select="@clazz"/>Action;

public class <xsl:value-of select="@clazz"/>Action extends <xsl:value-of select="parameters/parameter[@id='genPrefixUpper']/@value"/><xsl:value-of select="@clazz"/>Action {
	
	private <xsl:value-of select="@clazz"/>Bo <xsl:value-of select="string:firstLetterLower(@clazz)"/>Bo;
	
	public void set<xsl:value-of select="@clazz"/>Bo(<xsl:value-of select="@clazz"/>Bo <xsl:value-of select="string:firstLetterLower(@clazz)"/>Bo){
		this.<xsl:value-of select="string:firstLetterLower(@clazz)"/>Bo = <xsl:value-of select="string:firstLetterLower(@clazz)"/>Bo;
	}
}
    </root>
  </xsl:template>
</xsl:stylesheet>
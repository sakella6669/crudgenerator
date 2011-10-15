<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>
package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dto.<xsl:value-of select="string:firstLetterLower(parameters/parameter[@id='genPrefixUpper']/@value)"/>;

<xsl:for-each select="import">import <xsl:value-of select="@clazz"/>;
</xsl:for-each>
import com.bupt.liutong.core.base.BaseDto;

public class <xsl:value-of select="parameters/parameter[@id='genPrefixUpper']/@value"/><xsl:value-of select="@clazz"/> extends BaseDto {
<xsl:for-each select="column">
	<xsl:text>	</xsl:text>private <xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/>;
</xsl:for-each>
<xsl:for-each select="column">
	public <xsl:value-of select="@javaType"/> get<xsl:value-of select="string:firstLetterUpper(@field)"/>(){
		return <xsl:value-of select="@field"/>;
	}
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>(<xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/>){
		this.<xsl:value-of select="@field"/> = <xsl:value-of select="@field"/>;
	}
</xsl:for-each>
}
		</root>	
	</xsl:template>
</xsl:stylesheet>
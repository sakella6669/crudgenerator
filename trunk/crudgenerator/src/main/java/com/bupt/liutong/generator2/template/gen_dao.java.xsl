<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>
package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dao.<xsl:value-of select="string:firstLetterLower(parameters/parameter[@id='genPrefixUpper']/@value)"/>;

import java.util.List;

import com.bupt.liutong.core.base.Ibatis;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dto.<xsl:value-of select="@clazz"/>;

public class Gen<xsl:value-of select="@clazz"/>Dao {

	protected Ibatis ibatis;

	@SuppressWarnings("unchecked")
	public List&lt;<xsl:value-of select="@clazz"/>&gt; get<xsl:value-of select="@clazz"/>sByPage(<xsl:value-of select="@clazz"/><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/>) {
		return (List&lt;<xsl:value-of select="@clazz"/>&gt;) ibatis.queryForPage("<xsl:value-of select="parameters/parameter[@id='genPrefixLower']/@value"/><xsl:value-of select="@name"/>.get<xsl:value-of select="@clazz"/>s", <xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	public <xsl:value-of select="@clazz"/> get<xsl:value-of select="@clazz"/>By<xsl:value-of select="string:firstLetterUpper(column[@isPrimary='true']/@name)"/>(<xsl:value-of select="column[@isPrimary='true']/@javaType"/><xsl:text> </xsl:text><xsl:value-of select="column[@isPrimary='true']/@name"/>) {
		return (<xsl:value-of select="@clazz"/>) ibatis.queryForObject("<xsl:value-of select="parameters/parameter[@id='genPrefixLower']/@value"/><xsl:value-of select="@name"/>.get<xsl:value-of select="@clazz"/>By<xsl:value-of select="string:firstLetterUpper(column[@isPrimary='true']/@name)"/>", <xsl:value-of select="column[@isPrimary='true']/@name"/>);
	}

	public Integer insert<xsl:value-of select="@clazz"/>(<xsl:value-of select="@clazz"/><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/>) {
		return (Integer) ibatis.insert("<xsl:value-of select="parameters/parameter[@id='genPrefixLower']/@value"/><xsl:value-of select="@name"/>.insert<xsl:value-of select="@clazz"/>", <xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	public void update<xsl:value-of select="@clazz"/>(<xsl:value-of select="@clazz"/><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/>) {
		ibatis.update("<xsl:value-of select="parameters/parameter[@id='genPrefixLower']/@value"/><xsl:value-of select="@name"/>.update<xsl:value-of select="@clazz"/>", <xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	public void delete<xsl:value-of select="@clazz"/>(<xsl:value-of select="column[@isPrimary='true']/@javaType"/><xsl:text> </xsl:text><xsl:value-of select="column[@isPrimary='true']/@name"/>) {
		ibatis.delete("<xsl:value-of select="parameters/parameter[@id='genPrefixLower']/@value"/><xsl:value-of select="@name"/>.delete<xsl:value-of select="@clazz"/>", <xsl:value-of select="column[@isPrimary='true']/@name"/>);
	}

	public void setIbatis(Ibatis ibatis) {
		this.ibatis = ibatis;
	}
}
		</root>	
	</xsl:template>
</xsl:stylesheet>
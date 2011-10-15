<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd"&gt;
			
&lt;sqlMap namespace="<xsl:value-of select="@name"/>"&gt;
	&lt;typeAlias alias="<xsl:value-of select="@clazz"/>" type="<xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dto.<xsl:value-of select="@clazz"/>" /&gt;
&lt;/sqlMap&gt;
		</root>
	</xsl:template>
</xsl:stylesheet>
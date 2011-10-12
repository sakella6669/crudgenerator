<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd"&gt;
			
&lt;sqlMap namespace="gen_<xsl:value-of select="@name"/>"&gt;
	&lt;typeAlias alias="Gen<xsl:value-of select="@clazz"/>" type="<xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dto.gen.Gen<xsl:value-of select="@clazz"/>" /&gt;
			
	&lt;select id="get<xsl:value-of select="@clazz"/>s" resultClass="Gen<xsl:value-of select="@clazz"/>"&gt;
		SELECT * FROM <xsl:value-of select="@name"/>
		&lt;dynamic prepend="WHERE"&gt;
			<xsl:for-each select="column[string:isTrue(@queryItem)]">&lt;isNotEmpty property="<xsl:value-of select="@name"/>" prepend="AND"&gt;
				<xsl:if test="@javaType='String'"><xsl:value-of select="@name"/> LIKE '%$<xsl:value-of select="@field"/>$%'</xsl:if>
				<xsl:if test="@javaType!='String'"><xsl:value-of select="@name"/> = #<xsl:value-of select="@field"/>#</xsl:if>
			&lt;/isNotEmpty&gt;</xsl:for-each>
		&lt;/dynamic&gt;
	&lt;/select&gt;
  
	&lt;select id="get<xsl:value-of select="@clazz"/>sCount" resultClass="Integer"&gt;
		SELECT COUNT(1) FROM <xsl:value-of select="@name"/>
	&lt;/select&gt;

	&lt;select id="get<xsl:value-of select="@clazz"/>By<xsl:value-of select="string:firstLetterUpper(column[@isPrimary='true']/@name)"/>" parameterClass="<xsl:value-of select="column[@isPrimary='true']/@javaType"/>" resultClass="Gen<xsl:value-of select="@clazz"/>"&gt;
		SELECT * FROM <xsl:value-of select="@name"/>
		WHERE <xsl:value-of select="column[@isPrimary='true']/@name"/> = #<xsl:value-of select="column[@isPrimary='true']/@name"/>#
	&lt;/select&gt;
				
	&lt;insert id="insert<xsl:value-of select="@clazz"/>" parameterClass="Gen<xsl:value-of select="@clazz"/>"&gt;
		INSERT <xsl:value-of select="@name"/>
		(<xsl:for-each select="column[string:isEmptyOrTrue(@inputItem)]">
		<xsl:if test="position()!=1">, </xsl:if>
			<xsl:value-of select="@name"/>
		</xsl:for-each>) VALUES
		(<xsl:for-each select="column[string:isEmptyOrTrue(@inputItem)]">
		<xsl:if test="position()!=1">, </xsl:if>
		<xsl:text>#</xsl:text><xsl:value-of select="@name"/><xsl:text>#</xsl:text>
		<!--<xsl:if test="string:isEmpty(@defaultValue)">
        	<xsl:text>#</xsl:text><xsl:value-of select="@name"/><xsl:text>#</xsl:text>
		</xsl:if>
		<xsl:if test="string:isNotEmpty(@defaultValue)">
        	<xsl:text>'</xsl:text><xsl:value-of select="@defaultValue"/><xsl:text>'</xsl:text>
		</xsl:if>-->
		</xsl:for-each>)
	&lt;/insert&gt;
				
	&lt;update id="update<xsl:value-of select="@clazz"/>" parameterClass="Gen<xsl:value-of select="@clazz"/>"&gt;
		UPDATE <xsl:value-of select="@name"/> SET 
		<xsl:for-each select="column[string:isEmptyOrTrue(@inputItem)]">
		<xsl:if test="position()!=1">, </xsl:if>
        <xsl:value-of select="@name"/> = <xsl:text>#</xsl:text><xsl:value-of select="@name"/><xsl:text>#</xsl:text>
		</xsl:for-each>
		WHERE <xsl:value-of select="column[@isPrimary='true']/@name"/> = #<xsl:value-of select="column[@isPrimary='true']/@name"/>#
	&lt;/update&gt;
				
	&lt;delete id="delete<xsl:value-of select="@clazz"/>" parameterClass="<xsl:value-of select="column[@isPrimary='true']/@javaType"/>"&gt;
		DELETE FROM <xsl:value-of select="@name"/>
		WHERE <xsl:value-of select="column[@isPrimary='true']/@name"/> = #<xsl:value-of select="column[@isPrimary='true']/@name"/>#
	&lt;/delete&gt;
&lt;/sqlMap&gt;</root>	
	</xsl:template>
</xsl:stylesheet>
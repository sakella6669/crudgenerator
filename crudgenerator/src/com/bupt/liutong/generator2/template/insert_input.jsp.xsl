<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>
<![CDATA[<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

	<table class="table1">]]>
	<xsl:for-each select="column[string:isEmptyOrTrue(@inputItem)]"><![CDATA[<tr><td class="td30">]]>
		<xsl:value-of select="@chs"/>
		<![CDATA[</td>]]>
		<![CDATA[<td class="td70">]]>
			<xsl:if test="normalize-space(@itemType)='' or @itemType!=50">
				<![CDATA[<html:text property="]]><xsl:value-of select="@field"/>" value="<xsl:if test="string:isNotEmpty(@defaultValue)"><xsl:value-of select="@defaultValue"/></xsl:if>"<![CDATA[ size="15"/>]]><xsl:if test="string:isTrue(@mustInput)">&amp;nbsp;&amp;nbsp;*</xsl:if>
			</xsl:if>
			<xsl:if test="@itemType=50">
				<![CDATA[<html:select property="]]><xsl:value-of select="@field"/><![CDATA[">
					<html:options collection="]]><xsl:value-of select="@field"/><![CDATA[List" property="label" labelProperty="value" />
				</html:select>]]>
			</xsl:if>
		<![CDATA[</td></tr>]]>
	</xsl:for-each>
	<![CDATA[</table>]]>
		</root>	
	</xsl:template>
</xsl:stylesheet>
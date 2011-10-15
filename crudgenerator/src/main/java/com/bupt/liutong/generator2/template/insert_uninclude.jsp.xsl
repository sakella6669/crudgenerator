<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>
<![CDATA[
<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html:html lang="true">
<head>
	<html:base />
	<title>]]><xsl:value-of select="@name"/><![CDATA[_insert.jsp</title>
	
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/base.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base_orange.css" />
	<script type="text/javascript">		
		function validate(){
			return validateEmpty(new Array(]]><xsl:for-each select="column[@mustInput='true']"><xsl:if test="position()!=1">,</xsl:if>'<xsl:value-of select="@field"/>'</xsl:for-each><![CDATA[))
				&& validateNum(new Array(]]><xsl:for-each select="column[@itemType=21]"><xsl:if test="position()!=1">,</xsl:if>'<xsl:value-of select="@field"/>'</xsl:for-each><![CDATA[))
				&& validateDate(new Array(]]><xsl:for-each select="column[@itemType=30]"><xsl:if test="position()!=1">,</xsl:if>'<xsl:value-of select="@field"/>'</xsl:for-each><![CDATA[));
		}
	</script>
</head>
<body>
]]>
<![CDATA[<html:form action="/]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[">]]>
	<![CDATA[<table class="title1">
		<tr>
			<td class="title1_td1">]]>
				<xsl:value-of select="@chs"/><![CDATA[管理
			</td>
			<td class="title1_td2">
				<input class="button_2zi" type="button" value="保 存"
					onclick="if(validate()) dosubmit(this.form, '../]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[.do?method=insert]]><xsl:value-of select="@clazz"/><![CDATA[Do');" />
				<input class="button_2zi" type="reset" value="撤 销" />
				<input class="button_2zi" type="button" value="返 回"
					onclick="history.back();" />
			</td>
		</tr>
	</table>
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
	<![CDATA[</table></html:form>
	</body>
</html:html>]]>
		</root>	
	</xsl:template>
</xsl:stylesheet>
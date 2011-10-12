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
	<![CDATA[<jsp:include page="]]><xsl:value-of select="@name" /><![CDATA[_insert_head.jsp" />
	<jsp:include page="]]><xsl:value-of select="@name" /><![CDATA[_insert_input.jsp" />
	</html:form>
	</body>
</html:html>]]>
		</root>	
	</xsl:template>
</xsl:stylesheet>
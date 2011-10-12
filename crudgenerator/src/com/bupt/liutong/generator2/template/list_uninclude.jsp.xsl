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
			
			<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			<html:html lang="true">
			<head>
				<html:base />
				<title>]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[_list.jsp</title>
				
				<meta http-equiv="pragma" content="no-cache" />
				<meta http-equiv="cache-control" content="no-cache" />
				<meta http-equiv="expires" content="0" />
				<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
				<meta http-equiv="description" content="This is my page" />
				<script type="text/javascript" src="<%=request.getContextPath()%>/js/base.js"></script>
				<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/base_orange.css" />
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
						<input class="button_4zi" type="button" value="添加]]><xsl:value-of select="@chs"/><![CDATA["
							onclick="dosubmit(this.form, '../]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[.do?method=insert]]><xsl:value-of select="@clazz"/><![CDATA[');" />
					</td>
				</tr>
			</table>]]>
			<![CDATA[<table class="table1">
				<tr>
					<td class="td100">]]>
						<xsl:for-each select="column[string:isTrue(@queryItem)]">
							<xsl:value-of select="@chs"/>
							<![CDATA[<html:text property="]]><xsl:value-of select="@field"/><![CDATA[" size="15"></html:text>&nbsp;&nbsp;&nbsp;&nbsp;]]>
						</xsl:for-each>
						<![CDATA[&nbsp;<html:submit styleClass="button_2zi"
						onclick="dosubmit(this.form, '../]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[.do?method=get]]><xsl:value-of select="@clazz"/><![CDATA[sByPage&searchFlag=1');">查 询</html:submit>
					</td>
				</tr>
			</table>]]>
			
			<![CDATA[<table class="table2">
				<tr>
					<th>
						<input type="checkbox" onclick="selectAll(']]><xsl:value-of select="column[@isPrimary='true']/@field"/><![CDATA[',this.checked)" />
					</th>]]>
					<xsl:for-each select="column[string:isTrue(@listDisp)]">
					<![CDATA[<th>]]>
						<xsl:value-of select="@chs"/>
					<![CDATA[</th>]]>
					</xsl:for-each>
                    <![CDATA[<th>
                           操作
                    </th>
				</tr>
				<logic:iterate id="iter" name="]]><xsl:value-of select="string:firstLetterLower(@clazz)"/><![CDATA[FormList">
					<tr>
						<td>
							<html:checkbox property="]]><xsl:value-of select="column[@isPrimary='true']/@field"/><![CDATA[" value="${iter.]]><xsl:value-of select="column[@isPrimary='true']/@field"/><![CDATA[}" />
						</td>]]>
						<xsl:for-each select="column[string:isTrue(@listDisp)]">
						<![CDATA[<td>]]>
							<xsl:if test="@itemType!=50">
								${iter.<xsl:value-of select="@field"/>}
							</xsl:if>
							<xsl:if test="@itemType=50">
								${iter.<xsl:value-of select="@field"/>Str}
							</xsl:if>
						<![CDATA[</td>]]>
						</xsl:for-each>
                        <![CDATA[<td>
                            <a href="<%=request.getContextPath()%>/]]><xsl:value-of select="@package"/>/<xsl:value-of select="string:firstLetterLower(@clazz)"/>.do?method=update<xsl:value-of select="@clazz"/>&amp;<xsl:value-of select="column[@isPrimary='true']/@field"/>=${iter.<xsl:value-of select="column[@isPrimary='true']/@field"/>}<![CDATA[">改</a>
                                <a href="<%=request.getContextPath()%>/]]><xsl:value-of select="@package"/>/<xsl:value-of select="string:firstLetterLower(@clazz)"/>.do?method=delete<xsl:value-of select="@clazz"/>s&amp;<xsl:value-of select="column[@isPrimary='true']/@field"/>=${iter.<xsl:value-of select="column[@isPrimary='true']/@field"/>}<![CDATA[">删</a>
                        </td>
                    </tr>
				</logic:iterate>
			</table>]]>
			
			<![CDATA[<jsp:include page="/core/page_info/page_info.jsp" />
			</html:form>
			</body>
			</html:html>]]>
		</root>	
	</xsl:template>
</xsl:stylesheet>
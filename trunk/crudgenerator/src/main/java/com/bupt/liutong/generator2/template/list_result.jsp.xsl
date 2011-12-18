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

	<table class="table2">
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
							<xsl:if test="@itemType!=30 and @itemType!=50">
								${iter.<xsl:value-of select="@field"/>}
							</xsl:if>
							<xsl:if test="@itemType=30">
								${iter.<xsl:value-of select="@field"/>Str}
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
    </root> 
  </xsl:template>
</xsl:stylesheet>
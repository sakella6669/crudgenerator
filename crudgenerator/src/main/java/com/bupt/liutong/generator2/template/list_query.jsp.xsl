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

	<table class="table1">
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
    </root> 
  </xsl:template>
</xsl:stylesheet>
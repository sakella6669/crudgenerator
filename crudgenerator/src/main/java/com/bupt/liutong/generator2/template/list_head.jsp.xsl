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

	<table class="title1">
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
    </root> 
  </xsl:template>
</xsl:stylesheet>
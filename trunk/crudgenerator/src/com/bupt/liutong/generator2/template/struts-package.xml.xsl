<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="package">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE struts-config PUBLIC "-//Apache Software Foundation//DTD Struts Configuration 1.2//EN" "http://struts.apache.org/dtds/struts-config_1_2.dtd">
<struts-config>
	<data-sources />
	<form-beans>]]>
    <xsl:for-each select="table">
      &lt;form-bean name="<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form" type="<xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="../@name"/>.form.<xsl:value-of select="@clazz"/>Form" /&gt;
    </xsl:for-each>
    <![CDATA[</form-beans>
	<global-exceptions />
	<global-forwards />
	<action-mappings>]]>
    <xsl:for-each select="table">
      &lt;action attribute="<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form" name="<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form"
        parameter="method" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>" scope="request" validate="false"
        type="org.springframework.web.struts.DelegatingActionProxy"&gt;
        &lt;forward name="get<xsl:value-of select="@clazz"/>sByPageSuccess" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>/<xsl:value-of select="@name"/>_list.jsp" /&gt;
        &lt;forward name="insert<xsl:value-of select="@clazz"/>Success" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>/<xsl:value-of select="@name"/>_insert.jsp" /&gt;
        &lt;forward name="insert<xsl:value-of select="@clazz"/>DoSuccess" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>.do?method=get<xsl:value-of select="@clazz"/>sByPage&amp;amp;searchFlag=1" redirect="true" /&gt;
        &lt;forward name="update<xsl:value-of select="@clazz"/>Success" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>/<xsl:value-of select="@name"/>_update.jsp" /&gt;
        &lt;forward name="update<xsl:value-of select="@clazz"/>DoSuccess" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>.do?method=get<xsl:value-of select="@clazz"/>sByPage&amp;amp;searchFlag=1" redirect="true" /&gt;
        &lt;forward name="delete<xsl:value-of select="@clazz"/>sSuccess" path="/<xsl:value-of select="string:firstLetterLower(@clazz)"/>.do?method=get<xsl:value-of select="@clazz"/>sByPage&amp;amp;searchFlag=1" redirect="true" /&gt;
      &lt;/action&gt;
    </xsl:for-each>
    <![CDATA[</action-mappings>
</struts-config>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
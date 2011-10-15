<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="model">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE struts-config PUBLIC "-//Apache Software Foundation//DTD Struts Configuration 1.2//EN" "http://struts.apache.org/dtds/struts-config_1_2.dtd">
<struts-config>
	<data-sources />
	<form-beans></form-beans>
	<global-exceptions />
	<global-forwards />
	<action-mappings></action-mappings>
	<message-resources
		parameter="com.bupt.liutong.ApplicationResources" />]]>
    
	&lt;plug-in className="org.springframework.web.struts.ContextLoaderPlugIn"&gt;
		&lt;set-property property="contextConfigLocation" value="/WEB-INF/spring/spring.xml<xsl:for-each select="package">,/WEB-INF/spring/spring-gen-<xsl:value-of select="@name" />.xml,/WEB-INF/spring/spring-<xsl:value-of select="@name" />.xml</xsl:for-each>" /&gt;
	&lt;/plug-in&gt;
<![CDATA[</struts-config>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
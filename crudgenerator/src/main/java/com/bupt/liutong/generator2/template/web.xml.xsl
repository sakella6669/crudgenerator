<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
  extension-element-prefixes="string">
  <xsl:template match="model">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.4"
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">

	<context-param>
		<param-name>log4jConfigLocation</param-name>
		<param-value>WEB-INF/log4j.properties</param-value>
	</context-param>
	<context-param>
		<param-name>log4jRefreshInterval</param-name>
		<param-value>60000</param-value>
	</context-param>

	<filter>
		<filter-name>CharacterFilter</filter-name>
		<filter-class>
			com.bupt.liutong.core.filter.CharacterFilter
		</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>CharacterFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

	<listener>
		<listener-class>
			org.springframework.web.util.Log4jConfigListener
		</listener-class>
	</listener>

	<servlet>
		<servlet-name>action</servlet-name>
		<servlet-class>
			org.apache.struts.action.ActionServlet
		</servlet-class>
		<init-param>
			<param-name>config</param-name>
			<param-value>/WEB-INF/classes/struts.xml</param-value>
		</init-param>]]>
        <xsl:for-each select="package">
		&lt;init-param&gt;
			&lt;param-name&gt;config/<xsl:value-of select="@name"/>&lt;/param-name&gt;
			&lt;param-value&gt;/WEB-INF/classes/struts-<xsl:value-of select="@name"/>.xml&lt;/param-value&gt;
		&lt;/init-param>
        </xsl:for-each>
		<![CDATA[<init-param>
			<param-name>debug</param-name>
			<param-value>3</param-value>
		</init-param>
		<init-param>
			<param-name>detail</param-name>
			<param-value>3</param-value>
		</init-param>
		<load-on-startup>0</load-on-startup>
	</servlet>


	<servlet-mapping>
		<servlet-name>action</servlet-name>
		<url-pattern>*.do</url-pattern>
	</servlet-mapping>
	<welcome-file-list>
		<welcome-file>/index.jsp</welcome-file>
	</welcome-file-list>
</web-app>]]>
    </root> 
  </xsl:template>
</xsl:stylesheet>


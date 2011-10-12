<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="package">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">]]>
	<xsl:for-each select="table">
  &lt;bean id="gen<xsl:value-of select="@clazz"/>Dao" class="<xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="../@name"/>.dao.gen.Gen<xsl:value-of select="@clazz"/>Dao"&gt;
    &lt;property name="ibatis" ref="ibatis"&gt;&lt;/property&gt;
  &lt;/bean&gt;
  &lt;bean id="gen<xsl:value-of select="@clazz"/>Bo" class="<xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="../@name"/>.bo.gen.Gen<xsl:value-of select="@clazz"/>Bo" parent="baseBo"&gt;
    &lt;property name="gen<xsl:value-of select="@clazz"/>Dao" ref="gen<xsl:value-of select="@clazz"/>Dao"&gt;&lt;/property&gt;
  &lt;/bean&gt;
  &lt;bean id="gen<xsl:value-of select="@clazz"/>Action" class="<xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="../@name"/>.action.gen.Gen<xsl:value-of select="@clazz"/>Action" parent="baseAction"&gt;
    &lt;property name="gen<xsl:value-of select="@clazz"/>Bo" ref="gen<xsl:value-of select="@clazz"/>Bo"&gt;&lt;/property&gt;
  &lt;/bean&gt;
      </xsl:for-each>
<![CDATA[</beans>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
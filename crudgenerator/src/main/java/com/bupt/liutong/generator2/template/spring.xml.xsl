<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="config/db">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xmlns:tx="http://www.springframework.org/schema/tx"
    xsi:schemaLocation="http://www.springframework.org/schema/beans 
           http://www.springframework.org/schema/beans/spring-beans-2.5.xsd
           http://www.springframework.org/schema/context
           http://www.springframework.org/schema/context/spring-context-2.5.xsd
           http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.5.xsd
           http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-2.5.xsd">
	
	<bean id="dataSource"
		class="com.mchange.v2.c3p0.ComboPooledDataSource" destroy-method="close">]]>
		&lt;property name="driverClass" value="<xsl:value-of select="@driverClass" />" /&gt;
		&lt;property name="jdbcUrl" value="<xsl:value-of select="@jdbcUrl" />" /&gt;
		&lt;property name="user" value="<xsl:value-of select="@userId" />" /&gt;
		&lt;property name="password" value="<xsl:value-of select="@password" />" /&gt;
		<![CDATA[<property name="initialPoolSize" value="2" />
		<property name="minPoolSize" value="2" />
		<property name="maxPoolSize" value="30" />
		<property name="maxIdleTime" value="600" />
		<property name="acquireIncrement" value="3" />
		<property name="numHelperThreads" value="3" />
	</bean>
     
	<!-- Transaction manager for a single JDBC DataSource -->
	<bean id="transactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	
	<tx:annotation-driven transaction-manager="transactionManager" />
	
	<!-- SqlMapClientFactoryBean Suuport JDBC Transaction -->
	<bean id="transactionConfigClass" class="java.lang.Class"
		factory-method="forName">
		<constructor-arg index="0"
			value="com.ibatis.sqlmap.engine.transaction.jdbc.JdbcTransactionConfig" />
	</bean>
	<bean id="sqlMapClient" class="org.springframework.orm.ibatis.SqlMapClientFactoryBean">
		<property name="configLocation" value="/WEB-INF/classes/ibatis.xml" />
		<property name="dataSource" ref="dataSource" />
		<property name="transactionConfigClass" ref="transactionConfigClass" />
	</bean>
	<bean id="ibatis" class="com.bupt.liutong.core.base.SqlMapClientDao">
		<property name="sqlMapClient" ref="sqlMapClient" />
	</bean>
	
	<bean id="commonDao" class="com.bupt.liutong.core.dao.CommonDao">
		<property name="ibatis" ref="ibatis"></property>
	</bean>
	<bean id="sm" class="com.bupt.liutong.core.base.SessionManager">
		<property name="commonDao" ref="commonDao"></property>
	</bean>
	<bean id="ctm" class="com.bupt.liutong.core.base.CodeTableManager">
	</bean>
	
	<!-- Base Module -->
	<bean id="baseBo" class="com.bupt.liutong.core.base.BaseBo" abstract="true">
		<property name="sm" ref="sm"></property>
		<property name="ctm" ref="ctm"></property>
	</bean>
	<bean id="baseAction" class="com.bupt.liutong.core.base.BaseAction" abstract="true">
		<property name="ctm" ref="ctm"></property>
	</bean>
</beans>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
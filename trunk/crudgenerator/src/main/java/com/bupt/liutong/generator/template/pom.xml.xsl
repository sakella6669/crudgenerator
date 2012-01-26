<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="config/parameters">
		<root><![CDATA[<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>]]><xsl:value-of select="parameter[@id='basePackage']/@value" /><![CDATA[</groupId>
  <artifactId>]]><xsl:value-of select="parameter[@id='prjName']/@value" /><![CDATA[</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>war</packaging>
  <properties>
		<struts.version>1.2.9</struts.version>
		<struts2.version>2.2.3</struts2.version>
		<spring.version>2.5.6.SEC03</spring.version>
		<springside.version>3.1.3</springside.version>
		<hibernate.version>3.3.2.GA</hibernate.version>
		<ibatis.version>2.3.5</ibatis.version>
  </properties>

  <name>]]><xsl:value-of select="parameter[@id='prjName']/@value" /><![CDATA[</name>
  <url>http://maven.apache.org</url>

  <dependencies>
		<dependency>
			<groupId>com.bupt.liutong</groupId>
			<artifactId>utils</artifactId>
			<version>1.0.0</version>
		</dependency>

		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>2.4</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>jsp-api</artifactId>
			<version>2.1</version>
			<scope>provided</scope>
		</dependency>

		<dependency>
			<groupId>struts</groupId>
			<artifactId>struts</artifactId>
			<version>${struts.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-aop</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-orm</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-tx</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-web</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc-struts</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>com.ibatis</groupId>
			<artifactId>ibatis2</artifactId>
			<version>${ibatis.version}</version>
		</dependency>

		<dependency>
			<groupId>commons-collections</groupId>
			<artifactId>commons-collections</artifactId>
			<version>2.1</version>
		</dependency>
		<dependency>
			<groupId>cglib</groupId>
			<artifactId>cglib-nodep</artifactId>
			<version>2.1_3</version>
		</dependency>
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.15</version>
			<scope>runtime</scope>
			<exclusions>
				<exclusion>
					<groupId>javax.mail</groupId>
					<artifactId>mail</artifactId>
				</exclusion>
				<exclusion>
					<groupId>javax.jms</groupId>
					<artifactId>jms</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jdmk</groupId>
					<artifactId>jmxtools</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jmx</groupId>
					<artifactId>jmxri</artifactId>
				</exclusion>
				<exclusion>
					<groupId>oro</groupId>
					<artifactId>oro</artifactId>
				</exclusion>
			</exclusions>
		</dependency>
	</dependencies>

  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-war-plugin</artifactId>
          <version>2.1.1</version>
        </plugin>
      </plugins>
    </pluginManagement>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>2.0.2</version>
        <configuration>
          <source>1.5</source>
          <target>1.5</target>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>tomcat-maven-plugin</artifactId>
        <version>1.0-beta-1</version>
        <configuration>
			<warSourceDirectory>${basedir}\WebRoot</warSourceDirectory>
          	<url>http://localhost/]]><xsl:value-of select="parameter[@id='prjName']/@value" /><![CDATA[</url>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>2.1.1</version>
		<configuration>
			<warSourceDirectory>${basedir}\WebRoot</warSourceDirectory>
		</configuration>
      </plugin>
    </plugins>
  </build>
</project>]]>
		</root>
	</xsl:template>
</xsl:stylesheet>
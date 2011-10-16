<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="config/parameters">
    <root><![CDATA[<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>]]><xsl:value-of select="parameter[@id='basePackage']/@value"/><![CDATA[</groupId>
  <artifactId>]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>war</packaging>
  <properties>
    <springside.version>3.1.3</springside.version>
    <spring.version>2.5.6</spring.version>
    <hibernate.version>3.3.2.GA</hibernate.version>
    <struts2.version>2.2.3</struts2.version>
    <dr-jeneral.version>1.0.0</dr-jeneral.version>
    <firekylin.version>1.1.0</firekylin.version>
    <uni-menu.version>1.0.0</uni-menu.version>
  </properties>

  <name>demo</name>
  <url>http://maven.apache.org</url>

  <dependencies>
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

    <!-- struts -->
    <dependency>
      <groupId>org.apache.struts</groupId>
      <artifactId>struts2-core</artifactId>
      <version>${struts2.version}</version>
      <exclusions>
        <exclusion>
          <groupId>com.sun</groupId>
          <artifactId>tools</artifactId>
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
          <url>http://localhost/]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[</url>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>2.1.1</version>
      </plugin>
    </plugins>
  </build>
</project>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
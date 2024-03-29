<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="config/parameters">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
	<name>]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[</name>
	<comment></comment>
	<projects>
	</projects>
	<buildSpec>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.maven.ide.eclipse.maven2Builder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.m2e.core.maven2Builder</name>
			<arguments>
			</arguments>
		</buildCommand>
	</buildSpec>
	<natures>
		<nature>org.eclipse.m2e.core.maven2Nature</nature>
		<nature>org.eclipse.jdt.core.javanature</nature>
		<nature>org.maven.ide.eclipse.maven2Nature</nature>
	</natures>
</projectDescription>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="config/parameters">
    <root><![CDATA[<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
	<name>]]><xsl:value-of select="parameter[@id='prjName']/@value"/><![CDATA[</name>
	<comment></comment>
	<projects></projects>
	<buildSpec>
		<buildCommand>
			<name>com.genuitec.eclipse.j2eedt.core.WebClasspathBuilder</name>
			<arguments></arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments></arguments>
		</buildCommand>
		<buildCommand>
			<name>com.genuitec.eclipse.j2eedt.core.J2EEProjectValidator</name>
			<arguments></arguments>
		</buildCommand>
		<buildCommand>
			<name>com.genuitec.eclipse.j2eedt.core.DeploymentDescriptorValidator</name>
			<arguments></arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.wst.validation.validationbuilder</name>
			<arguments></arguments>
		</buildCommand>
		<buildCommand>
			<name>com.genuitec.eclipse.ast.deploy.core.DeploymentBuilder</name>
			<arguments></arguments>
		</buildCommand>
	</buildSpec>
	<natures>
		<nature>com.genuitec.eclipse.ast.deploy.core.deploymentnature</nature>
		<nature>com.genuitec.eclipse.j2eedt.core.webnature</nature>
		<nature>org.eclipse.jdt.core.javanature</nature>
	</natures>
</projectDescription>]]>
    </root>
  </xsl:template>
</xsl:stylesheet>
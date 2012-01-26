<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:string="xalan://com.bupt.liutong.util.StringUtils"
	extension-element-prefixes="string">
	<xsl:template match="table">
		<root>
package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.form;

<xsl:for-each select="import">import <xsl:value-of select="@clazz"/>;
</xsl:for-each>
<xsl:for-each select="column[@m2mJoinTable!='']">
import java.util.List;
import com.bupt.liutong.util.BeanUtils;
import com.bupt.liutong.util.entity.AutoArrayList;
import com.bupt.liutong.util.HasKey;
import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.form.<xsl:value-of select="@m2mJoinTable" />Form;
</xsl:for-each>
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;

import com.bupt.liutong.core.base.BaseForm;

public class <xsl:value-of select="@clazz"/>Form extends BaseForm <xsl:for-each select="column[@m2mJoinTable!='']">implements HasKey </xsl:for-each>{
<xsl:for-each select="column">
	private <xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/><xsl:if test="@defaultValue!=''">=<xsl:value-of select="@javaType"/>.valueOf(<xsl:value-of select="@defaultValue"/>)</xsl:if>;
	<xsl:if test="@itemType=30">private String <xsl:value-of select="@field"/>Str = DateUtils.getDateStr(new Date());</xsl:if>
	<xsl:if test="@itemType=50">private String <xsl:value-of select="@field"/>Str;</xsl:if>
</xsl:for-each>
<xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">
	private List&lt;<xsl:value-of select="@m2mJoinTable" />Form&gt; <xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms = new AutoArrayList&lt;<xsl:value-of select="@m2mJoinTable" />Form&gt;(<xsl:value-of select="@m2mJoinTable" />Form.class);
</xsl:for-each>
<xsl:for-each select="column">
	<!-- 普通项 -->
	public <xsl:value-of select="@javaType"/> get<xsl:value-of select="string:firstLetterUpper(@field)"/>(){
		return <xsl:value-of select="@field"/>;
	}
	<xsl:if test="@itemType!=30 and @itemType!=50">
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>(<xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/>){
		this.<xsl:value-of select="@field"/> = <xsl:value-of select="@field"/>;
	}
	</xsl:if>
	<!-- 日期项 -->
	<xsl:if test="@itemType=30">
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>(<xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/>){
		this.<xsl:value-of select="@field"/> = <xsl:value-of select="@field"/>;
		if (<xsl:value-of select="@field"/> != null)
			<xsl:value-of select="@field"/>Str = DateUtils.getDateStr(<xsl:value-of select="@field"/>);
	}
	public String get<xsl:value-of select="string:firstLetterUpper(@field)"/>Str(){
		return <xsl:value-of select="@field"/>Str;
	}
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>Str(String <xsl:value-of select="@field"/>Str){
		this.<xsl:value-of select="@field"/>Str = <xsl:value-of select="@field"/>Str;
		if (<xsl:value-of select="@field"/>Str != null)
			<xsl:value-of select="@field"/> = DateUtils.getDate(<xsl:value-of select="@field"/>Str);
	}
	</xsl:if>
	<!-- 下拉菜单项 -->
	<xsl:if test="@itemType=50">
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>(<xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@field"/>){
		this.<xsl:value-of select="@field"/> = <xsl:value-of select="@field"/>;
		if (<xsl:value-of select="@field"/> != null) {
			<xsl:value-of select="@field"/>Str = ctm.get("<xsl:value-of select="@codeMapping"/>").get(<xsl:value-of select="@field"/><xsl:if test="@javaType!='String'">.toString()</xsl:if>);
		}
	}
	public String get<xsl:value-of select="string:firstLetterUpper(@field)"/>Str(){
		return <xsl:value-of select="@field"/>Str;
	}
	public void set<xsl:value-of select="string:firstLetterUpper(@field)"/>Str(String <xsl:value-of select="@field"/>Str){
		this.<xsl:value-of select="@field"/>Str = <xsl:value-of select="@field"/>Str;
	}
	</xsl:if>
</xsl:for-each>
<xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">
	public List&lt;<xsl:value-of select="@m2mJoinTable" />Form&gt; get<xsl:value-of select="@m2mJoinTable" />Forms() {
		return <xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms;
	}
	
	public void set<xsl:value-of select="@m2mJoinTable" />Forms(List&lt;<xsl:value-of select="@m2mJoinTable" />Form&gt; <xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms) {
		if (<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms instanceof AutoArrayList)
			this.<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms = <xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms;
		else
			this.<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms = BeanUtils.copyAutoArrayList(<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Forms, <xsl:value-of select="@m2mJoinTable" />Form.class);
	}
</xsl:for-each>
<xsl:for-each select="column[@m2mJoinTable!='']">
	public String getKey() {
		if (getId() != null)
			return getId().toString();
		else
			return null;
	}
</xsl:for-each>
}
		</root>	
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="table">
    <root>package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.bo.gen;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;

import com.bupt.liutong.core.base.BaseBo;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.dao.gen.Gen<xsl:value-of select="@clazz" />Dao;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.dto.<xsl:value-of select="@clazz"/>;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package"/>.form.<xsl:value-of select="@clazz"/>Form;
<xsl:for-each select="column[@m2mJoinTable!='']">
// TODO import other's BO
import com.bupt.liutong.util.ListUtils;
import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.dao.gen.Gen<xsl:value-of select="@relationTable" />Dao;
import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.dto.<xsl:value-of select="@relationTable" />;
import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.form.<xsl:value-of select="@relationTable" />Form;
import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.form.<xsl:value-of select="@m2mJoinTable" />Form;
</xsl:for-each>
import com.bupt.liutong.util.BeanUtils;

public class Gen<xsl:value-of select="@clazz" />Bo extends BaseBo {

	private Gen<xsl:value-of select="@clazz" />Dao gen<xsl:value-of select="@clazz" />Dao;
	<xsl:for-each select="column[@m2mJoinTable!='']">
	private Gen<xsl:value-of select="@relationTable" />Bo gen<xsl:value-of select="@relationTable" />Bo;
	</xsl:for-each>
	
	public List&lt;<xsl:value-of select="@clazz" />Form&gt; get<xsl:value-of select="@clazz" />s(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, <xsl:value-of select="@clazz"/>.class);
		List&lt;<xsl:value-of select="@clazz" />&gt; <xsl:value-of select="string:firstLetterLower(@clazz)"/>s = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />s(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
		return BeanUtils.copyList(<xsl:value-of select="string:firstLetterLower(@clazz)"/>s, <xsl:value-of select="@clazz" />Form.class);
	}

	public List&lt;<xsl:value-of select="@clazz" />Form&gt; get<xsl:value-of select="@clazz" />sByPage(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form,
			HttpServletRequest request) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = new <xsl:value-of select="@clazz" />();
		sm.pagingWithNoCriteria(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, <xsl:value-of select="string:firstLetterLower(@clazz)"/>, gen<xsl:value-of select="@clazz" />Dao);
		List&lt;<xsl:value-of select="@clazz" />&gt; <xsl:value-of select="string:firstLetterLower(@clazz)"/>s = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />sByPage(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
		return BeanUtils.copyList(<xsl:value-of select="string:firstLetterLower(@clazz)"/>s, <xsl:value-of select="@clazz" />Form.class);
	}

	public <xsl:value-of select="@clazz" />Form get<xsl:value-of select="@clazz" />ById(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />ById(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form.getId());
		return BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>, <xsl:value-of select="@clazz"/>Form.class);
	}
	
	<xsl:for-each select="column[@m2mJoinTable!='']">
	public List&lt;<xsl:value-of select="../@clazz" />Form&gt; get<xsl:value-of select="../@clazz" />sBy<xsl:value-of select="@m2mJoinTable" /><xsl:value-of select="string:firstLetterUpper(@m2mJoinField)" />(Integer <xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" /><xsl:value-of select="string:firstLetterUpper(@m2mJoinField)" />) {
		<xsl:value-of select="@relationTable" />Form <xsl:value-of select="string:firstLetterLower(@relationTable)" />Form = new <xsl:value-of select="@relationTable" />Form();
		<xsl:value-of select="string:firstLetterLower(@relationTable)" />Form.set<xsl:value-of select="@m2mJoinTable" /><xsl:value-of select="string:firstLetterUpper(@m2mJoinField)" />(<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" /><xsl:value-of select="string:firstLetterUpper(@m2mJoinField)" />);
		return BeanUtils.copyList(gen<xsl:value-of select="@relationTable" />Bo.get<xsl:value-of select="@relationTable" />s(<xsl:value-of select="string:firstLetterLower(@relationTable)" />Form), <xsl:value-of select="../@clazz"/>Form.class, "<xsl:value-of select="string:firstLetterLower(../@clazz)" /><xsl:value-of select="string:firstLetterUpper(@field)" />", "<xsl:value-of select="@field" />");
	}
	</xsl:for-each>

	@Transactional
	public void insert<xsl:value-of select="@clazz" />(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, <xsl:value-of select="@clazz"/>.class);
		gen<xsl:value-of select="@clazz" />Dao.insert<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	@Transactional
	public void insert<xsl:value-of select="@clazz" />s(List&lt;<xsl:value-of select="@clazz" />Form&gt; <xsl:value-of select="string:firstLetterLower(@clazz)"/>Forms) {
		for (<xsl:value-of select="@clazz"/>Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form : <xsl:value-of select="string:firstLetterLower(@clazz)"/>Forms)
			this.insert<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
	}

	@Transactional
	public void update<xsl:value-of select="@clazz" />(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, <xsl:value-of select="@clazz"/>.class);
		gen<xsl:value-of select="@clazz" />Dao.update<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}
	
	<xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">
	@Transactional
	public void insert<xsl:value-of select="../@clazz" />And<xsl:value-of select="@relationTable" />(<xsl:value-of select="../@clazz" />Form <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form) {
		ListUtils.removeEmptyItem(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.get<xsl:value-of select="@m2mJoinTable" />Forms(), <xsl:value-of select="@m2mJoinTable" />Form.class);
		<xsl:value-of select="../@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(../@clazz)" /> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form, <xsl:value-of select="../@clazz" />.class);
		<xsl:value-of select="@javaType" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(../@clazz)" /><xsl:value-of select="string:firstLetterUpper(@field)" /> = gen<xsl:value-of select="../@clazz" />Dao.insert<xsl:value-of select="../@clazz" />(<xsl:value-of select="string:firstLetterLower(../@clazz)" />);
		
		List&lt;<xsl:value-of select="@relationTable" />Form&gt; <xsl:value-of select="string:firstLetterLower(@relationTable)" />Forms = BeanUtils.copyList(
			"<xsl:value-of select="string:firstLetterLower(../@clazz)" />Id", <xsl:value-of select="string:firstLetterLower(../@clazz)" /><xsl:value-of select="string:firstLetterUpper(@field)" />, "id", "<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Id", <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.get<xsl:value-of select="@m2mJoinTable" />Forms(), <xsl:value-of select="@relationTable" />Form.class);
		gen<xsl:value-of select="@relationTable" />Bo.insert<xsl:value-of select="@relationTable" />s(<xsl:value-of select="string:firstLetterLower(@relationTable)" />Forms);
	}
	
	@Transactional
	public void update<xsl:value-of select="../@clazz" />And<xsl:value-of select="@relationTable" />(<xsl:value-of select="../@clazz" />Form <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form) {
		ListUtils.removeEmptyItem(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.get<xsl:value-of select="@m2mJoinTable" />Forms(), <xsl:value-of select="@m2mJoinTable" />Form.class);
		<xsl:value-of select="../@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(../@clazz)" /> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form, <xsl:value-of select="../@clazz" />.class);
		gen<xsl:value-of select="../@clazz" />Dao.update<xsl:value-of select="../@clazz" />(<xsl:value-of select="string:firstLetterLower(../@clazz)" />);
		
		gen<xsl:value-of select="@relationTable" />Bo.delete<xsl:value-of select="@relationTable" />sBy<xsl:value-of select="../@clazz" />Id(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.getId());
		List&lt;<xsl:value-of select="@relationTable" />Form&gt; <xsl:value-of select="string:firstLetterLower(@relationTable)" />Forms = BeanUtils.copyList(
			"<xsl:value-of select="string:firstLetterLower(../@clazz)" />Id", <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.get<xsl:value-of select="string:firstLetterUpper(@field)" />(), "id", "<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)" />Id", <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.get<xsl:value-of select="@m2mJoinTable" />Forms(), <xsl:value-of select="@relationTable" />Form.class);
		gen<xsl:value-of select="@relationTable" />Bo.insert<xsl:value-of select="@relationTable" />s(<xsl:value-of select="string:firstLetterLower(@relationTable)" />Forms);
	}
	</xsl:for-each>
	
	@Transactional
	public void delete<xsl:value-of select="@clazz" />(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)" />Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)" /> = BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)" />Form, <xsl:value-of select="@clazz" />.class);
		gen<xsl:value-of select="@clazz" />Dao.delete<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)" />);
	}
	
	@Transactional
	public void delete<xsl:value-of select="@clazz" />(<xsl:value-of select="column[@isPrimary='true']/@javaType"/> id) {
		<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)" />Form = new <xsl:value-of select="@clazz" />Form();
		<xsl:value-of select="string:firstLetterLower(@clazz)" />Form.setId(id);
		this.delete<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)" />Form);
	}
	
	@Transactional
	public void delete<xsl:value-of select="@clazz" />s(String[] ids) {
		if (ids != null) {
			for (int i = 0; i &lt; ids.length; i++) {
				this.delete<xsl:value-of select="@clazz" />(<xsl:value-of select="column[@isPrimary='true']/@javaType"/>.valueOf(ids[i]));
			}
		}
	}
	
	<xsl:for-each select="column[@deleteCriteriaItem='true']">
	// TODO should add an attibute @m2mJoinFieldJavaType to replace 'Integer'
	@Transactional
	public void delete<xsl:value-of select="../@clazz" />sBy<xsl:value-of select="string:firstLetterUpper(@field)" />(Integer <xsl:value-of select="@field" />) {
		<xsl:value-of select="../@clazz" />Form <xsl:value-of select="string:firstLetterLower(../@clazz)" />Form = new <xsl:value-of select="../@clazz" />Form();
		<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.set<xsl:value-of select="string:firstLetterUpper(@field)" />(<xsl:value-of select="@field" />);
		this.delete<xsl:value-of select="../@clazz" />(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form);
	}
	</xsl:for-each>

	public void setGen<xsl:value-of select="@clazz" />Dao(Gen<xsl:value-of select="@clazz" />Dao gen<xsl:value-of select="@clazz" />Dao) {
		this.gen<xsl:value-of select="@clazz" />Dao = gen<xsl:value-of select="@clazz" />Dao;
	}
	
	<xsl:for-each select="column[@m2mJoinTable!='']">
	public void setGen<xsl:value-of select="@relationTable" />Bo(Gen<xsl:value-of select="@relationTable" />Bo gen<xsl:value-of select="@relationTable" />Bo) {
		this.gen<xsl:value-of select="@relationTable" />Bo = gen<xsl:value-of select="@relationTable" />Bo;
	}
	</xsl:for-each>
}
    </root>
  </xsl:template>
</xsl:stylesheet>
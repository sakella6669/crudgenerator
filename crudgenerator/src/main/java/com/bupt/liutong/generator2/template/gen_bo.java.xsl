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
import com.bupt.liutong.util.BeanUtils;

public class Gen<xsl:value-of select="@clazz" />Bo extends BaseBo {

	private Gen<xsl:value-of select="@clazz" />Dao gen<xsl:value-of select="@clazz" />Dao;
	
	public List&lt;<xsl:value-of select="@clazz" />Form&gt; get<xsl:value-of select="@clazz" />s(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = new <xsl:value-of select="@clazz" />();
		BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>, <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		List&lt;<xsl:value-of select="@clazz" />&gt; <xsl:value-of select="string:firstLetterLower(@clazz)"/>s = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />s(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
		return BeanUtils.dtoToForm(<xsl:value-of select="string:firstLetterLower(@clazz)"/>s, <xsl:value-of select="@clazz" />Form.class);
	}

	public List&lt;<xsl:value-of select="@clazz" />Form&gt; get<xsl:value-of select="@clazz" />sByPage(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form,
			HttpServletRequest request) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = new <xsl:value-of select="@clazz" />();
		sm.pagingWithNoCriteria(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, <xsl:value-of select="string:firstLetterLower(@clazz)"/>, "gen_<xsl:value-of select="@name" />.get<xsl:value-of select="@clazz" />sCount");
		List&lt;<xsl:value-of select="@clazz" />&gt; <xsl:value-of select="string:firstLetterLower(@clazz)"/>s = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />sByPage(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
		return BeanUtils.dtoToForm(<xsl:value-of select="string:firstLetterLower(@clazz)"/>s, <xsl:value-of select="@clazz" />Form.class);
	}

	public <xsl:value-of select="@clazz" />Form get<xsl:value-of select="@clazz" />ById(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" />Form resultForm = new <xsl:value-of select="@clazz" />Form();
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = gen<xsl:value-of select="@clazz" />Dao.get<xsl:value-of select="@clazz" />ById(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form.getId());
		BeanUtils.copyProperties(resultForm, <xsl:value-of select="string:firstLetterLower(@clazz)"/>);
		return resultForm;
	}

	@Transactional
	public void insert<xsl:value-of select="@clazz" />(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = new <xsl:value-of select="@clazz" />();
		BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>, <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		gen<xsl:value-of select="@clazz" />Dao.insert<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	@Transactional
	public void update<xsl:value-of select="@clazz" />(<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form) {
		<xsl:value-of select="@clazz" /><xsl:text> </xsl:text><xsl:value-of select="string:firstLetterLower(@clazz)"/> = new <xsl:value-of select="@clazz" />();
		BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>, <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		gen<xsl:value-of select="@clazz" />Dao.update<xsl:value-of select="@clazz" />(<xsl:value-of select="string:firstLetterLower(@clazz)"/>);
	}

	@Transactional
	public void delete<xsl:value-of select="@clazz" />s(String[] ids) {
		if (ids != null) {
			for (int i = 0; i &lt; ids.length; i++) {
				gen<xsl:value-of select="@clazz" />Dao.delete<xsl:value-of select="@clazz" />(<xsl:value-of select="column[@isPrimary='true']/@javaType"/>.valueOf(ids[i]));
			}
		}
	}

	public void setGen<xsl:value-of select="@clazz" />Dao(Gen<xsl:value-of select="@clazz" />Dao gen<xsl:value-of select="@clazz" />Dao) {
		this.gen<xsl:value-of select="@clazz" />Dao = gen<xsl:value-of select="@clazz" />Dao;
	}
}
    </root>
  </xsl:template>
</xsl:stylesheet>
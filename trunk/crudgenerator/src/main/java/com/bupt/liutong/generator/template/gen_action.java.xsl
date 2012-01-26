<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:string="xalan://com.bupt.liutong.util.StringUtils" extension-element-prefixes="string">
  <xsl:template match="table">
    <root>package <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.action.gen;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.bupt.liutong.core.base.BaseAction;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.bo.gen.Gen<xsl:value-of select="@clazz" />Bo;
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.form.<xsl:value-of select="@clazz" />Form;
<xsl:for-each select="column">
	<xsl:if test="@joinTable!=''">
	import java.util.List;
	</xsl:if>
	<xsl:if test="@joinTable!='' and @joinTable!=../@clazz">
		import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@joinPackage" />.bo.gen.Gen<xsl:value-of select="@joinTable" />Bo;
		import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@joinPackage" />.form.<xsl:value-of select="@joinTable" />Form;
	</xsl:if>
	<xsl:if test="@m2mJoinTable!='' and @m2mAutoGen='true'">
		import <xsl:value-of select="../parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@m2mJoinPackage" />.bo.gen.Gen<xsl:value-of select="@m2mJoinTable" />Bo;
	</xsl:if>
</xsl:for-each>
import com.bupt.liutong.util.BeanUtils;

public class Gen<xsl:value-of select="@clazz" />Action extends BaseAction {

	private Gen<xsl:value-of select="@clazz" />Bo gen<xsl:value-of select="@clazz" />Bo;
	<xsl:for-each select="column">
		<xsl:if test="@joinTable!='' and @joinTable!=../@clazz">
			private Gen<xsl:value-of select="@joinTable" />Bo gen<xsl:value-of select="@joinTable" />Bo;
		</xsl:if>
	</xsl:for-each>
	<xsl:for-each select="column">
		<xsl:if test="@m2mJoinTable!='' and @m2mAutoGen='true'">
			private Gen<xsl:value-of select="@m2mJoinTable" />Bo gen<xsl:value-of select="@m2mJoinTable" />Bo;
		</xsl:if>
	</xsl:for-each>

	public ActionForward get<xsl:value-of select="@clazz" />sByPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form = (<xsl:value-of select="@clazz" />Form) form;
		request.setAttribute("<xsl:value-of select="string:firstLetterLower(@clazz)" />FormList", gen<xsl:value-of select="@clazz" />Bo.get<xsl:value-of select="@clazz" />sByPage(
				<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, request));
		putPageInfo(request, <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		return mapping.findForward("get<xsl:value-of select="@clazz" />sByPageSuccess");
	}

	public ActionForward insert<xsl:value-of select="@clazz" />(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:for-each select="column[@joinTable!='']">
			List&lt;<xsl:value-of select="@joinTable"/>Form&gt; <xsl:value-of select="string:firstLetterLower(@joinTable)"/>List = gen<xsl:value-of select="@joinTable"/>Bo.get<xsl:value-of select="@joinTable"/>s(null);
			<xsl:value-of select="string:firstLetterLower(@joinTable)"/>List.add(0, new <xsl:value-of select="@joinTable"/>Form());
			request.setAttribute("<xsl:value-of select="string:firstLetterLower(@joinTable)"/>List", <xsl:value-of select="string:firstLetterLower(@joinTable)"/>List);
		</xsl:for-each>
		<xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">
			request.setAttribute("<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)"/>FormList", gen<xsl:value-of select="@m2mJoinTable"/>Bo.get<xsl:value-of select="@m2mJoinTable"/>s(null));
		</xsl:for-each>
		<xsl:for-each select="column[@itemType=50]">
			request.setAttribute("<xsl:value-of select="@field"/>List", getOptionList(ctm.get("<xsl:value-of select="@codeMapping"/>"), false));
		</xsl:for-each>
		return mapping.findForward("insert<xsl:value-of select="@clazz" />Success");
	}

	public ActionForward insert<xsl:value-of select="@clazz" />Do(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form = (<xsl:value-of select="@clazz" />Form) form;
		gen<xsl:value-of select="@clazz" />Bo.insert<xsl:value-of select="@clazz" /><xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">And<xsl:value-of select="@relationTable" /></xsl:for-each>(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		return mapping.findForward("insert<xsl:value-of select="@clazz" />DoSuccess");
	}

	public ActionForward update<xsl:value-of select="@clazz" />(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form = (<xsl:value-of select="@clazz" />Form) form;
		<xsl:for-each select="column[joinTable!='']">
			List&lt;<xsl:value-of select="@joinTable"/>Form&gt; <xsl:value-of select="string:firstLetterLower(@joinTable)"/>List = gen<xsl:value-of select="@joinTable"/>Bo.get<xsl:value-of select="@joinTable"/>s(null);
			<xsl:value-of select="string:firstLetterLower(@joinTable)"/>List.add(0, new <xsl:value-of select="@joinTable"/>Form());
			request.setAttribute("<xsl:value-of select="string:firstLetterLower(@joinTable)"/>List", <xsl:value-of select="string:firstLetterLower(@joinTable)"/>List);
		</xsl:for-each>
		<xsl:for-each select="column[@itemType=50]">
			request.setAttribute("<xsl:value-of select="@field"/>List", getOptionList(ctm.get("<xsl:value-of select="@codeMapping"/>"), false));
		</xsl:for-each>
		BeanUtils.copyProperties(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form, gen<xsl:value-of select="@clazz" />Bo.get<xsl:value-of select="@clazz" />ById(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form));
		<xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">
			request.setAttribute("<xsl:value-of select="string:firstLetterLower(@m2mJoinTable)"/>FormList", gen<xsl:value-of select="@m2mJoinTable"/>Bo.get<xsl:value-of select="@m2mJoinTable"/>s(null));
			<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.set<xsl:value-of select="@m2mJoinTable" />Forms(gen<xsl:value-of select="@m2mJoinTable" />Bo.getRolesBy<xsl:value-of select="../@clazz" />Id(<xsl:value-of select="string:firstLetterLower(../@clazz)" />Form.getId()));
		</xsl:for-each>
		return mapping.findForward("update<xsl:value-of select="@clazz" />Success");
	}

	public ActionForward update<xsl:value-of select="@clazz" />Do(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:value-of select="@clazz" />Form <xsl:value-of select="string:firstLetterLower(@clazz)"/>Form = (<xsl:value-of select="@clazz" />Form) form;
		gen<xsl:value-of select="@clazz" />Bo.update<xsl:value-of select="@clazz" /><xsl:for-each select="column[@m2mJoinTable!='' and @m2mAutoGen='true']">And<xsl:value-of select="@relationTable" /></xsl:for-each>(<xsl:value-of select="string:firstLetterLower(@clazz)"/>Form);
		return mapping.findForward("update<xsl:value-of select="@clazz" />DoSuccess");
	}

	public ActionForward delete<xsl:value-of select="@clazz" />s(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("id");
		gen<xsl:value-of select="@clazz" />Bo.delete<xsl:value-of select="@clazz" />s(ids);
		return mapping.findForward("delete<xsl:value-of select="@clazz" />sSuccess");
	}

	public void setGen<xsl:value-of select="@clazz" />Bo(Gen<xsl:value-of select="@clazz" />Bo gen<xsl:value-of select="@clazz" />Bo) {
		this.gen<xsl:value-of select="@clazz" />Bo = gen<xsl:value-of select="@clazz" />Bo;
	}
	
	<xsl:for-each select="column">
		<xsl:if test="@joinTable!='' and @joinTable!=../@clazz">
			public void setGen<xsl:value-of select="@joinTable" />Bo(Gen<xsl:value-of select="@joinTable" />Bo gen<xsl:value-of select="@joinTable" />Bo) {
				this.gen<xsl:value-of select="@joinTable" />Bo = gen<xsl:value-of select="@joinTable" />Bo;
			}
		</xsl:if>
		<xsl:if test="@m2mJoinTable!='' and @m2mAutoGen='true'">
			public void setGen<xsl:value-of select="@m2mJoinTable" />Bo(Gen<xsl:value-of select="@m2mJoinTable" />Bo gen<xsl:value-of select="@m2mJoinTable" />Bo) {
				this.gen<xsl:value-of select="@m2mJoinTable" />Bo = gen<xsl:value-of select="@m2mJoinTable" />Bo;
			}
		</xsl:if>
	</xsl:for-each>
}
</root>
  </xsl:template>
</xsl:stylesheet>
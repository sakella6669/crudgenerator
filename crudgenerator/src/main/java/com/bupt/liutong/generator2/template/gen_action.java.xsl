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
import <xsl:value-of select="parameters/parameter[@id='basePackage']/@value"/>.<xsl:value-of select="@package" />.form.gen.Gen<xsl:value-of select="@clazz" />Form;
import com.bupt.liutong.util.BeanUtils;

public class Gen<xsl:value-of select="@clazz" />Action extends BaseAction {

	private Gen<xsl:value-of select="@clazz" />Bo gen<xsl:value-of select="@clazz" />Bo;

	public ActionForward get<xsl:value-of select="@clazz" />sByPage(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		Gen<xsl:value-of select="@clazz" />Form gen<xsl:value-of select="@clazz" />Form = (Gen<xsl:value-of select="@clazz" />Form) form;
		request.setAttribute("<xsl:value-of select="string:firstLetterLower(@clazz)" />FormList", gen<xsl:value-of select="@clazz" />Bo.get<xsl:value-of select="@clazz" />sByPage(
				gen<xsl:value-of select="@clazz" />Form, request));
		putPageInfo(request, gen<xsl:value-of select="@clazz" />Form);
		return mapping.findForward("get<xsl:value-of select="@clazz" />sByPageSuccess");
	}

	public ActionForward insert<xsl:value-of select="@clazz" />(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:for-each select="column[@itemType=50]">
		request.setAttribute("<xsl:value-of select="@field"/>List", getOptionList(ctm.get("<xsl:value-of select="@codeMapping"/>"), false));
		</xsl:for-each>
		return mapping.findForward("insert<xsl:value-of select="@clazz" />Success");
	}

	public ActionForward insert<xsl:value-of select="@clazz" />Do(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		Gen<xsl:value-of select="@clazz" />Form gen<xsl:value-of select="@clazz" />Form = (Gen<xsl:value-of select="@clazz" />Form) form;
		gen<xsl:value-of select="@clazz" />Bo.insert<xsl:value-of select="@clazz" />(gen<xsl:value-of select="@clazz" />Form);
		return mapping.findForward("insert<xsl:value-of select="@clazz" />DoSuccess");
	}

	public ActionForward update<xsl:value-of select="@clazz" />(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		<xsl:for-each select="column[@itemType=50]">
		request.setAttribute("<xsl:value-of select="@field"/>List", getOptionList(ctm.get("<xsl:value-of select="@codeMapping"/>"), false));
		</xsl:for-each>
		Gen<xsl:value-of select="@clazz" />Form gen<xsl:value-of select="@clazz" />Form = (Gen<xsl:value-of select="@clazz" />Form) form;
		BeanUtils.copyProperties(gen<xsl:value-of select="@clazz" />Form, gen<xsl:value-of select="@clazz" />Bo.get<xsl:value-of select="@clazz" />ById(gen<xsl:value-of select="@clazz" />Form));
		return mapping.findForward("update<xsl:value-of select="@clazz" />Success");
	}

	public ActionForward update<xsl:value-of select="@clazz" />Do(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		Gen<xsl:value-of select="@clazz" />Form gen<xsl:value-of select="@clazz" />Form = (Gen<xsl:value-of select="@clazz" />Form) form;
		gen<xsl:value-of select="@clazz" />Bo.update<xsl:value-of select="@clazz" />(gen<xsl:value-of select="@clazz" />Form);
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
}
</root>
  </xsl:template>
</xsl:stylesheet>
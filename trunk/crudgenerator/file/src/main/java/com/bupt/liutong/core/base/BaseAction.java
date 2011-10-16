package com.bupt.liutong.core.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.LabelValueBean;

public abstract class BaseAction extends DispatchAction {
	
	protected CodeTableManager ctm;
	
	protected void putPageInfo(HttpServletRequest request, BaseForm baseForm){
		String actionPath = request.getServletPath()+"?method="+request.getParameter("method");
		request.setAttribute("actionPath", actionPath);
		request.setAttribute("totalPage", baseForm.getTotalPage());
		request.setAttribute("totalRow", baseForm.getTotalRow());
		request.setAttribute("curPage", baseForm.getCurPage());
		request.setAttribute("pageSize", baseForm.getPageSize());
	}
	
	protected List<LabelValueBean> getOptionList(Map<String, String> map, boolean haveEmpty){
		List<LabelValueBean> list = new ArrayList<LabelValueBean>();
		if(haveEmpty){
			list.add(new LabelValueBean("", Constants.EMPTY_OPTION_LABEL));
		}
		
		for (Map.Entry<String, String> entry : map.entrySet()) {
			list.add(new LabelValueBean(entry.getKey().toString(), entry.getValue()));
		}
		
		return list;
	}

	public void setCtm(CodeTableManager ctm) {
		this.ctm = ctm;
	}
}

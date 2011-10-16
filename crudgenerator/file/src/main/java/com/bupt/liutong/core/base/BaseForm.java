package com.bupt.liutong.core.base;

import org.apache.struts.action.ActionForm;

import com.bupt.liutong.core.base.CodeTableManager;

import static com.bupt.liutong.core.base.Constants.*;

public abstract class BaseForm extends ActionForm {

	/** 每页的记录数 */
	private int pageSize = 15;

	/** 总页数 */
	private int totalPage = 1;

	/** 总记录数 */
	private int totalRow = 0;

	/** 当前的页数 */
	private int curPage = 1;

	private String searchFlag = OLD_SEARCH_FLAG;

	protected static CodeTableManager ctm = new CodeTableManager();

	public void setCtm(CodeTableManager ctm) {
		this.ctm = ctm;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
		setTotalPage((totalRow - 1) / pageSize + 1);
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		setTotalPage((totalRow - 1) / pageSize + 1);
	}

	public String getSearchFlag() {
		return searchFlag;
	}

	public void setSearchFlag(String searchFlag) {
		this.searchFlag = searchFlag;
	}
	
	public int getStartRow(){
		return (curPage - 1) * pageSize;
	}
}

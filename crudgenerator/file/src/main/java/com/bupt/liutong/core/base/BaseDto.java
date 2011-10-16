package com.bupt.liutong.core.base;

public abstract class BaseDto {
	/** 每页的记录数 */
    private int pageSize = 15;

    /** 总页数 */
    private int totalPage = 1;

    /** 总记录数 */
    private int totalRow = 0;

    /** 当前的页数 */
    private int curPage = 1;
    
    private Integer startRow;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
		setTotalPage(totalRow / pageSize + 1);
	}

	public int getTotalPage() {
		return totalPage;
	}

	private void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
		setTotalPage(totalRow / pageSize + 1);
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	
	public Integer getStartRow() {
		if (startRow == null)
			return (curPage - 1) * pageSize;
		else
			return startRow;
	}

	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}
}

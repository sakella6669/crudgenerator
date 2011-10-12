package com.bupt.liutong.core.base;

public abstract class BaseBo {

	protected SessionManager sm;
	protected CodeTableManager ctm;

	public void setSm(SessionManager sm) {
		this.sm = sm;
	}

	public void setCtm(CodeTableManager ctm) {
		this.ctm = ctm;
	}

	// private Ibatis ibatis;

	// protected void startBatch() throws SQLException{
	// ibatis.startBatch();
	// }
	//	
	// protected void executeBatch() throws SQLException{
	// ibatis.executeBatch();
	// }

	// public void setIbatis(Ibatis ibatis) {
	// this.ibatis = ibatis;
	// }
}

package com.bupt.liutong.core.base;

import java.sql.SQLException;
import java.util.List;

public interface Ibatis {

	public List<?> queryForList(String sqlMapId);
	
	public List<?> queryForList(String sqlMapId, Object parameter);

	public List<?> queryForPage(String sqlMapId, BaseDto baseDto);

//	public List<?> queryForPage(String sqlMapId, Object parameter, int startRow, int pageSize);

	public Object queryForObject(String sqlMapId, Object parameter);

	public int queryForInt(String sqlMapId, Object parameter);

	public Object insert(String sqlMapId, Object parameter);

	public int update(String sqlMapId, Object parameter);

	public int delete(String sqlMapId, Object parameter);

	public void startTransaction() throws SQLException;

	public void commitTransaction() throws SQLException;

	public void endTransaction();

	public void startBatch() throws SQLException;
	
	public void executeBatch() throws SQLException;
}

package com.bupt.liutong.core.base;

import java.sql.SQLException;
import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class SqlMapClientDao extends SqlMapClientDaoSupport implements Ibatis {

	
	public List<?> queryForList(String sqlMapId, Object parameter) {
		List<?> list = getSqlMapClientTemplate().queryForList(sqlMapId,
				parameter);
		return list;
	}

//	
//	public List<?> queryForPage(String sqlMapId, Object parameter, int startRow, int pageSize) {
//		List<?> list = getSqlMapClientTemplate().queryForList(sqlMapId, parameter, startRow, pageSize);
//		return list;
//	}

	
	public List<?> queryForPage(String sqlMapId, BaseDto baseDto) {
		List<?> list = getSqlMapClientTemplate().queryForList(sqlMapId,
				baseDto, baseDto.getStartRow(), baseDto.getPageSize());
		return list;
	}

	
	public List<?> queryForList(String sqlMapId) {
		List<?> list = getSqlMapClientTemplate().queryForList(sqlMapId);
		return list;
	}

	
	public Object queryForObject(String sqlMapId, Object parameter) {
		return getSqlMapClientTemplate().queryForObject(sqlMapId, parameter);
	}

	
	public int queryForInt(String sqlMapId, Object parameter) {
		return (Integer) getSqlMapClientTemplate().queryForObject(sqlMapId,
				parameter);
	}

	
	public Object insert(String sqlMapId, Object parameter){
		return getSqlMapClientTemplate().insert(sqlMapId, parameter);
	}

	
	public int update(String sqlMapId, Object parameter){
		return getSqlMapClientTemplate().update(sqlMapId, parameter);
	}

	
	public int delete(String sqlMapId, Object parameter){
		return getSqlMapClientTemplate().delete(sqlMapId, parameter);
	}

	
	public void startTransaction() throws SQLException {
		getSqlMapClient().startTransaction();
	}

	
	public void commitTransaction() throws SQLException {
		getSqlMapClient().commitTransaction();
	}

	
	public void endTransaction() {
		try {
			getSqlMapClient().endTransaction();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	public void startBatch() throws SQLException {
		getSqlMapClient().startBatch();
	}

	
	public void executeBatch() throws SQLException {
		getSqlMapClient().executeBatch();
	}
}

package com.bupt.liutong.core.dao;

import java.util.List;

import com.bupt.liutong.core.base.BaseDto;
import com.bupt.liutong.core.base.Ibatis;

public class CommonDao {
	
	private Ibatis ibatis;
	
	public int getListCount(String sqlMapId, BaseDto baseDto) {
		return ibatis.queryForInt(sqlMapId, baseDto);
	}
	
	public int getListCount(String sql) {
		return ibatis.queryForInt("common.getCount", sql);
	}
	
	public List<?> getList(String sqlMapId){
		return ibatis.queryForList(sqlMapId);
	}
	
	public List<?> getList(String sqlMapId, Object parameter){
		return ibatis.queryForList(sqlMapId, parameter);
	}
	
	public List<?> getListByPage(String sqlMapId, BaseDto baseDto){
		return ibatis.queryForPage(sqlMapId, baseDto);
	}

	public void setIbatis(Ibatis ibatis) {
		this.ibatis = ibatis;
	}
}

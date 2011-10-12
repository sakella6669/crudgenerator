package com.bupt.liutong.generator.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GenerateConfig {
	private String driverClass;
	private String connectionURL;
	private String userId;
	private String password;
	private List<Template> templateList;
	private List<Table> tableList;
	private Map<String, String> parameterMap;
	
	public void copyJdbcConnection(JdbcConnection jdbcConnection){
		driverClass = jdbcConnection.getDriverClass();
		connectionURL = jdbcConnection.getConnectionURL();
		userId = jdbcConnection.getUserId();
		password = jdbcConnection.getPassword();
	}
	
	public void addTemplate(Template template){
		if (templateList == null) {
			templateList = new ArrayList<Template>();
		}
		templateList.add(template);
	}
	
	public void addTable(Table table){
		if (tableList == null) {
			tableList = new ArrayList<Table>();
		}
		tableList.add(table);
	}
	
	public void addParameter(Parameter parameter){
		if (parameterMap == null) {
			parameterMap = new HashMap<String, String>();
		}
		parameterMap.put(parameter.getId(), parameter.getValue());
	}
	
	public String getDriverClass() {
		return driverClass;
	}
	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}
	public String getConnectionURL() {
		return connectionURL;
	}
	public void setConnectionURL(String connectionURL) {
		this.connectionURL = connectionURL;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public List<Template> getTemplateList() {
		return templateList;
	}
	public void setTemplateList(List<Template> templateList) {
		this.templateList = templateList;
	}
	public List<Table> getTableList() {
		return tableList;
	}
	public void setTableList(List<Table> tableList) {
		this.tableList = tableList;
	}

	public Map<String, String> getParameterMap() {
		return parameterMap;
	}

	public void setParameterMap(Map<String, String> parameterMap) {
		this.parameterMap = parameterMap;
	}
}

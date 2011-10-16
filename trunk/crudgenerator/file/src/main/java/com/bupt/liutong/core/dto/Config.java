package com.bupt.liutong.core.dto;

public class Config {
	private Integer id;
	private String code;
	private String value;

	public Config() {
	}
	
	public Config(String code, String value){
		this.code = code;
		this.value = value;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}

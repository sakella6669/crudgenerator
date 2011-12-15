package com.bupt.liutong.generator.config;

public class Template {
	private String templateName;
	private String targetName;
	private String templatePackage;
	private String targetPackage;
	private String targetProject;
	
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getTargetName() {
		return targetName;
	}
	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
	public String getTemplatePackage() {
		return templatePackage;
	}
	public void setTemplatePackage(String templatePackage) {
		this.templatePackage = templatePackage;
	}
	public String getTargetPackage() {
		return targetPackage;
	}
	public void setTargetPackage(String targetPackage) {
		this.targetPackage = targetPackage;
	}
	public String getTargetProject() {
		return targetProject;
	}
	public void setTargetProject(String targetProject) {
		this.targetProject = targetProject;
	}
}

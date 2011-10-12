package com.bupt.liutong.core.dto;

import java.util.ArrayList;
import java.util.List;

public class CodeTableMapping {
	private String id;
	private List<CodeTableNode> nodeList;
	
	public void addNode(CodeTableNode node){
		if (nodeList == null) {
			nodeList = new ArrayList<CodeTableNode>();
		}
		nodeList.add(node);
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public List<CodeTableNode> getNodeList(){
		return nodeList;
	}
}

package com.bupt.liutong.core.dto;

import java.util.ArrayList;
import java.util.List;

public class CodeTableConfig {
	private List<CodeTableMapping> mappingList;

	public void addMapping(CodeTableMapping mapping) {
		if (mappingList == null) {
			mappingList = new ArrayList<CodeTableMapping>();
		}
		mappingList.add(mapping);
	}
	
	public List<CodeTableMapping> getMappingList(){
		return mappingList;
	}
}

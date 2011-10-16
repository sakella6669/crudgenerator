package com.bupt.liutong.core.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bupt.liutong.core.dto.CodeTableConfig;
import com.bupt.liutong.core.dto.CodeTableMapping;
import com.bupt.liutong.core.dto.CodeTableNode;
import com.bupt.liutong.core.dto.CodeTableParser;
import com.bupt.liutong.util.FileUtils;

public class CodeTableManager {
//	
//	static {
//		org.apache.log4j.Logger.getLogger("infolog").info("infolog_testinfo");
//		org.apache.log4j.Logger.getLogger("infolog").debug("infolog_testdebug");
//		org.apache.log4j.Logger.getLogger("infolog").error("infolog_testwarn");
//	}
	
	private Map<String, Map<String, String>> mappings;
	
	public CodeTableManager(){
		mappings = new HashMap<String, Map<String, String>>();
		final CodeTableConfig codeTableConfig = CodeTableParser.loadConfig(FileUtils.getProjectPath()+"core/code_table/code_table.xml");
		
		List<CodeTableMapping> mappingList = codeTableConfig.getMappingList();
		for(CodeTableMapping mapping:mappingList) {
			Map<String, String> nodes = new HashMap<String, String>();
			List<CodeTableNode> nodeList = mapping.getNodeList();
			for (CodeTableNode node : nodeList) {
				nodes.put(node.getKey(), node.getValue());
			}
			mappings.put(mapping.getId(), nodes);
		}
	}
	
//	private void loadProdAttr(){
//		// TODO
//	}
	
	public Map<String, String> get(String mappingId){
		return mappings.get(mappingId);
	}
}

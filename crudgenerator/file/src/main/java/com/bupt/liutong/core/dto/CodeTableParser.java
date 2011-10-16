package com.bupt.liutong.core.dto;

import java.io.File;
import java.io.IOException;

import org.apache.commons.digester.Digester;
import org.xml.sax.SAXException;

public class CodeTableParser {
	
	public static CodeTableConfig loadConfig(String configPath) {
		Digester digester = new Digester();
		digester.setValidating(false);
		digester.push(new CodeTableConfig());

		// CodeTable
		digester.addObjectCreate("mappings/mapping", CodeTableMapping.class);
		digester.addSetProperties("mappings/mapping");
		digester.addSetNext("mappings/mapping", "addMapping");
		
		digester.addObjectCreate("mappings/mapping/node", CodeTableNode.class);
		digester.addSetProperties("mappings/mapping/node");
		digester.addSetNext("mappings/mapping/node", "addNode");
		
		try {
			return (CodeTableConfig) digester.parse(new File(configPath));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		}
		return null;
	}
}

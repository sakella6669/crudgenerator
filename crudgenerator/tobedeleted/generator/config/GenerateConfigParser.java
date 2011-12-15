package com.bupt.liutong.generator.config;

import java.io.File;
import java.io.IOException;

import org.apache.commons.digester.Digester;
import org.xml.sax.SAXException;

public class GenerateConfigParser {

	public static GenerateConfig loadConfig(String configPath) throws IOException, SAXException {
		Digester digester = new Digester();
		digester.setValidating(false);
		digester.push(new GenerateConfig());

		// jdbcConnection
		digester.addObjectCreate("generateConfiguration/jdbcConnection",
				JdbcConnection.class);
		digester.addSetProperties("generateConfiguration/jdbcConnection");
		digester.addSetNext("generateConfiguration/jdbcConnection", "copyJdbcConnection");
		
		// templateGenerator
		digester.addObjectCreate("generateConfiguration/templateGenerator/template",
				Template.class);
		digester.addSetProperties("generateConfiguration/templateGenerator/template");
		digester.addSetNext("generateConfiguration/templateGenerator/template", "addTemplate");
		
		// table
		digester.addObjectCreate("generateConfiguration/table",
				Table.class);
		digester.addSetProperties("generateConfiguration/table");
		digester.addSetNext("generateConfiguration/table", "addTable");
		
		// initParameters
		digester.addObjectCreate("generateConfiguration/initParameters/parameter",
				Parameter.class);
		digester.addSetProperties("generateConfiguration/initParameters/parameter");
		digester.addSetNext("generateConfiguration/initParameters/parameter", "addParameter");
		
		return (GenerateConfig) digester.parse(new File(configPath));
	}
}

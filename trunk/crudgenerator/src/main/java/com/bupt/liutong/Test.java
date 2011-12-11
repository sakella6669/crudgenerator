package com.bupt.liutong;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.xml.sax.SAXException;

public class Test {

	private static final String BASE_PATH = System.getProperty("user.dir");// ClassLoader.getSystemClassLoader().getResource("").toString();

	public static void main(String[] args) throws SAXException,
			ParserConfigurationException, IOException, DocumentException {
		SAXParserFactory configFactory = SAXParserFactory.newInstance();
		configFactory.setValidating(true);
		SAXParser configParser = configFactory.newSAXParser();
		configParser.setProperty("http://java.sun.com/xml/jaxp/properties/schemaLanguage", 
			      "http://www.w3.org/2001/XMLSchema");
		SAXReader configReader = new SAXReader(configParser.getXMLReader());
		Map<String, String> configSchema = new HashMap<String, String>();
		configSchema.put("yaoming","http://www.w3school.com.cn");
		configReader.getDocumentFactory().setXPathNamespaceURIs(configSchema);
		Document config = configReader.read(BASE_PATH
				+ "/src/main/java/com/bupt/liutong/generator2/config/".replace("/",
						File.separator) + "config.xml");
		/**
		 * 
		 */
		SAXParserFactory modelFactory = SAXParserFactory.newInstance();
		modelFactory.setValidating(true);
		SAXParser modelParser = modelFactory.newSAXParser();
		modelParser.setProperty("http://java.sun.com/xml/jaxp/properties/schemaLanguage", 
			      "http://www.w3.org/2001/XMLSchema");
		SAXReader modelReader = new SAXReader(modelParser.getXMLReader());
		Map<String, String> modelSchema = new HashMap<String, String>();
		modelSchema.put("m","http://www.w3school.com.cn");
		modelReader.getDocumentFactory().setXPathNamespaceURIs(modelSchema);
		Document model = modelReader.read(BASE_PATH
				+ "/src/main/java/com/bupt/liutong/generator2/config/".replace("/",
						File.separator) + "model.xml");
		Element modelRoot = model.getRootElement();
		/**
		 * 
		 */
		
		
//		System.out.println(config.getRootElement().selectSingleNode(
//				"/*[local-name()='config' and namespace-uri()='http://www.w3school.com.cn']/*[local-name()='db' and namespace-uri()='http://www.w3school.com.cn']"));
		String targetPrj = config.getRootElement().selectSingleNode(
				"//config:config/config:templates/config:template[@path='src/main/java/com/bupt/liutong/generator2/template/dto.java.xsl']").valueOf(
				"@override");
		System.out.println(targetPrj);
	}

}

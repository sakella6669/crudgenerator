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
import org.dom4j.io.SAXReader;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

public class Test {

	private static final String BASE_PATH = System.getProperty("user.dir");// ClassLoader.getSystemClassLoader().getResource("").toString();

	public static void main(String[] args) throws SAXException,
			ParserConfigurationException, IOException, DocumentException {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		factory.setValidating(true);

		SAXParser parser = factory.newSAXParser();
		parser.setProperty("http://java.sun.com/xml/jaxp/properties/schemaLanguage", 
		      "http://www.w3.org/2001/XMLSchema");

		SAXReader reader = new SAXReader(parser.getXMLReader());
		Map<String, String> map = new HashMap<String, String>();
	    map.put("config","http://www.w3school.com.cn");
		reader.getDocumentFactory().setXPathNamespaceURIs(map);
		// reader.setErrorHandler(new SimpleErrorHandler());
		Document config = reader.read(BASE_PATH
				+ "/src/main/java/com/bupt/liutong/generator2/config/".replace(
						"/", File.separator) + "config.xml");
//		System.out.println(config.getRootElement().selectSingleNode(
//				"/*[local-name()='config' and namespace-uri()='http://www.w3school.com.cn']/*[local-name()='db' and namespace-uri()='http://www.w3school.com.cn']"));
		String targetPrj = config.getRootElement().selectSingleNode(
				"//config:config/config:parameters/config:parameter[@id='targetPrj']").valueOf(
				"@value");
	}

}

package com.bupt.liutong.generator2.setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;

import com.bupt.liutong.util.StringUtils;

public class ColumnLengthSetter implements DefaultValueSetter {

	private static Map<String, String> defaultLength = new HashMap<String, String>();
	
	static {
		defaultLength.put("char", "30");
		defaultLength.put("varchar", "30");
		defaultLength.put("tinyint", "1");	// max 4
		defaultLength.put("smallint", "6");
		defaultLength.put("mediumint", "9");
		defaultLength.put("int", "11");
		defaultLength.put("bigint", "20");
	}
	
	public Element setDefaultValue(Element rootElement) {
		@SuppressWarnings("unchecked")
		List<Element> packages = rootElement.elements();
		for(Element pkg : packages){
			@SuppressWarnings("unchecked")
			List<Element> tables = pkg.elements();
			for (Element table : tables) {
				@SuppressWarnings("unchecked")
				List<Element> columns = table.elements();
				for (Element column : columns) {
					if (column.getName().equals("column")) {
						String dbType = column.attributeValue("dbType");
						if (StringUtils.isEmpty(dbType))
							throw new NullPointerException("column dbType should not be null");
						if (StringUtils.isEmpty(column.attributeValue("length"))) {
							if (defaultLength.containsKey(dbType))
								column.addAttribute("length", defaultLength.get(dbType));
						}
					}
				}
			}
		}
		return rootElement;
	}
	
}

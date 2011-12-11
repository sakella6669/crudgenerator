package com.bupt.liutong.generator2.setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;

import com.bupt.liutong.util.StringUtils;

public class ColumnDbTypeSetter implements DefaultValueSetter {

	private static Map<String, String> defaultDbType = new HashMap<String, String>();
	
	static {
		defaultDbType.put("String", "varchar");
		defaultDbType.put("Date", "date");
		defaultDbType.put("Integer", "int");
		defaultDbType.put("Long", "bigint");
		defaultDbType.put("BigInteger", "bigint");
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
						String javaType = column.attributeValue("javaType");
						if (StringUtils.isEmpty(javaType))
							throw new NullPointerException("column javaType should not be null");
						if (StringUtils.isEmpty(column.attributeValue("dbType"))) {
							if (defaultDbType.containsKey(javaType))
								column.addAttribute("dbType", defaultDbType.get(javaType));
						}
					}
				}
			}
		}
		return rootElement;
	}
	
}

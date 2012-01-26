package com.bupt.liutong.generator2.setter;

import java.util.List;

import org.dom4j.Element;

import com.bupt.liutong.util.StringUtils;

public class TableNameSetter implements DefaultValueSetter {

	public Element setDefaultValue(Element rootElement) {
		@SuppressWarnings("unchecked")
		List<Element> packages = rootElement.elements();
		for(Element pkg : packages){
			String pkgName = pkg.attributeValue("name");
			if (StringUtils.isEmpty(pkgName))
				throw new NullPointerException("pakcage name should not be null");
			@SuppressWarnings("unchecked")
			List<Element> tables = pkg.elements();
			for (Element table : tables) {
				String clazz = table.attributeValue("clazz");
				if (StringUtils.isEmpty(clazz))
					throw new NullPointerException("table clazz should not be null");
				if (StringUtils.isEmpty(table.attributeValue("name")))
					table.addAttribute("name", transformTableName(pkgName, clazz));
			}
		}
		return rootElement;
	}

	private String transformTableName(String pkgName, String clazz) {
		StringBuilder sb = new StringBuilder(pkgName);
		char[] arr = clazz.toCharArray();
		for (char c : arr) {
			if(StringUtils.isUpperLetter(c))
				sb.append("_" + String.valueOf(c).toLowerCase());
			else
				sb.append(c);
		}
		return sb.toString();
	}
}

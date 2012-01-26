package com.bupt.liutong.generator.setter;

import java.util.List;

import org.dom4j.Element;

import com.bupt.liutong.util.StringUtils;

public class JoinSetter implements DefaultValueSetter {

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
						if (!StringUtils.isEmpty(column.attributeValue("joinTable")) 
								&& StringUtils.isEmpty(column.attributeValue("joinPackage"))) {
							column.addAttribute("joinPackage", pkg.attributeValue("name"));
						}
					}
				}
			}
		}
		return rootElement;
	}
}

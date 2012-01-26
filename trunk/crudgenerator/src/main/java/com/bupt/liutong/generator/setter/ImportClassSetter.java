package com.bupt.liutong.generator2.setter;

import java.util.List;

import org.dom4j.Element;
import org.dom4j.tree.DefaultAttribute;
import org.dom4j.tree.DefaultElement;

import com.bupt.liutong.util.StringUtils;

public class ImportClassSetter implements DefaultValueSetter {

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
							throw new NullPointerException("column field should not be null");
						if (javaType.equals("Date") && null == table.selectSingleNode("import[@clazz='java.util.Date']")) {
							DefaultElement importDate = new DefaultElement("import");
							DefaultElement importDateUtils = new DefaultElement("import");
							DefaultAttribute clazzDate = new DefaultAttribute("clazz", "java.util.Date");
							DefaultAttribute clazzDateUtils = new DefaultAttribute("clazz", "com.bupt.liutong.util.DateUtils");
							importDate.add(clazzDate);
							importDateUtils.add(clazzDateUtils);
							table.add(importDate);
							table.add(importDateUtils);
						}
					}
				}
			}
		}
		return rootElement;
	}

}

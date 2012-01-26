package com.bupt.liutong.generator.setter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;
import org.dom4j.tree.DefaultAttribute;
import org.dom4j.tree.DefaultElement;

import com.bupt.liutong.util.StringUtils;

public class M2MSetter implements DefaultValueSetter {

	private Map<String, List<Map<String, String>>> m2mRelation;
	
	public M2MSetter() {
		m2mRelation = new HashMap<String, List<Map<String, String>>>();
	}
	
	public Element setDefaultValue(Element rootElement) {

		this.loadM2MRelation(rootElement);
		
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
						String m2mJoinTable = column.attributeValue("m2mJoinTable");
						String m2mAutoGen = column.attributeValue("m2mAutoGen");
						if (!StringUtils.isEmpty(m2mJoinTable) && "true".equals(m2mAutoGen)) {
							String m2mJoinPackage = column.attributeValue("m2mJoinPackage");
							// if m2mJoinPackage empty, then m2mJoinPackage is set to current package
							if (StringUtils.isEmpty(m2mJoinPackage))
								column.addAttribute("m2mJoinPackage", pkg.attributeValue("name"));
							
							// 
							DefaultAttribute relationTableAttr = new DefaultAttribute("relationTable", table.attributeValue("clazz") + column.attributeValue("m2mJoinTable"));
							column.add(relationTableAttr);
							
							// add to relation table, ex. user_role, student_course
							DefaultElement relationTable = new DefaultElement("table");
							// ex. UserRole
							String tableClazzStr = table.attributeValue("clazz") + column.attributeValue("m2mJoinTable");
							DefaultAttribute tableClazz = new DefaultAttribute("clazz", tableClazzStr);
							relationTable.add(tableClazz);
							
							DefaultElement id = new DefaultElement("column");
							// ex. id
							DefaultAttribute idField = new DefaultAttribute("field", "id");
							// ex. id
							DefaultAttribute idChs = new DefaultAttribute("chs", "id");
							DefaultAttribute idJavaType = new DefaultAttribute("javaType", "Long");
							DefaultAttribute idIsPrimary = new DefaultAttribute("isPrimary", "true");
							DefaultAttribute idAutoIncrement = new DefaultAttribute("autoIncrement", "true");
							DefaultAttribute idInputItem = new DefaultAttribute("inputItem", "false");
							DefaultAttribute idItemType = new DefaultAttribute("itemType", "10");
							id.add(idField);
							id.add(idChs);
							id.add(idJavaType);
							id.add(idIsPrimary);
							id.add(idAutoIncrement);
							id.add(idInputItem);
							id.add(idItemType);
							
							DefaultElement joinId1 = new DefaultElement("column");
							// ex. user
							String firstLetterLowerClazz = StringUtils.firstLetterLower(table.attributeValue("clazz"));
							// ex. Id
							String firstLetterUpperField = StringUtils.firstLetterUpper(column.attributeValue("field"));
							// ex. userId
							DefaultAttribute joinId1Field = new DefaultAttribute("field", firstLetterLowerClazz + firstLetterUpperField);
							DefaultAttribute joinId1Chs = new DefaultAttribute("chs", column.attributeValue("chs"));
							DefaultAttribute joinId1JavaType = new DefaultAttribute("javaType", column.attributeValue("javaType"));
							DefaultAttribute joinId1QueryItem = new DefaultAttribute("queryItem", "true");
							DefaultAttribute joinId1DeleteCriteriaItem = new DefaultAttribute("deleteCriteriaItem", "true");
							DefaultAttribute joinId1ItemType = new DefaultAttribute("itemType", "10");
							DefaultAttribute joinId1InputItem = new DefaultAttribute("inputItem", "true");
							joinId1.add(joinId1Field);
							joinId1.add(joinId1Chs);
							joinId1.add(joinId1JavaType);
							joinId1.add(joinId1QueryItem);
							joinId1.add(joinId1DeleteCriteriaItem);
							joinId1.add(joinId1ItemType);
							joinId1.add(joinId1InputItem);

							DefaultElement joinId2 = new DefaultElement("column");
							// ex. role
							firstLetterLowerClazz = StringUtils.firstLetterLower(column.attributeValue("m2mJoinTable"));
							// ex. Id
							firstLetterUpperField = StringUtils.firstLetterUpper(column.attributeValue("m2mJoinField"));
							// ex. roleId
							DefaultAttribute joinId2Field = new DefaultAttribute("field", firstLetterLowerClazz + firstLetterUpperField);
							// TODO can't get 'roleId(Integer)' which is m2mJoinField's label & javaType
							DefaultAttribute joinId2Chs = new DefaultAttribute("chs", column.attributeValue("m2mJoinTable") + column.attributeValue("m2mJoinField"));
							DefaultAttribute joinId2JavaType = new DefaultAttribute("javaType", "Integer");
							DefaultAttribute joinId2QueryItem = new DefaultAttribute("queryItem", "true");
							DefaultAttribute joinId2DeleteCriteriaItem = new DefaultAttribute("deleteCriteriaItem", "true");
							DefaultAttribute joinId2ItemType = new DefaultAttribute("itemType", "10");
							DefaultAttribute joinId2InputItem = new DefaultAttribute("inputItem", "true");
							joinId2.add(joinId2Field);
							joinId2.add(joinId2Chs);
							joinId2.add(joinId2JavaType);
							joinId2.add(joinId2QueryItem);
							joinId2.add(joinId2DeleteCriteriaItem);
							joinId2.add(joinId2ItemType);
							joinId2.add(joinId2InputItem);
							
							relationTable.add(id);
							relationTable.add(joinId1);
							relationTable.add(joinId2);
							
							pkg.add(relationTable);
						}
					}
				}
			}
		}
		
		this.fillM2MRelation(rootElement);
		
		return rootElement;
	}

	private void loadM2MRelation(Element rootElement) {
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
						String m2mJoinTable = column.attributeValue("m2mJoinTable");
						if (!StringUtils.isEmpty(m2mJoinTable)) {
							String m2mJoinPackage = column.attributeValue("m2mJoinPackage");
							if(StringUtils.isEmpty(m2mJoinPackage))
								m2mJoinPackage = pkg.attributeValue("name");
							Map<String, String> relation = new HashMap<String, String>();
							relation.put("package.name", m2mJoinPackage);
							relation.put("clazz", m2mJoinTable);
							relation.put("field", column.attributeValue("m2mJoinField"));
							relation.put("m2mJoinPackage", pkg.attributeValue("name"));
							relation.put("m2mJoinTable", table.attributeValue("clazz"));
							relation.put("m2mJoinField", column.attributeValue("field"));
							
							String pkgAndClazzAndField = m2mJoinPackage + "." + m2mJoinTable + "." + column.attributeValue("m2mJoinField");
							if (!m2mRelation.containsKey(pkgAndClazzAndField)) {
								List<Map<String, String>> list = new ArrayList<Map<String, String>>();
								m2mRelation.put(pkgAndClazzAndField, list);
							}
							List<Map<String, String>> relationList = m2mRelation.get(pkgAndClazzAndField);
							relationList.add(relation);
						}
					}
				}
			}
		}
	}
	
	private void fillM2MRelation(Element rootElement) {
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
						String pkgAndClazzAndField = pkg.attributeValue("name") + "." + table.attributeValue("clazz") + "." + column.attributeValue("field");
						if (m2mRelation.containsKey(pkgAndClazzAndField)) {
							List<Map<String, String>> relationList = m2mRelation.get(pkgAndClazzAndField);
							for(Map<String, String> relation : relationList) {
								DefaultAttribute m2mJoinPackage = new DefaultAttribute("m2mJoinPackage", relation.get("m2mJoinPackage"));
								DefaultAttribute m2mJoinTable = new DefaultAttribute("m2mJoinTable", relation.get("m2mJoinTable"));
								DefaultAttribute m2mJoinField = new DefaultAttribute("m2mJoinField", relation.get("m2mJoinField"));
								//DefaultAttribute m2mAutoGen = new DefaultAttribute("m2mAutoGen", "false");
								DefaultAttribute relationTableAttr = new DefaultAttribute("relationTable", relation.get("m2mJoinTable") + relation.get("clazz"));
								column.add(m2mJoinPackage);
								column.add(m2mJoinTable);
								column.add(m2mJoinField);
								//column.add(m2mAutoGen);
								column.add(relationTableAttr);
							}
						}
					}
				}
			}
		}
	}
}

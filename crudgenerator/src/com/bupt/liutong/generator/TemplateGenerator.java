package com.bupt.liutong.generator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.bupt.liutong.generator.config.GenerateConfig;
import com.bupt.liutong.generator.config.GenerateConfigParser;
import com.bupt.liutong.generator.config.Table;
import com.bupt.liutong.generator.config.Template;
import com.bupt.liutong.util.FileUtils;
import com.bupt.liutong.util.StringUtils;

public class TemplateGenerator {

	/** The path of the configuration */
	private String configPath;

	private Connection con;
	private Statement stmt;
	private Map<String, Object> parameterMap;
	private GenerateConfig generateConfig;

	private String driverClass;
	private String connectionURL;
	private String userId;
	private String password;
	
	private List<Template> templateList;
	private List<Table> tableList;

	public TemplateGenerator(String configPath)
			throws Exception {
		this.configPath = configPath;
		setConfig();
		connectDatabase();
		setParameterMap();
	}

	/**
	 * Set the configuration for the generation
	 * @throws Exception 
	 */
	private void setConfig() throws Exception {
		generateConfig = GenerateConfigParser.loadConfig(configPath);
		driverClass = generateConfig.getDriverClass();
		connectionURL = generateConfig.getConnectionURL();
		userId = generateConfig.getUserId();
		password = generateConfig.getPassword();
		templateList = generateConfig.getTemplateList();
		tableList = generateConfig.getTableList();
		if (templateList == null || templateList.size() == 0) {
			throw new Exception("No template to generate");
		} else if (tableList == null || tableList.size() == 0) {
			throw new Exception("No table to generate");
		}
	}

	private void connectDatabase() {
		try {
			Class.forName(driverClass);
			con = DriverManager.getConnection(connectionURL + "?user=" + userId
					+ "&password=" + password);
			stmt = con.createStatement();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void setParameterMap() {
		parameterMap = new HashMap<String, Object>();
		parameterMap.putAll(generateConfig.getParameterMap());
	}

	/**
	 * Execute the function to generate
	 * 
	 * @throws Exception
	 */
	public void run() throws Exception {
		for (Table table : tableList) {
			setTableInfoInMap(table.getTableName());
			for (Template template : templateList) {
				parameterMap.put("targetPackage", template.getTargetPackage());
				parameterMap.put("domainObjectName", table.getDomainObjectName());
				String templatePath = System.getProperty("user.dir")
						+ "\\src\\"
						+ template.getTemplatePackage().replace('.', '\\')
						+ "\\" + template.getTemplateName();
				String targetPath = System.getProperty("user.dir") + "\\src\\"
						+ template.getTargetPackage().replace('.', '\\') + "\\"
						+ this.replaceParameter(template.getTargetName());
				generateTable(templatePath, targetPath);
			}
		}
		destroy();
	}

	/**
	 * Fetch the information of one table into the "paramterMap"
	 * in order to replace the parameter in the template
	 * 
	 * @param tableName
	 * @throws SQLException
	 */
	private void setTableInfoInMap(String tableName) throws SQLException {
		// 1.All column
		parameterMap.put("tableName", tableName);
		//
		List<String> columnClassNames = new ArrayList<String>();
		List<String> columnNames = new ArrayList<String>();
		List<String> columnClassShortNames = new ArrayList<String>();
		ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName);

		// fetch column name, class name with package
		for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
			columnClassNames.add(rs.getMetaData().getColumnClassName(i));
			columnNames.add(rs.getMetaData().getColumnName(i));
		}

		// fetch the class name without package
		for (String columnClassName : columnClassNames) {
			columnClassShortNames.add(columnClassName.substring(columnClassName
					.lastIndexOf(".") + 1, columnClassName.length()));
		}
		parameterMap.put("columnClassNames", columnClassNames);
		parameterMap.put("columnNames", columnNames);
		parameterMap.put("columnClassShortNames", columnClassShortNames);
		rs.close();
		
		// 2.All primary column
		List<String> primaryKeys = new ArrayList<String>();
		ResultSet pkrs = con.getMetaData().getPrimaryKeys(null, null, tableName);
		while (pkrs.next()) {
			primaryKeys.add(pkrs.getString("COLUMN_NAME"));
		}
		parameterMap.put("primaryKeys", primaryKeys);
		pkrs.close();
	}
	
//	private String handleTargetName(String targetName){
//		return targetName.replaceFirst("\\{\\$.+?\\}", p);
//	}

	/**
	 * The generated process of one-table-one-template
	 * If u want to generate all, please run the function circling 
	 * 
	 * @param templatePath
	 * @param dtoPath
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private void generateTable(String templatePath, String outputPath) throws Exception {
		FileUtils.deleteFile(outputPath);
		FileUtils.newFile(outputPath);
		File templateFile = new File(templatePath);
		if (templateFile.exists()) {
			BufferedReader br = new BufferedReader(new FileReader(templateFile));

			List<String> iterateParams = null;
			List<String> iterateLists = null;
			String buffer = "";
			String forString = "";
			String pendString = "";
			String pendState = "";
			// 状态机：0表示不在循环中；1表示在循环中
			String state = "0";
			while ((buffer = br.readLine()) != null) {
				buffer = buffer.trim();
				if (state.equals("1")) { // for循环中
					if (buffer.startsWith("{$/for")) {
						// 遍历list，输出字符
						if (iterateParams == null || iterateLists == null
								|| iterateParams.size() == 0
								|| iterateLists.size() == 0) {
							throw new NullPointerException(
									"The tag {$for} should contains at least a List");
						} else {
							List<String> firstList = (List<String>) parameterMap
									.get(iterateLists.get(0));
							for (int i = 0; i < firstList.size(); i++) {
								String replaceString = null;
								replaceString = replaceParameter(
										iterateParams, iterateLists, forString, i);
								if(i > 0 && pendState.equals("firstNotPrepend")){
									FileUtils.appendFile(outputPath, StringUtils.prependIgnoreSpace(replaceString, pendString+" "));
								} else if(i<firstList.size()-1 && pendState.equals("lastNotAppend")) {
									FileUtils.appendFile(outputPath, replaceString + pendString + " ");
								} else {
									FileUtils.appendFile(outputPath, replaceString);
								}
							}
							pendState = "";
						}
						forString = "";
						state = "0";
					} else {
						forString += buffer;
					}
				} else if (buffer.startsWith("{$for")) { // for标签开始
					state = "1";
					int start = buffer.indexOf("{$", 0);
					int end = buffer.indexOf("}", start);
					if (start < buffer.length() && end < buffer.length()
							&& start > -1 && end > -1) {
						String tag = buffer.substring(start + 2, end);

						// Add the list which will be operated
						String[] tagSplit = tag.split(" ");
						iterateParams = new ArrayList<String>();
						iterateLists = new ArrayList<String>();
						for (int i = 1; i < tagSplit.length; i++) {
							if (tagSplit[i].contains(":")) {
								iterateParams.add(tagSplit[i].substring(0,
										tagSplit[i].indexOf(":")));
								iterateLists.add(tagSplit[i].substring(
										tagSplit[i].indexOf(":") + 1,
										tagSplit[i].length()));
							} else if(i==tagSplit.length-1 && tagSplit[i].contains("=")) {
								if(tagSplit[i].startsWith("firstNotPrepend")){
									pendString = tagSplit[i].substring(tagSplit[i].indexOf("=")+2, tagSplit[i].length()-1);
									pendState = "firstNotPrepend";
								} else if(tagSplit[i].startsWith("lastNotAppend")){
									pendString = tagSplit[i].substring(tagSplit[i].indexOf("=")+2, tagSplit[i].length()-1);
									pendState = "lastNotAppend";
								}
							} else {
								throw new Exception(
										"\""+buffer+"\":The parameter in the tag {$for} should contains ':' .");
							}
						}
					}
				} else if (buffer.contains("{$")) { // 包含变量标签
					buffer = replaceParameter(buffer);
					FileUtils.appendFile(outputPath, buffer);
				} else { // 普通文本
					FileUtils.appendFile(outputPath, buffer);
				}
			}
		}
	}

	/**
	 * Find the value from "parameterMap" & "iterateList" 
	 * to replace the parameter
	 * 
	 * @param iterateParams
	 * @param iterateLists
	 * @param forString
	 * @param i
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String replaceParameter(List<String> iterateParams,
			List<String> iterateLists, String forString, int i) {
		int start = 0;
		int end = 0;
		String replaceString = forString;
		while (end != -1) {
			start = replaceString.indexOf("{$", 0);
			end = replaceString.indexOf("}", start);
			if (start < replaceString.length() && end < replaceString.length()
					&& start > -1 && end > -1) {
				String tag = replaceString.substring(start + 2, end);
				String[] tagSplit = tag.split(" ");
				if (tagSplit.length >= 2) {
					if (tagSplit[1].equals("firstLetterUpper=\"true\"")) {
						// Replace the parameter in "parameterMap"
						if (parameterMap.containsKey(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											StringUtils.firstLetterUpper((String) parameterMap
															.get(tagSplit[0])));
						}
						// Replace the parameter of list in "parameterMap"
						else if (iterateParams.contains(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											StringUtils.firstLetterUpper(((List<String>) parameterMap
															.get(iterateLists
																	.get(iterateParams
																			.indexOf(tagSplit[0]))))
															.get(i)));
						}
					} else if (tagSplit[1].equals("allLetterUpper=\"true\"")) {
						// Replace the parameter in "parameterMap"
						if (parameterMap.containsKey(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											((String) parameterMap.get(tagSplit[0])).toUpperCase());
						}
						// Replace the parameter of list in "parameterMap"
						else if (iterateParams.contains(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											(((List<String>) parameterMap.get(
													iterateLists.get(iterateParams.indexOf(tagSplit[0])))).get(i)).toUpperCase());
						}
					} else if (tagSplit[1].equals("firstLetterLower=\"true\"")) {
						// Replace the parameter in "parameterMap"
						if (parameterMap.containsKey(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											StringUtils.firstLetterLower((String) parameterMap
															.get(tagSplit[0])));
						}
						// Replace the parameter of list in "parameterMap"
						else if (iterateParams.contains(tagSplit[0])) {
							replaceString = replaceString
									.replaceFirst(
											"\\{\\$.+?\\}",
											StringUtils.firstLetterLower(((List<String>) parameterMap
															.get(iterateLists
																	.get(iterateParams
																			.indexOf(tagSplit[0]))))
															.get(i)));
						}
					}
				} else {
					if (parameterMap.containsKey(tagSplit[0])) {
						replaceString = replaceString.replaceFirst(
								"\\{\\$.+?\\}", (String) parameterMap.get(tagSplit[0]));
					} else if (iterateParams.contains(tagSplit[0])) {
						replaceString = replaceString
								.replaceFirst(
										"\\{\\$.+?\\}",
										((List<String>) parameterMap.get(iterateLists.get(iterateParams.indexOf(tagSplit[0])))).get(i));
					}
				}
			}
			end = start;
		}
		return replaceString;
	}

	/**
	 * Find the value from "parameterMap" 
	 * to replace the parameter
	 * 
	 * @param buffer
	 * @return
	 * @throws Exception 
	 */
	private String replaceParameter(String buffer) throws Exception {
		int start = 0;
		int end = 0;
		while (end != -1) {
			start = buffer.indexOf("{$", 0);
			end = buffer.indexOf("}", start);
			if (start < buffer.length() && end < buffer.length() && start > -1
					&& end > -1) {
				String tag = buffer.substring(start + 2, end);
				String[] tagSplit = tag.split(" ");
				if (tagSplit.length >= 2) {
					if (tagSplit[1].equals("firstLetterUpper=\"true\"")) {
						if (parameterMap.containsKey(tagSplit[0])) {
							buffer = buffer
									.replaceFirst(
											"\\{\\$.+?\\}",
											StringUtils
													.firstLetterUpper((String) parameterMap
															.get(tagSplit[0])));
						} else {
							throw new Exception("\"" + buffer
									+ "\":Can't find the '"
									+ (String) parameterMap.get(tagSplit[0])
									+ "'");
						}
					} else if (tagSplit[1].equals("allLetterUpper=\"true\"")) {
						if (parameterMap.containsKey(tagSplit[0])) {
							buffer = buffer.replaceFirst("\\{\\$.+?\\}",
									((String) parameterMap.get(tagSplit[0]))
											.toUpperCase());
						} else {
							throw new Exception("\"" + buffer
									+ "\":Can't find the '"
									+ (String) parameterMap.get(tagSplit[0])
									+ "'");
						}
					} else if (tagSplit[1].equals("firstLetterLower=\"true\"")) {
						if (parameterMap.containsKey(tagSplit[0])) {
							buffer = buffer.replaceFirst("\\{\\$.+?\\}",
									(StringUtils.firstLetterLower((String) parameterMap.get(tagSplit[0]))));
						} else {
							throw new Exception("\"" + buffer
									+ "\":Can't find the '"
									+ (String) parameterMap.get(tagSplit[0])
									+ "'");
						}
					}
				} else {
					if (parameterMap.containsKey(tagSplit[0])) {
						buffer = buffer.replaceFirst("\\{\\$.+?\\}",
								(String) parameterMap.get(tagSplit[0]));
					} else {
						throw new Exception("\""+buffer+"\":Can't find the '"+(String) parameterMap.get(tagSplit[0])+"'");
					}
				}
			}
			end = start;
		}
		return buffer;
	}
	
	private void destroy(){
		try {
			stmt.close();
			con.close();
		} catch (SQLException e) {
			System.err.println("Error when close the database.");
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		try {
			TemplateGenerator generator = new TemplateGenerator(
					"G:\\Workspaces\\CRUDGenerator\\src\\com\\bupt\\liutong\\generator\\config\\generateConfig.xml");
			generator.run();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

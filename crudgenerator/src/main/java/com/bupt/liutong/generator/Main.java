package com.bupt.liutong.generator;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;

import org.apache.xalan.processor.TransformerFactoryImpl;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.DocumentResult;
import org.dom4j.io.DocumentSource;
import org.xml.sax.SAXException;

import com.bupt.liutong.generator.setter.ColumnDbTypeSetter;
import com.bupt.liutong.generator.setter.ColumnLengthSetter;
import com.bupt.liutong.generator.setter.ColumnNameSetter;
import com.bupt.liutong.generator.setter.ImportClassSetter;
import com.bupt.liutong.generator.setter.JoinSetter;
import com.bupt.liutong.generator.setter.M2MSetter;
import com.bupt.liutong.generator.setter.TableNameSetter;
import com.bupt.liutong.sql.DBOper;
import com.bupt.liutong.util.Dom4jUtils;
import com.bupt.liutong.util.FileUtils;
import com.bupt.liutong.util.StringUtils;

public class Main {

	private static final String BASE_PATH = System.getProperty("user.dir");// ClassLoader.getSystemClassLoader().getResource("").toString();

	/**
	 * @param args
	 * @throws TransformerException
	 * @throws IOException
	 * @throws DocumentException
	 * @throws SQLException
	 * @throws SAXException 
	 * @throws ParserConfigurationException 
	 */
	public static void main(String[] args) throws TransformerException,
			IOException, DocumentException, SQLException, SAXException, ParserConfigurationException {
		// 数据源
		// 配置文件
		Element configRoot = Dom4jUtils.getRootElementWithNS(
				BASE_PATH + "/src/main/java/com/bupt/liutong/generator/config/".replace("/", File.separator) + "config.xml", 
				"c", "http://localhost/schema/config");
		
		// 模型文件
		Element modelRoot = Dom4jUtils.getRootElementWithNS(
				BASE_PATH + "/src/main/java/com/bupt/liutong/generator/config/".replace("/", File.separator) + "model.xml", 
				"m", "http://localhost/schema/model");

		// 生成静态代码
		copyStaticCode(configRoot);
		
		// 预处理模型，填充默认值
		new ImportClassSetter().setDefaultValue(
			new ColumnLengthSetter().setDefaultValue(
			new ColumnDbTypeSetter().setDefaultValue(
			new ColumnNameSetter().setDefaultValue(
			new TableNameSetter().setDefaultValue(
			new M2MSetter().setDefaultValue(
			new JoinSetter().setDefaultValue(modelRoot)))))));

		// 生成动态代码
		generateCode(configRoot, modelRoot);

		// 把生成的SQL导入数据库
		importDatabase(configRoot);
	}

	private static void copyStaticCode(Element configRoot) throws IOException {
		String targetPrj = configRoot.selectSingleNode(
				"//c:config/c:parameters/c:parameter[@id='targetPrj']").valueOf(
				"@value");
		// FileUtils.deleteFolder(targetPrj);
		FileUtils.forceCopyFolder(BASE_PATH + File.separator + "file", targetPrj);
		FileUtils.deleteFolder(targetPrj, "\\.svn");
	}

	private static void generateCode(Element configRoot, Element modelRoot) throws DocumentException, TransformerException, IOException {
		// 数据源
		Element parameters = configRoot.element("parameters");
		// 模板
		Element templates = configRoot.element("templates");
		Element configDataSrc = DocumentHelper.parseText(configRoot.asXML().replace("&", "&amp;")).getRootElement();

		String targetPrj = parameters.selectSingleNode(
				"c:parameter[@id='targetPrj']").valueOf("@value");
		
		// 遍历所有模板
		for (Iterator<?> i = templates.elementIterator("template"); i.hasNext();) {
			Element template = (Element) i.next();
			// 输出路径或输出路径表达式（含$符号）
			String targetPath = targetPrj
					+ File.separator
					+ template.attributeValue("targetPath").replace("/",
							File.separator);
			// 不同的数据源组成方式，对应不同的生成方案
			String transformFlag = template.attributeValue("transform");
			if (transformFlag != null && transformFlag.equals("model")) {
				// 以整个model为单位做转换
				modelRoot.add(parameters.detach());
				transform(modelRoot, template, targetPath);
			} else if(transformFlag != null && transformFlag.equals("package")){
				// 以一个package为单位做转换
				for (Iterator<?> j = modelRoot.elementIterator("package"); j.hasNext();) {
					Element pkg = (Element) j.next();
					pkg.add(parameters.detach());
					String pkgName = pkg.attributeValue("name");
					String finalTargetPath = targetPath.replace("${package}", pkgName);
					transform(pkg, template, finalTargetPath);
				}
			} else if (transformFlag == null || transformFlag.equals("table")) {
				// 以一个table为单位做转换
				for (Iterator<?> j = modelRoot.elementIterator("package"); j.hasNext();) {
					Element pkg = (Element) j.next();
					pkg.add(parameters.detach());
					String pkgName = pkg.attributeValue("name");
					for (Iterator<?> k = pkg.elementIterator("table"); k.hasNext();) {
						Element table = (Element) k.next();
						table.addAttribute("package", pkgName);
						table.add(parameters.detach());
	
						// 确定输出路径
						String tableClazz = table.attributeValue("clazz");
						String tableClazzLower = StringUtils.firstLetterLower(tableClazz);
						String tableName = table.attributeValue("name");
						String finalTargetPath = targetPath.replace("${table.clazz}",
								tableClazz);
						finalTargetPath = finalTargetPath.replace("${table.clazz.lower}",
								tableClazzLower);
						finalTargetPath = finalTargetPath.replace("${table.name}",
								tableName);
						finalTargetPath = finalTargetPath.replace("${package}", pkgName);
						transform(table, template, finalTargetPath);
					}
				}
			} else if(transformFlag != null && transformFlag.equals("config")){
				transform(configDataSrc, template, targetPath);
			}
		}
		configRoot.add(parameters.detach());
	}
	
	private static void transform(Element dataSrc, Element template, String targetPath) throws TransformerException, DocumentException, IOException {
		
		boolean override = StringUtils.isTrue(template
				.attributeValue("override")) ? true : false;
		

		System.out.print(targetPath);
		// 若目标不存在OR可覆盖，则生成代码
		if (override || !new File(targetPath).exists()) {
			System.out.print(" gen");
			// 设置模板
			String templatePath = BASE_PATH
					+ File.separator
					+ template.attributeValue("path").replace("/",
							File.separator);
			TransformerFactory factory = TransformerFactoryImpl.newInstance();
			Transformer transformer = factory
					.newTransformer(new StreamSource(templatePath));
			DocumentSource source = new DocumentSource(
					DocumentHelper.parseText(dataSrc.asXML().replaceAll(
							"xmlns=\".*?\"", "")));
			//System.out.println(source.getDocument().asXML());
			DocumentResult result = new DocumentResult();
			// 开始转换
			transformer.transform(source, result);
			//System.out.println(targetPath);
			FileUtils.forceNewFile(targetPath, result
					.getDocument().getRootElement().getText(), "UTF-8");
		}
		System.out.println();
	}

	private static void importDatabase(Element configRoot) throws SQLException {
		// 参数
		String targetPrj = configRoot.selectSingleNode(
				"//c:config/c:parameters/c:parameter[@id='targetPrj']").valueOf(
				"@value");
		Node dbConfig = configRoot.selectSingleNode("//c:config/c:db");
		String driverClass = dbConfig.valueOf("@driverClass");
		String jdbcUrl = dbConfig.valueOf("@jdbcUrl");
		String userId = dbConfig.valueOf("@userId");
		String password = dbConfig.valueOf("@password");

		DBOper dbOper = new DBOper(driverClass, jdbcUrl, userId,
				password);
		File folder = new File(targetPrj + File.separator + "sql");
		if (!folder.exists())
			throw new IllegalArgumentException();
		File[] files = folder.listFiles();
		for (File file : files) {
			if (file.getName().endsWith(".sql")) {
				dbOper.importSQLFile(file.getPath());
			}
		}
	}
}
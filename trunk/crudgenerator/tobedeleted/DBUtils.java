package com.bupt.liutong.sql;

import java.util.List;

import com.bupt.liutong.sql.load.DBLoadable;
import com.bupt.liutong.util.FileUtils;

public class DBUtils {
	/**
	 * generate load infile, force override exsiting file
	 * 
	 * @author liutong628@gmail.com
	 * @param loadList
	 * @param filePath
	 * @throws IOException
	 */
	public static void genLoadInfile(List<? extends DBLoadable> loadList, String filePath) {
		genLoadInfile(loadList, filePath, "UTF-8");
	}

	/**
	 * generate load infile, force override exsiting file
	 * 
	 * @author liutong628@gmail.com
	 * @param loadList
	 * @param filePath
	 * @param fileEncoding
	 * @throws IOException
	 */
	public static void genLoadInfile(List<? extends DBLoadable> loadList, String filePath, String fileEncoding) {
		
		FileUtils.forceNewFile(filePath);

		int BUFFER_SIZE = 1024 * 1024 * 1024;
		StringBuilder sb = new StringBuilder();

		for (DBLoadable load : loadList) {
			if (sb.length() < BUFFER_SIZE) {
				load.toDBLineString();
			} else {
				FileUtils.appendFile(filePath, sb.toString(), fileEncoding);
				sb = new StringBuilder();
			}
		}
		if (sb.length() > 0)
			FileUtils.appendFile(filePath, sb.toString(), fileEncoding);
	}
}

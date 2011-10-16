package com.bupt.liutong.core.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.bupt.liutong.core.dao.CommonDao;
import com.bupt.liutong.util.BeanUtils;

import static com.bupt.liutong.core.base.Constants.*;

public class SessionManager {
	
	private CommonDao commonDao;
	
	/**
	 * 有查询条件的分页
	 * @param baseForm
	 * @param baseDto
	 * @param countSqlMapId
	 * @param request
	 */
	public void pagingWithCriteria(BaseForm baseForm, BaseDto baseDto,
			String countSqlMapId, HttpServletRequest request) {
		HttpSession session = request.getSession();
		// 新查询
		if (baseForm.getSearchFlag().equals(NEW_SEARCH_FLAG)) {
			// 恢复到初始第1页
			baseForm.setCurPage(1);
			// 复制form到dto
			BeanUtils.copyProperties(baseDto, baseForm);
			// 设置查询结果总数
			int totalRow = commonDao.getListCount(countSqlMapId, baseDto);
			baseForm.setTotalRow(totalRow);
			baseDto.setTotalRow(totalRow);

			// 将查询条件放到session中
			session.setAttribute("lastTimeForm", baseForm);
		}
		// 翻页
		else {
			// 将最新的查询条件放到session中
			BaseForm lastTimeForm = (BaseForm) session.getAttribute("lastTimeForm");
			// 将session中Form状态置为旧查询
			lastTimeForm.setSearchFlag(OLD_SEARCH_FLAG);
			// 更新session中form的页号
			lastTimeForm.setCurPage(baseForm.getCurPage());
			
			BeanUtils.copyProperties(baseForm, lastTimeForm);
			BeanUtils.copyProperties(baseDto, baseForm);
		}
	}
	
	/**
	 * 无查询条件的分页
	 * @param baseForm
	 * @param baseDto
	 * @param countSqlMapId
	 */
	public void pagingWithNoCriteria(BaseForm baseForm, BaseDto baseDto,
			String countSqlMapId) {
		BeanUtils.copyProperties(baseDto, baseForm);
		if(baseForm.getSearchFlag().equals(Constants.NEW_SEARCH_FLAG)){
			// 恢复到初始第1页
			baseForm.setCurPage(1);
			baseDto.setCurPage(1);
			// 设置查询结果总数
			int totalRow = commonDao.getListCount(countSqlMapId, baseDto);
			baseForm.setTotalRow(totalRow);
			baseDto.setTotalRow(totalRow);
		} else {
			
		}
	}
	
	/**
	 * 弹出窗口中查询的分页策略
	 * 
	 * @param popWindowForm
	 * @param request
	 */
//	public void getPopWindowForm(PopWindowForm popWindowForm, HttpServletRequest request){
//		HttpSession session = request.getSession();
//		if(popWindowForm.getSearchFlag().equals(POP_WINDOW_OPEN_FLAG)){
//			// 设置查询结果总数
//			int totalRow = commonDao.getListCount(popWindowForm.getSqlCount());
//			popWindowForm.setTotalRow(totalRow);
//			popWindowForm.setCurPage(1);
//			
//			// 缓存弹出窗口配置
//			session.setAttribute("origForm", popWindowForm);
//			// 缓存上一次的查询条件
//			session.setAttribute("lastTimeForm", popWindowForm);
//		} else if (popWindowForm.getSearchFlag().equals(NEW_SEARCH_FLAG)) {
//			// 取弹出窗口配置
//			BeanUtils.copyProperties(popWindowForm, session.getAttribute("origForm"));
//			
//			// 拼凑SQL语句的WHERE条件
//			if (popWindowForm.getSearchPropArr() != null
//					&& popWindowForm.getSearchPropArr().length > 0) {
//				StringBuilder whereClause = new StringBuilder();
//				for (int i = 0; i < popWindowForm.getSearchPropArr().length; i++) {
//					String searchProp = popWindowForm.getSearchPropArr()[i];
//					String propValue = request.getParameter(searchProp);
//					if (!StringUtils.isEmpty(propValue)) {
//						if (StringUtils.isEmpty(whereClause.toString())) {
//							whereClause.append(" WHERE ");
//						} else {
//							whereClause.append(" AND ");
//						}
//						whereClause.append(searchProp);
//						whereClause.append(" LIKE '%");
//						whereClause.append(propValue);
//						whereClause.append("%'");
//					}
//				}
//				popWindowForm.setSql(popWindowForm.getSql() + whereClause);
//				popWindowForm.setSqlCount(popWindowForm.getSqlCount() + whereClause);
//			}
//
//			// 设置查询结果总数
//			int totalRow = commonDao.getListCount(popWindowForm.getSqlCount());
//			popWindowForm.setTotalRow(totalRow);
//			popWindowForm.setCurPage(1);
//			session.setAttribute("lastTimeForm", popWindowForm);
//		} else {
//			// 取上一次的查询条件
//			PopWindowForm lastTimeForm = (PopWindowForm) session.getAttribute("lastTimeForm");
//			lastTimeForm.setSearchFlag(OLD_SEARCH_FLAG);
//			lastTimeForm.setCurPage(popWindowForm.getCurPage());
//			BeanUtils.copyProperties(popWindowForm, lastTimeForm);
//		}
//	}

	public void setCommonDao(CommonDao commonDao) {
		this.commonDao = commonDao;
	}
}

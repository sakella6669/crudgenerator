<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<bean:define id="curPage" name="curPage" type="java.lang.Integer" />
<logic:greaterThan name="curPage" value="1">
	<a href="<%=request.getContextPath()%>${actionPath}&curPage=1&totalRow=${totalRow}">&lt;</a>
</logic:greaterThan>
<logic:equal name="curPage" value="1">
	<span class="disabled">&lt;</span>
</logic:equal>
<c:forEach var="page" begin="1" end="${totalPage}" step="1">
	<logic:notEqual name="curPage" value="${page}">
		<a href="<%=request.getContextPath()%>${actionPath}&curPage=${page}&totalRow=${totalRow}">${page}</a>
	</logic:notEqual>
	<logic:equal name="curPage" value="${page}">
		<span class="disabled">${page}</span>
	</logic:equal>
</c:forEach>
<logic:lessThan name="curPage" value="${totalPage}">
	<a href="<%=request.getContextPath()%>${actionPath}&curPage=${totalPage}&totalRow=${totalRow}">&gt;</a>
</logic:lessThan>
<logic:equal name="curPage" value="${totalPage}">
	<span class="disabled">&gt;</span>
</logic:equal>
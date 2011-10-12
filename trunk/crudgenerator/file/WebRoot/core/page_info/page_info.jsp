<%@ page language="java" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<div class="page_info">
共
${totalPage}
页 共
${totalRow}
<input type="hidden" name="totalRow" value="${totalRow}" />
条记录
<bean:define id="curPage" name="curPage" type="java.lang.Integer" />
当前是第
<bean:write name="curPage" />
页 每页
<bean:write name="pageSize" />
条记录
<input type="hidden" id="system" name="system" ><br/>

<logic:greaterThan name="curPage" value="1">
	<a href="javascript:document.getElementById('system').form.reset();dosubmit(document.getElementById('system').form, '<%=request.getContextPath()%>${actionPath}&curPage=1');">首 页</a>
</logic:greaterThan>
<logic:lessEqual name="curPage" value="1">
	首 页
</logic:lessEqual>

<logic:greaterThan name="curPage" value="1">
	<a href="javascript:document.getElementById('system').form.reset();dosubmit(document.getElementById('system').form, '<%=request.getContextPath()%>${actionPath}&curPage=${curPage-1}');">上一页</a>
</logic:greaterThan>
<logic:lessEqual name="curPage" value="1">
	上一页
</logic:lessEqual>

<logic:lessThan name="curPage" value="${totalPage}">
	<a href="javascript:document.getElementById('system').form.reset();dosubmit(document.getElementById('system').form, '<%=request.getContextPath()%>${actionPath}&curPage=${curPage+1}');">下一页</a>
</logic:lessThan>
<logic:greaterEqual name="curPage" value="${totalPage}">
	下一页
</logic:greaterEqual>

<logic:lessThan name="curPage" value="${totalPage}">
	<a href="javascript:document.getElementById('system').form.reset();dosubmit(document.getElementById('system').form, '<%=request.getContextPath()%>${actionPath}&curPage=${totalPage}');">末 页</a>
</logic:lessThan>
<logic:greaterEqual name="curPage" value="${totalPage}">
	末 页
</logic:greaterEqual>
&nbsp;&nbsp; 跳到第
<select name="curPage"
	onchange="resetAndSubmit(this.form, this.value);">
	<c:forEach var="page" begin="1" end="${totalPage}" step="1">
		<logic:equal name="curPage" value="${page}">
			<option value="${page}" selected="selected">
				${page}
			</option>
		</logic:equal>
		<logic:notEqual name="curPage" value="${page}">
			<option value="${page}">
				${page}
			</option>
		</logic:notEqual>
	</c:forEach>
</select>
<script type="text/javascript">
	function resetAndSubmit(form, value){
		form.reset();
		dosubmit(form, '<%=request.getContextPath()%>${actionPath}&curPage='+value);
	}
</script>
页
</div>
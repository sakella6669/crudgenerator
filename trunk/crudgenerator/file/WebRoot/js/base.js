
function validateEmpty(propArr){
	for(var i=0; i<propArr.length; i+=1){
		var prop = propArr[i];
		if(document.getElementsByName(prop)[0].value === ""){
			alert("必填项不能为空");
			document.getElementsByName(prop)[0].focus();
			return false;
		}
	}
	return true;
}

function validateNum(propArr){
	for(var i=0; i<propArr.length; i+=1){
		var prop = propArr[i];
		if(!isNum(document.getElementsByName(prop)[0].value)){
			alert("数据项只能填入数字");
			document.getElementsByName(prop)[0].focus();
			return false;
		}
	}
	return true;
}

function validateDate(propArr){
	for(var i=0; i<propArr.length; i+=1){
		var prop = propArr[i];
		if(!isDate(document.getElementsByName(prop)[0].value)){
			alert("日期项格式应如2010-01-01所示");
			document.getElementsByName(prop)[0].focus();
			return false;
		}
	}
	return true;
}

function dosubmit(form, url, type){
	if(type == "update"){
		if(!ifSelectAtLeastOne(form)){
			alert("您需要选择一项");
			return;
		} else if(!ifSelectOne(form)) {
			alert("您只能选择一项");
			return;
		}
	} else if (type == "delete"){
		if(!ifSelectAtLeastOne(form)) {
			alert("您至少要选择一项");
			return;
		} else if(!confirm("您确定要完全删除吗？删除操作不可恢复！")){
			return;
		}
	} else if (type == "atLeastOne"){
		if(!ifSelectAtLeastOne(form)) {
			alert("您至少要选择一项");
			return;
		}
	}
	form.action = url;
	form.submit();
}

function appendUrl(url){
	document.forms[0].action += url;
}

function disableParam(name, index){
	var elements = document.getElementsByName(name);
	elements[index].disabled = true;
}

function disableParams(name, startIndex, endIndex){
	var elements = document.getElementsByName(name);
	for(var i=startIndex; i<=endIndex && i<elements.length; i+=1){
		elements[i].disabled = true;
	}
}

function disableParamsStartWith(name, startIndex){
	var elements = document.getElementsByName(name);
	for(var i=startIndex; i<elements.length; i+=1){
		elements[i].disabled = true;
	}
}

function removeElementById(id){
	document.getElementById(id).parentNode.removeChild(document.getElementById(id));
}

function selectCheckbox(tr) {
	if (tr.nodeName == "TR") {
		var elements = tr.getElementsByTagName("input");
		for ( var i = 0; i < elements.length; i += 1) {
			if (elements[i].type == "checkbox") {
				elements[i].checked = !elements[i].checked;
			}
		}
	}
}

function ifSelectOne(form) {
	var elements = form.elements;
	for( var i=0; i<elements.length; i+=1){
		if (elements[i].type == "checkbox" && elements[i].checked) {
			if(elements[i].name === "") {
				continue;
			} else if(selectNum(elements[i].name)==1){
				return true;
			} else {
				return false;
			}
		}
	}
}

function ifSelectAtLeastOne(form) {
	var elements = form.elements;
	for( var i=0; i<elements.length; i+=1){
		if (elements[i].type == "checkbox" && elements[i].checked) {
			if(elements[i].name === "") {
				continue;
			} else if(selectNum(elements[i].name)>=1){
				return true;
			} else {
				return false;
			}
		}
	}
}

function selectAll(name, val){
	var elements = document.getElementsByName(name);
	for(var i=0; i < elements.length; i += 1 ){
		if (elements[i].type == "checkbox"){
			elements[i].checked = val;
		}
	}
}

function selectNum(name) {
	var elements = document.getElementsByName(name);
	var num = 0;
	for (var i = 0; i < elements.length; i += 1) {
		if (elements[i].type == "checkbox" && elements[i].checked) {
			num += 1;
		}
	}
	return num;
}

function isNum(val){
	if(val!=="" && isNaN(val)){
		return false;
	} else {
		return true;
	}
}

function isDate(val){
	return val==="" || (/^[0-9]{4}(-[0-9]{2}){2}$/.test(val));
}

function isInteger(val){
	return val==="" || (/^[0]{1}$/.test(val)) || (/^[1-9]{1}[0-9]*$/.test(val));
}

function isEmail(val){
	return val==="" || (/^\w+@\w+(\.\w+)+$/.test(val));
}

function isEnWord(value){
	return val==="" || (/^[a-zA-Z]+$/.test(value));
}

function isChsWord(value) {
	return val==="" || (/^[\u4e00-\u9fa5]+$/.test(value));
}

function isPhoneNum(value){
	return val==="" || (/^\d{7,8}$/.test(value));
}

function isMobilePhoneNum(value){
	return val==="" || (/^\d{11}$/.test(value));
}

//动态加载css文件或js文件
function attachFile(iframe,filename, filetype)
{ 
	//var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
	var head = iframe.document.getElementsByTagName("head").item(0);
	if (filetype=="css"){ //判断文件类型 
	   var fileref=iframe.document.createElement("link"); 
	   fileref.setAttribute("rel", "stylesheet") ;
	   fileref.setAttribute("type", "text/css");
	   fileref.setAttribute("href", filename);
	} 
	if (filetype=="js"){ //判断文件类型 
	   var fileref=iframe.document.createElement("script");//创建标签 
	   fileref.setAttribute("type","text/javascript");//定义属性type的值为text/javascrip
	   fileref.setAttribute("language","JavaScript");    
	   fileref.setAttribute("src", filename);//文件的地址 
	} 
	if (typeof fileref!="undefined")   
		head.appendChild(fileref);
}
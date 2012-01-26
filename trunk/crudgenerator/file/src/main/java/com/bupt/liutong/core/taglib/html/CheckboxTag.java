package com.bupt.liutong.core.taglib.html;

import java.util.Collection;

import javax.servlet.jsp.JspException;

import org.apache.struts.taglib.TagUtils;

import com.bupt.liutong.util.BeanUtils;

public class CheckboxTag extends org.apache.struts.taglib.html.CheckboxTag {

	private static final long serialVersionUID = -4399618479092883153L;

	protected boolean isChecked() throws JspException {

		boolean strutsDefaultChecked = super.isChecked();
		
		boolean extendChecked = false;
		if(property.contains("[") && property.contains("]")) {
			// ex. roleForms[1].id, iterateProperty=roleForms, beanField=id
			String iterateProperty = property.substring(0, property.indexOf("["));
			String beanField = property.substring(property.indexOf("].") + 2, property.length());
			Object iterateInstance = TagUtils.getInstance().lookup(pageContext, name, iterateProperty, null);
			if (iterateInstance instanceof Collection) {
				Collection<?> c = (Collection<?>) iterateInstance;
				for(Object bean : c) {
					Object fieldValue = BeanUtils.getPropertyValue(bean, beanField);
					if (fieldValue != null
							&& (this.value == fieldValue 
								|| fieldValue.toString().equals(this.value))) {
						extendChecked = true;
						break;
					}
				}
			} else {
				JspException e = new JspException(messages.getMessage("iterate.iterator"));
				TagUtils.getInstance().saveException(pageContext, e);
				throw e;
			}
		}
		
		return strutsDefaultChecked || extendChecked;
	}
}

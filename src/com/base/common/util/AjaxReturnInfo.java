package com.base.common.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.xerces.dom.DocumentImpl;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.manager.xml.util.XMLUtil;

public class AjaxReturnInfo {
	
	private String errCode;
	private String errMsg;
	private String errLevel;
	private boolean isSuccess = true;;
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getErrCode() {
		return errCode;
	}
	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getErrLevel() {
		return errLevel;
	}
	public void setErrLevel(String errLevel) {
		this.errLevel = errLevel;
	}
	
	public Document genReturnXMLInfo() {
		Document doc = new DocumentImpl();
		Element ndRoot = doc.createElement("root");
		doc.appendChild(ndRoot);
		if(isSuccess) {
			ndRoot.setAttribute("hasError", "N");
		} else {
			ndRoot.setAttribute("hasError", "Y");
			Element errCode = doc.createElement("errCode");
			Element errMsg = doc.createElement("errMsg");
			Element errLevel = doc.createElement("errLevel");
			XMLUtil.SetNodeValue(doc, errCode, this.errCode);
			XMLUtil.SetNodeValue(doc, errMsg, this.errMsg);
			XMLUtil.SetNodeValue(doc, errLevel, this.errLevel);
			ndRoot.appendChild(errCode);
			ndRoot.appendChild(errMsg);
			ndRoot.appendChild(errLevel);
		}
		return doc;
	}
	
	/**
	 * 字符串流输出
	 * @param str
	 */
	public static void stringPrint(String str){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");// 指定返回值的编码方式，必须放在out声明之前
		response.setContentType("text/html;charset=UTF-8");
		try {
			out = response.getWriter();
			out.print(str);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	/**
	 * xml 输出  请求头已经给出
	 * @param str
	 */
	public static void xmlPrint(String str){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");// 指定返回值的编码方式，必须放在out声明之前
		try {
			out = response.getWriter();
			response.setContentType("text/xml;charset=UTF-8");
			out.print(str);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}    

}

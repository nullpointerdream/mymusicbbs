<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/sys_jsp/base.jsp"%>
<jsp:include page="/page/index/common/common.jsp" />

<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title><public:i18n key="system.name" module="system"></public:i18n></title>
			<script type="text/javascript" src="<%=basePath %>pro_js/news/news.js"></script>
		</head>
<!-- fckeditor -->

		<body>
			<div id="main-content">
			<div class="content-box">
			<div class="content-box-header">
			<h3><public:i18n key="function.edit" module="news"></public:i18n></h3>
			<ul class="content-box-tabs">
				<li><a href="#tab1" class="default-tab"><public:i18n key="function.edit" module="news"></public:i18n></a></li>
			</ul>
			<div class="clear"></div>
			</div>
			<div class="content-box-content">
			<jsp:include page="/sys_jsp/notification.jsp"></jsp:include>
			<div class="tab-content default-tab" id="tab1">
				<table>
				<input type='hidden' name='id' value='${result.id }' />
					<tr>
					   <td>
						   <public:i18n key="title" module="news"></public:i18n>:
					   </td>
					   <td>
						   ${result.title}
					   </td>
					</tr>
					<tr>
					   <td>
						    <label><public:i18n key="content" module="news"></public:i18n></label>
					   </td>
					   <td>
						   
					   </td>
					</tr>
					
					<tr>
					 
					   <td colspan="2">
						   <textarea name="content" class="layui-textarea" id="edit"
									 cols="60" rows="10">${result.content}</textarea>
						   
					   </td>
					</tr>
					<!-- 
					<tr>
					   <td>
						   <public:i18n key="username" module="news"></public:i18n>:
					   </td>
					   <td>
						   ${result.username}
					   </td>
					</tr>
					 -->
					
					<tr>
					   <td>
						   <public:i18n key="datetime" module="news"></public:i18n>:
					   </td>
					   <td>
						   ${result.datetime}
					   </td>
					</tr>
					<tr>
					   <td>
						   <button class="layui-btn" lay-filter="updatenews" lay-submit>修改</button>
					   </td>
					   <td>
						   <button class="layui-btn  layui-btn-danger" id="cancelButton" name="cancelButton" >取消</button>
					   </td>
					</tr>
				</table>
				<div class="clear"></div>
			</div>
			</div>
			</div>
			</div>
		</body>
	</html>

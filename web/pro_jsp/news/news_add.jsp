<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/sys_jsp/base.jsp"%>
<jsp:include page="/page/index/common/common.jsp" />
<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title><public:i18n key="system.name" module="system"></public:i18n></title>
		</head>

		<body>
			<div id="main-content">
			<div class="content-box">
			<div class="content-box-header">
				<h3><public:i18n key="function.add" module="news"></public:i18n></h3>
				<ul class="content-box-tabs">
					<li><a href="#tab1" class="default-tab"><public:i18n key="function.add" module="news"></public:i18n></a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="content-box-content">
			<jsp:include page="/sys_jsp/notification.jsp"></jsp:include>
				<div class="tab-content default-tab" id="tab1">

					<table>
					<tr>
					    <td>
						    <public:i18n key="title" module="news"></public:i18n>:
					    </td>
					    <td>
						    <input class="text-input small-input" type="text" id="title" name="title" rule="CHAR_M"/>
						<span id="title_errorMsg" class="input-notification png_bg"></span>
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
						      <!--  <textarea class="text-input textarea wysiwyg" id="content" name="content" cols="60" rows="5" rule="CHAR_M"></textarea> -->

						      <textarea name="content" class="layui-textarea" id="edit"
													cols="60" rows="10"></textarea>

					     </td>
					</tr>



					<tr>
					    <td>
					    </td>
					    <td>
							<%--<input class="button" type="button" name="submitButton" onclick="check()" value='<public:i18n key="button.submit" module="common"></public:i18n>' />--%>
							<button class="layui-btn" lay-filter="news" lay-submit>立即发布</button>
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

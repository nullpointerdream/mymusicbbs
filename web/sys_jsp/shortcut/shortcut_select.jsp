<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/sys_jsp/base.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title><public:i18n key="system.name" module="system"></public:i18n></title>
			<script type="text/javascript" src="<%=basePath %>sys_js/shortcut/shortcut.js"></script>
		</head>

		<body>
			<div id="main-content">
			<div class="content-box">
			<div class="content-box-header">
				<h3>歌曲列表</h3>
				<ul class="content-box-tabs">
					<li><a href="#tab1" class="default-tab">歌曲列表</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="content-box-content">
				<div class="tab-content default-tab" id="tab1">
					<jsp:include page="/sys_jsp/notification.jsp"></jsp:include>
						<c:forEach items="${list}" var="record">
						<input type="button" class="button" value="${record.musicname}" onclick="setParent('${record.id}','${record.musicname}')"/>
						</c:forEach>
				</div>
			</div>
		</div>
	</div>
	</body>
	</html>

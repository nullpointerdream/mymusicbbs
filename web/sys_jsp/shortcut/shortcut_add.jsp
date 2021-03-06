<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/sys_jsp/base.jsp"%>
<jsp:include page="/page/index/common/common.jsp" />
<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title>添加推荐歌曲</title>
			<script type="text/javascript" src="<%=basePath %>sys_js/shortcut/shortcut.js"></script>
		</head>

		<body>
			<div id="main-content">
			<div class="content-box">
			<div class="content-box-header">
				<h3>添加推荐歌曲</h3>
				<ul class="content-box-tabs">
					<li><a href="#tab1" class="default-tab">添加推荐歌曲</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="content-box-content">
			<jsp:include page="/sys_jsp/notification.jsp"></jsp:include>
				<div class="tab-content default-tab" id="tab1">
					<form action="<%=basePath %>shortcut/shortcut_add.do" method="post" name="mainform">
					<fieldset>
					<p>
						<input class="text-input small-input" type="hidden" id="url" name="url" rule="CHAR_M_200"/>


					</p>
					<p>
						<b>推荐歌曲:</b>
						<input class="text-input small-input" type="text" id="name" name="name" rule="CHAR_M_200"/>
						<input class="button" type="button" name="openPage" value="..." onclick="gotoSelectPage('<%=basePath %>musicInfo/musicInfo_tuijianlist.do')"/>
						<span id="name_errorMsg" class="input-notification png_bg"></span>
					</p>
					<p>
						<div class="layui-form-item">
							<div class="avatar-add" style="width: 100%">
						<p>建议尺寸775*356，支持jpg、png、gif，最大不能超过500KB</p>
						<button type="button" class="layui-btn upload-img">
							<i class="layui-icon">&#xe67c;</i>上传图片
						</button>
						<input type="hidden" name="fileFileName" id="fileFileName" class="layui-input">
						<img style="left: 9%;width: 100%;border-radius: 0%;top: 40%;height: 260px"  id="fileFileNamesrc">
						<span class="loading"></span>
				</div>
			</div>
					</p>
						<p>
							<input class="button" type="button" name="submitButton" value='<public:i18n key="button.submit" module="common"></public:i18n>' />
							<input onclick="window.location.href='<%=basePath %>shortcut.jsp'" class="button" type="button" name="returnButton" value='<public:i18n key="button.return" module="common"></public:i18n>' />
						</p>
					</fieldset>
					<div class="clear"></div>
					</form>
				</div>
				</div>
				</div>
			</div>
		</body>
	</html>

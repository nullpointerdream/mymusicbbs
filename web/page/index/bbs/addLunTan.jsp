<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>发表帖子 - 做全网最好的DJ音乐站</title>
<jsp:include page="/page/index/common/common.jsp" />
</head>
<body>

	<jsp:include page="/page/index/common/header.jsp" />

	<div class="page-loading">
		<div id="loader"></div>
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>
	</div>

	<!--Pjax Start-->
	<div id="container">
			<jsp:include page="/page/index/common/header2.jsp" />
		<div class="layui-container">
			<div class="layui-row">
				<div class="fly-panel layui-col-md10 layui-col-md-offset1" pad20
					style="padding-top: 5px;">
					<!--<div class="fly-none">没有权限</div>-->
					<div class="layui-form">
						<div class="layui-tab layui-tab-brief" lay-filter="user">
							<ul class="layui-tab-title">
								<li class="layui-this">发表帖子</li>
							</ul>
							<div class="layui-form layui-tab-content"
								style="padding: 20px 0;">
								<div class="layui-tab-item layui-show">
									<form action="" method="post">
										<div class="layui-row">
											<div class="layui-col-md5">
												<div class="layui-form-item">
													<label class="layui-form-label">帖子分类</label>
													<div class="layui-input-block">
														<select name="type" lay-verify="required">
														<c:forEach items="${list}" var="record">
														<option value="${record.id }">${record.name }</option>
														
														</c:forEach>
															
															
														</select>
													</div>
												</div>
											</div>
										</div>
										<div class="layui-form-item">
											<label class="layui-form-label">标题</label>
											<div class="layui-input-block">
												<input type="text" name="title" lay-verify="required"
													placeholder="" autocomplete="off" value=""
													class="layui-input">
											</div>
										</div>

										<div class="layui-form-item layui-form-text">
											<div class="layui-input-block">
												<textarea name="content" class="layui-textarea" id="edit"
													cols="30" rows="10"></textarea>
											</div>
										</div>
										<div class="layui-form-item">
											<label class="layui-form-label"></label>
											<div class="layui-input-inline">
												<input type="hidden" name="id" value="">
												<button class="layui-btn" lay-filter="article" lay-submit id="aaa">立即发布</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--Pjax End-->
	<div class="fly-footer" style="margin-bottom: 60px;">
		<p>
			2018 &copy; <a href="http://www.ivusic.com/" target="_blank">ivusic.com
				音乐网</a>
		</p>
		<p>
			<a href="/index/link/index.html" data-pjax="">友情链接</a> <a
				href="/index/about.html#about" data-pjax="">关于此网站</a> <a
				href="/index/about.html#other" data-pjax="">免责声明</a> <a
				href="http://www.miitbeian.gov.cn" target="_blank">备案号：粤ICP备17086522号</a>
			<script
				src="https://s13.cnzz.com/z_stat.php?id=1272843078&web_id=1272843078"
				language="JavaScript"></script>
			<script type="text/javascript" src="//js.users.51.la/19383727.js"></script>
		</p>
	</div>


	<!--JAVASCRIPT-->
	<script src="<%=basePath%>/page/static/js/jquery-1.10.2.min.js"></script>
	<script src="<%=basePath%>/page/static/js/jquery.cookie.js"></script>
	<script src="<%=basePath%>/page/static/js/jquery.pjax.js"></script>

	<!-- Bootstrap And Player -->
	<script src="<%=basePath%>/page/static/hack/layui/layui.js"></script>
	<script src="<%=basePath%>/page/static/index/default/js/nifty.min.js"></script>
	<script
		src="<%=basePath%>/page/static/index/default/plugins/nprogress/nprogress.js"></script>
	<script src="<%=basePath%>/page/static/index/jPlayer/bootstrap.js"></script>
	<script
		src="<%=basePath%>/page/static/index/jPlayer/jquery.jplayer.min.js"></script>
	<script
		src="<%=basePath%>/page/static/index/jPlayer/add-on/jplayer.playlist.js"></script>
	<script src="<%=basePath%>/page/static/index/jPlayer/jplayer.init.js"></script>
	<script src="<%=basePath%>/page/static/index/mods/music.js"></script>
	<script src="<%=basePath%>/page/static/index/jPlayer/add-on/config.js"></script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>	
<div class="fly-panel fly-column">
			<div class="layui-container">
				<ul class="layui-clear">
					<li><a href="<%=basePath%>musicInfo/musicInfo_list.do" data-pjax>音乐</a></li>
					<li><a href="<%=basePath%>/title/title_bbsList.do" data-pjax>论坛</a></li>
					<li><a href="./index/news.html" data-pjax>资讯<span
							class="layui-badge-dot"></span></a></li>
					<li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span
						class="fly-mid"></span></li>
					<li class=""><a href="./index/music/index/lang/1/type/1.html"
						data-pjax>中文串烧</a></li>
					<li class=""><a href="./index/music/index/lang/2/type/1.html"
						data-pjax>外文串烧</a></li>
					<li class=""><a href="./index/music/index/scene/1.html"
						data-pjax>电音House</a></li>
					<li><a href="./index/music/index/scene/2.html" data-pjax>酒吧Club</a></li>

					<!-- 用户登入后显示 -->
				</ul>

				<div class="fly-column-right layui-hide-xs">
					<span class="fly-search"></span> <a
						href="<%=basePath%>/title/title_addUI.do" class="layui-btn layui-btn-normal"
						data-pjax="">我要发帖</a>
				</div>
				
			</div>
		</div>
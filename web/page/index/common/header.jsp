<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="fly-header bg-dark">
		<div class="layui-container">
			<a class="fly-logo" href="<%=basePath%>/admin/admin_home.do" data-pjax title="iVusic音乐网">
				<img src="<%=basePath%>/page/static/index/images/ivusic/logo.png"
				alt="ivusic">
			</a>
			<ul class="layui-nav fly-nav layui-hide-xs">
				<li class="layui-nav-item layui-this"><a href="<%=basePath%>/admin/admin_home.do"
					data-pjax><i class="layui-icon">&#xe68e;</i>首页</a></li>
				<li class="layui-nav-item "><a href="./index/music.html"
					data-pjax><i class="layui-icon">&#xe62c;</i>舞曲</a></li>
				<li class="layui-nav-item "><a href="./index/topic.html"
					data-pjax><i class="layui-icon">&#xe6fc;</i>专辑</a></li>
				<li class="layui-nav-item"><a href="./index/link.html"
					data-pjax><i class="layui-icon">&#xe857;</i>导航</a></li>
			</ul>

			<ul class="layui-nav layui-hide-md"
				style="float: right; margin-top: 18px;">
				<li class="layui-nav-item no-nav-more" style="line-height: 30px;">
					<a href="javascript:;"><i class="layui-icon"
						style="font-size: 26px;">&#xe65f;</i></a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a href="<%=basePath%>/admin/admin_userInfo.do" data-pjax>首页</a>
						</dd>
						<dd>
							<a href="./index/music.html" data-pjax>电音</a>
						</dd>
						<dd>
							<a href="./index/topic.html" data-pjax>专辑</a>
						</dd>
						<dd>
							<a href="./index/link.html" data-pjax>导航</a>
						</dd>
						<dd>
							<a href="./index/news.html" data-pjax>资讯</a>
						</dd>
						<dd>
							<a href="./index/article.html" data-pjax>论坛</a>
						</dd>
						<dd>
							<a href="./index/picture.html" data-pjax>美图</a>
						</dd>
						<dd>
							<a href="<%=basePath%>/page/index/user/login.html" data-pjax>登录</a>
						</dd>
						<dd>
							<a href="<%=basePath%>/page/index/user/register.html" data-pjax>注册</a>
						</dd>
					</dl>
				</li>
			</ul>

			<ul class="layui-nav fly-nav-user">
				<!-- 未登入的状态 -->
				<c:if test="${sessionScope.u ==null}">
					<li class="layui-nav-item"><a
						class="iconfont icon-touxiang layui-hide-xs"
						href="./index/user/login.html" data-pjax></a></li>
					<li class="layui-nav-item"><a href="<%=basePath%>/page/index/user/login.html"
						data-pjax>登录</a></li>
					<li class="layui-nav-item"><a href="<%=basePath%>/page/index/user/register.html"
						data-pjax>注册</a></li>
				</c:if>
					              <!-- 登入后的状态 -->
				<c:if test="${sessionScope.u !=null}">	              
	            <li class="layui-nav-item">
	                <a class="fly-nav-avatar" href="<%=basePath%>/admin/admin_userInfo.do" data-pjax >
	                    <cite class="layui-hide-xs">${sessionScope.u.remark}</cite>
	                           <img src="<%=basePath%>/attachment/${sessionScope.u.file}" alt="${sessionScope.u.remark}">
	                </a>
	                <dl class="layui-nav-child">
	                    <dd><a href="<%=basePath%>/admin/admin_userInfo.do" data-pjax><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
	                    <dd><a href="<%=basePath%>/admin/admin_userCenter.do" data-pjax><i class="layui-icon">&#xe620;</i>用户中心</a></dd>
	                    <hr style="margin: 5px 0;">
	                    <dd><a href="<%=basePath%>/admin/admin_logout.do" class="text-center">退出</a></dd>
	                </dl>
	            </li>
	            </c:if>
					
			</ul>
		</div>
	</div>
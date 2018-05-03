<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>${sessionScope.u.remark}</title>
    <jsp:include  page="/page/index/common/common.jsp"/>  
</head>
<body>
<jsp:include  page="/page/index/common/header.jsp"/>  

<div class="page-loading">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
</div>


<!--Pjax Start-->
<div id="container">
    <<div class="fly-home fly-panel"
			style="background-image: url(); margin-bottom: 0;">
			<img src="<%=basePath%>/attachment/${sessionScope.u.file}"
				alt="${sessionScope.u.remark}">
			<h1>
				${sessionScope.u.remark}
				<c:if test="${sessionScope.u.gender==1}">
					<i class="iconfont icon-nan"></i>
				</c:if>
				<c:if test="${sessionScope.u.gender==2}">
					<i class="iconfont icon-nv"></i>
				</c:if>

			</h1>

			<p class="fly-home-info">
				<i class="iconfont icon-shijian"></i><span>${fn:substring(sessionScope.u.accountCreateTime, 0, 10)}
					加入</span>
			</p>

			<p class="fly-home-sign"></p>

			

		</div>
	<div class="fly-panel fly-column">
			<div class="layui-container">
				<ul class="layui-clear" style="text-align: center;">
					<li ><a href="<%=basePath%>/admin/admin_userInfo.do"
						data-pjax>收藏</a></li>
					<li ><a href="<%=basePath%>/admin/admin_works.do" data-pjax>作品</a></li>
					<li class=""><a href="<%=basePath%>/title/title_myTitle.do"
						data-pjax>我的帖子</a></li>
					<li class="layui-this"><a href="<%=basePath%>/admin/admin_fans.do" data-pjax>粉丝</a></li>
				</ul>
			</div>
	</div>
    <div class="layui-container fly-marginTop">
        <div class="fly-panel fly-panel-user" pad20>
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title" id="LAY_mine">
                    <li class="layui-this" lay-id="following">关注</li>
                    <li lay-id="follower">粉丝</li>
                </ul>
                <div class="layui-tab-content" style="padding: 20px 0;">
                    <div class="layui-form-pane layui-tab-item layui-show">
                                                <div class="layui-row layui-col-space15">
                                                
                              <c:forEach items="${fanslist}" var="record">     
                                                        <div class="layui-col-md3">
                                <div class="panel" style="border-bottom-color:#42a5f5;">
                                    <div class="panel-body text-center">
                                        <img alt="Profile Picture" class="img-md img-circle mar-btm" src="<%=basePath%>/attachment/${record.userImg}">
                                        <p class="text-lg text-semibold mar-no text-main">${record.userName}</p>
                                        <button class="btn btn-primary mar-ver fansThis" data-id="${record.id}">取消关注</button>
                                        <ul class="list-unstyled text-center bord-top pad-top mar-no row">
                                            <li class="col-xs-6">
                                                <span class="text-lg text-semibold text-main">0</span>
                                                <p class="text-muted mar-no">关注</p>
                                            </li>
                                            <li class="col-xs-6">
                                                <span class="text-lg text-semibold text-main">1</span>
                                                <p class="text-muted mar-no">粉丝</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                                                        <div class="text-center">
                                                            </div>
                        </div>
                                            </div>
                    <div class="layui-form-pane layui-tab-item">
                       <div class="layui-row layui-col-space15">
                                                <c:forEach items="${followlist}" var="record">     
                                                        <div class="layui-col-md3">
                                <div class="panel" style="border-bottom-color:#42a5f5;">
                                    <div class="panel-body text-center">
                                        <img alt="Profile Picture" class="img-md img-circle mar-btm" src="<%=basePath%>/attachment/${record.followImg}">
                                        <p class="text-lg text-semibold mar-no text-main">${record.followName}</p>
                                        <button class="btn btn-primary mar-ver fansThis" data-id="${record.id}">进入主页</button>
                                        <ul class="list-unstyled text-center bord-top pad-top mar-no row">
                                            <li class="col-xs-6">
                                                <span class="text-lg text-semibold text-main">0</span>
                                                <p class="text-muted mar-no">关注</p>
                                            </li>
                                            <li class="col-xs-6">
                                                <span class="text-lg text-semibold text-main">1</span>
                                                <p class="text-muted mar-no">粉丝</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            </div>
                                            </div>
                </div>

            </div>
        </div>

    </div>
</div>
<div class="fly-footer" style="margin-bottom: 60px;">
    <p> 2018 &copy; <a href="http://www.ivusic.com/" target="_blank">ivusic.com 音乐网</a></p>
    <p>
        <a href="/index/link/index.html" data-pjax="">友情链接</a>
        <a href="/index/about.html#about" data-pjax="">关于此网站</a>
        <a href="/index/about.html#other" data-pjax="">免责声明</a>
        <a href="http://www.miitbeian.gov.cn" target="_blank">备案号：粤ICP备17086522号</a>
    </p>
</div>



</body>
</html>
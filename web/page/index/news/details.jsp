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
    <title>test - 做全网最好的DJ音乐站</title>
    <jsp:include page="/page/index/common/common.jsp" />
</head>
<body >

<div class="fly-header bg-dark">
   	<jsp:include page="/page/index/common/header.jsp" />
</div>

<div class="page-loading">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
</div>

<!--Pjax Start-->
<div id="container">
    	<jsp:include page="/page/index/common/header2.jsp" />
    <div class="layui-container">
        <div id="primary" class="primary" role="main">
            <div class="area">
                <article>
                    <header class="single-header">
                        <div class="single-meta">
                            <div class="author-avatar">
                                <a href="/index/user/index/id/111.html" title=" ${result.username}的主页" rel="author" data-pjax="">
                                    <img src="<%=basePath%>/attachment/2.png" class="avatar" alt="哇哈哈" width="70" height="70">
                                </a>
                            </div>
                                                        <h1 class="title">${result.title}</h1>
                                                        <p class="info">
                            
                            </p>
                        </div>
                        <div class="data-meta">
                          
                            <p>
                            <span class="author">
                                <a href="/index/user/index/id/111.html" title="查看 ${result.username}发表的全部小纸条" rel="author" data-pjax=""> ${result.username} </a>
                                发布于 <time class="data-time">${result.datetime}</time>
                            </span>
                                <span class="comments-link">
                              
                            </span>
                            </p>
                        </div>
                    </header>
                    <div class="single-content-wrapper">
                        <div class="single-content photos">
                                                        <b>${result.content}</b>                        </div>
                    </div>
               
                </article>
            </div>
              
                        <div class="area">

            </div>
        </div>
    </div>
</div>
<!--Pjax End-->
<div class="fly-footer" style="margin-bottom: 60px;">
    <p> 2018 &copy; <a href="http://www.ivusic.com/" target="_blank">ivusic.com 音乐网</a></p>
    <p>
        <a href="/index/link/index.html" data-pjax="">友情链接</a>
        <a href="/index/about.html#about" data-pjax="">关于此网站</a>
        <a href="/index/about.html#other" data-pjax="">免责声明</a>
        <a href="http://www.miitbeian.gov.cn" target="_blank">备案号：粤ICP备17086522号</a>
        <script src="https://s13.cnzz.com/z_stat.php?id=1272843078&web_id=1272843078" language="JavaScript"></script>
        <script type="text/javascript" src="//js.users.51.la/19383727.js"></script>
    </p>
</div>



</body>
</html>
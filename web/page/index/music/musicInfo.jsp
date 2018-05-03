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
<title>${result.musicname} - 做全网最好的DJ音乐站</title>
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
		<jsp:include  page="/page/index/common/header2.jsp"/>  
		<div class="layui-container">
			<div class="layui-row layui-col-space15">
				<div class="layui-col-md12">
					<div class="data-cover">
						<img src="<%=basePath%>/attachment/b.jpg"
							alt="${result.musicname}" class="data-img">
					</div>
					<div class="data-cont">
						<h3>${result.musicname}</h3>
						<div class="data-info">
							<ul>
								<li>编号：${result.id}</li>
								<li>歌名：${result.musicname}</li>
								<li>类型：${result.types}</li>
								<li>作词者：${result.zuociz}</li>
								<li>发布者：${result.username}</li>
								<li>演唱者：${result.ycz}</li>
								<li>人气：${result.renqi}</li>
								<li>发布时间：${result.date}</li>
							</ul>
						</div>
						<div class="data-btn">
							<button class="layui-btn SMPlay" data-id="${result.id}">
								<i class="layui-icon">&#xe652;</i> 播放
							</button>
							<button class="layui-btn collectThis" data-id="${result.id}"
								data-mid="4">
								<c:if test="${flag==1}">
									<i class="layui-icon" >&#xe658;</i> 取消收藏
								</c:if>
								<c:if test="${flag==0}">
									<i class="layui-icon" >&#xe600;</i> 收藏
								</c:if>
							</button>
							<a href="#comments" class="layui-btn"> <i class="layui-icon">&#xe63a;</i>
								评论(<font id="pinglunshu">${size}</font>)
							</a>
						</div>
					</div>
				</div>

				<div class="layui-col-md8">
					<div class="layui-card">
						<div class="layui-card-header">歌词</div>
						<div class="layui-card-body">${result.content}</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-card" id="like">
						<div class="layui-card-header">喜欢这首歌的人</div>
						<div class="layui-card-body">
						 <c:choose>
                            	<c:when test="${empty result}">
									<div class="fly-none">暂时没有数据</div>
								</c:when>
								<c:otherwise>
								<c:forEach items="${list}" var="record">
								 <div class="comment-author vcard">
                                <a target="_blank" title="" href="<%=basePath %>admin/admin_userInfoById.do?username=${record.stuid}">
                                <img src="<%=basePath %>/attachment/${record.img}" class="avatar" width="44" height="44">
                                
                                <span class="author"><cite>${record.stuname}</cite></span>
                                </a> </div>
                                
								</c:forEach>
								</c:otherwise>
						</c:choose>
						
							 </div>
						</div>
					</div>
				</div>
				<div class="layui-col-md12">
					<div id="primary">
						<div class="area">
							<div id="comments" class="comments">
							<h2 class="comments-title" style="padding-top: 0">
										全部足迹 / <strong>${size}</strong>
									</h2>
								
									
									<ol class="comment-list">
									<c:forEach items="${result2}" var="record">
									<li class="comment even thread-even depth-1"><div class="comment-body"> 
                                <div class="comment-author vcard">
                                <a target="_blank" title="" href="<%=basePath %>admin/admin_userInfoById.do?username=${record.pinlunid}">
                                <img src="<%=basePath %>/attachment/${record.img}" class="avatar" alt="${record.pinglunname }" width="44" height="44">
                                </a> </div>
                                <div class="comment-main"> <p>${record.content} </p> 
                                <div class="comment-meta"> <span class="author"><cite>${record.pinglunname}</cite></span>
                                <span class="date">${record.date}</span><c:if test="${sessionScope.u ==null}"><span class="reply user-signin"><a class="comment-reply-login" href="<%=basePath%>/page/index/user/login.html">登录以回复</a></span> </c:if></div> </div> <div class="comment-floor">${record.last}楼</div> </div> </li>
									  
									
									</c:forEach>
									</ol>
									<c:if test="${sessionScope.u !=null}">
									<div class="layui-timeline-content layui-text">
										<textarea name="desc" id="desc" placeholder="喜欢就评论的吧."
											class="layui-textarea"></textarea>
										<div style="margin-top: 10px;">
											<a href="javascript:void(0)" data-id="${result.id}"
												data-mid="${sessionScope.u.remark}"
												data-file="${sessionScope.u.file}"
												data-userId="${sessionScope.u.username}"
												data-musicname="${result.musicname}"
												 data-elem="#desc"
												class="layui-btn layui-btn-normal self-btn" id="setComment">发表评论</a>
										</div>
									</div>
									<div class="text-center pagePjax"></div>

								</c:if>
								<c:if test="${sessionScope.u ==null}">
									<div class="comment-respond">
										<p class="must-log-in">
											登录之后才能评论，请点击 <a class="user-signin"
												href="<%=basePath%>/page/index/user/login.html" data-pjax="">登录</a>。
										</p>
									</div>
									<div class="text-center pagePjax"></div>

								</c:if>
							</div>

						</div>
						<div class="text-center pagePjax"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--Pjax Start-->


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
	<footer class="footer hidden bg-dark"
		style="background-image: linear-gradient(60deg, #29323c 0%, #485563 100%);">
		<!--播放器背景色-->
		<div class="layui-container">
			<div id="jp_container_N">
				<div class="jp-type-playlist">
					<div id="jplayer_N" class="jp-jplayer layui-hide"></div>
					<div class="jp-gui">
						<div class="jp-video-play layui-hide">
							<a class="jp-video-play-icon">play</a>
						</div>
						<div class="jp-interface">
							<div class="jp-controls">
								<div>
									<a class="jp-previous"><i class="icon-control-rewind i-lg"></i></a>
								</div>
								<div>
									<a class="jp-play"><i class="icon-control-play i-2x"></i></a> <a
										class="jp-pause hid"><i class="icon-control-pause i-2x"></i></a>
								</div>
								<div>
									<a class="jp-next"><i class="icon-control-forward i-lg"></i></a>
								</div>
								<div class="layui-hide">
									<a class="jp-stop"><i class="fa fa-stop"></i></a>
								</div>
								<div>
									<a class="" data-toggle="dropdown" data-target="#playlist"><i
										class="icon-list"></i></a>
								</div>
								<div class="jp-progress layui-hide-xs">
									<div class="jp-seek-bar layui-bg-cyan">
										<!--进度条背景色-->
										<div class="jp-play-bar layui-bg-green"
											style="background-image: linear-gradient(to right, #48c6ef 0%, #6f86d6 100%);"></div>
										<!--播放条颜色-->
										<!--background-image: linear-gradient(-225deg, #22E1FF 0%, #1D8FE1 48%, #625EB1 100%);-->
										<!--background-image: linear-gradient(to right, #209cff 0%, #68e0cf 100%);-->
										<div class="jp-title text-lt">
											<ul>
												<li></li>
											</ul>
										</div>
									</div>
								</div>
								<div
									class="layui-hide-xs hidden-sm jp-current-time text-xs text-muted"></div>
								<div
									class="layui-hide-xs hidden-sm jp-duration text-xs text-muted"></div>
								<div class="layui-hide-xs hidden-sm layui-hide">
									<a class="jp-mute" title="mute"><i class="icon-volume-2"></i></a>
									<a class="jp-unmute hid" title="unmute"><i
										class="icon-volume-off"></i></a>
								</div>
								<div class="layui-hide-xs hidden-sm jp-volume layui-hide">
									<div class="jp-volume-bar layui-bg-cyan">
										<!--音量背景色-->
										<div class="jp-volume-bar-value layui-bg-green"
											style="background-image: linear-gradient(to right, #48c6ef 0%, #6f86d6 100%);"></div>
										<!--音量选中颜色-->
									</div>
								</div>
								<!--收藏歌曲-->
								<div>

									<a href="javascript:;" class="active collectThis jp-love"
										data-toggle="class" data-id="0" data-mid="4"> <i
										class="fa fa-star-o text-active"></i> <i
										class="fa fa-check-circle text-warning text"></i>
									</a>
								</div>
								<!--查看歌曲-->
								<div>
									<a href="javascript:void(0)" class="jp-look" title="查看"
										data-pjax=""><i class="fa fa-music text-lt"></i></a>
								</div>
								<!--下载歌曲-->
								<div>
									<a href="javascript:void(0)" class="jp-downloads" title="下载"
										data-pjax=""><i class="fa fa-cloud-download text-lt"></i></a>
								</div>
								<!--清空播放列表-->
								<div>
									<a href="javascript:void(0)" class="jp-clear" title="清空播放列表"
										data-pjax=""><i class="fa fa-trash text-lt"></i></a>
								</div>
								<!--播放模式-->
								<div class="layui-hide">
									<a class="jp-shuffle" title="随机播放"><i
										class="icon-shuffle text-muted"></i></a> <a
										class="jp-shuffle-off hid" title="shuffle off"><i
										class="icon-shuffle text-lt"></i></a>
								</div>
								<!--重复播放-->
								<div class="layui-hide">
									<a class="jp-repeat" title="重复播放"><i
										class="icon-loop text-muted"></i></a> <a class="jp-repeat-off hid"
										title="repeat off"><i class="icon-loop text-lt"></i></a>
								</div>
								<div class="layui-hide">
									<a class="jp-full-screen" title="full screen"><i
										class="fa fa-expand"></i></a> <a class="jp-restore-screen"
										title="restore screen"><i class="fa fa-compress text-lt"></i></a>
								</div>
							</div>
						</div>
					</div>
					<div class="jp-playlist dropup" id="playlist">
						<ul class="dropdown-menu aside-xl animated slideInUp"
							style="background-image: linear-gradient(60deg, #29323c 0%, #485563 100%);">
							<!--列表背景色-->
							<!--bounceIn -->
							<!-- The method Playlist.displayPlaylist() uses this unordered list -->
							<li class="list-group-item"></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>
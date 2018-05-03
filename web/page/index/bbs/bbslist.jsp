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
<script type="text/javascript">
				function toPage(pageNum){
					var url = "title/title_bbsList.do?curPage="+pageNum;
					self.location.href = encodeURI(url);
				}
				
				
			</script>
<meta charset="utf-8">
<title>音乐论坛 - 做全网最好的DJ音乐站</title>
<jsp:include page="/page/index/common/common.jsp" />
</head>
<body>

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
			<div class="layui-row layui-col-space15">
				<div class="layui-col-md8">
					<div class="layui-card">
						<div class="layui-card-header">置顶</div>
						<div class="layui-card-body">
							<ul class="fly-list">

								<li><a href="/index/user/index/id/1.html"
									class="fly-avatar" data-pjax=""> <img
										src="<%=basePath%>/page/static/admin/img/profile-photos/1.png"
										alt="管理员">
								</a>
									<h2>
										<a class="layui-badge">发烧天碟</a> <a
											href="/index/article/show/id/2.html" data-pjax="">【女声雅韵系列】精选女声合集
											21-30 iVusic音乐网</a>
									</h2>
									<div class="fly-list-info">
										<a href="/index/user/index/id/1.html" data-pjax=""> <cite>管理员</cite>
										</a> <span>01月30日</span>

										<!--<span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i class="iconfont icon-kiss"></i> 60</span>-->
										<span class="fly-list-nums"><i
											class="iconfont icon-pinglun1" title="回答"></i> 0</span>
									</div>
									<div class="fly-list-badge">
										<span class="layui-badge layui-bg-red">精华</span>
									</div></li>

							</ul>
						</div>
					</div>

					<div class="layui-card">
						<div class="layui-card-header">
							<div class="fly-panel-title fly-filter">
								<a href="<%=basePath%>title/title_bbsList.do" class="layui-this"
									data-pjax="">综合</a>
								<c:forEach items="${classlist}" var="record">
									<span class="fly-mid"></span>
									<a href="<%=basePath%>title/title_bbsList.do?type=${record.id}"
										class="" data-pjax="">${record.name}</a>
								</c:forEach>
								<span class="fly-mid"></span> <a
									href="/index/article/index/rank/1.html" class="" data-pjax="">精华</a>
								<span class="fly-mid"></span> <a
									href="/index/article/index/rank/2.html" class="" data-pjax="">热门</a>

							</div>
						</div>
						<div class="layui-card-body">
							<ul class="fly-list">
								<c:forEach items="${result}" var="record">
									<li><a href="/index/user/index/id/1.html"
										class="fly-avatar" data-pjax=""> <img
											src="<%=basePath%>/attachment/${record.img}">
									</a>
										<h2>
											<c:forEach items="${classlist}" var="type">
												<c:if test="${type.id==record.type}">
													<a class="layui-badge">${type.name }</a>
												</c:if>

											</c:forEach>

											<a
												href="<%=basePath %>title/title_bbsDetail.do?id=${record.id }"
												title="title"> ${record.title}</a>
										</h2>
										<div class="fly-list-info">
											<a href="/index/user/index/id/1.html" data-pjax=""> <cite>${record.username}
											</cite>
											</a> <span>${record.datetime}</span> <span class="fly-list-nums"><i
												class="iconfont icon-pinglun1" title="回答"></i>
												${record.count}</span>
										</div></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="text-center pagePjax">
						<ul class="pagination">${pageInfo}
						</ul>
					</div>
				</div>

				<div class="layui-col-md4">

					<div class="layui-card">
						<div class="layui-card-header">活跃用户</div>
						
						<div class="layui-card-body fly-rank fly-rank-reply">
								<c:if test="${empty hot}">
									<div class="fly-none">暂时没有数据</div>
								</c:if>
								<c:if test="${!empty hot}">
								<c:forEach items="${hot}" var="record">
								 <div class="comment-author vcard">
                                <a target="_blank" title="" href="<%=basePath %>admin/admin_userInfoById.do?username=${record.userid}">
                                <img src="<%=basePath %>/attachment/${record.img}" class="avatar" width="44" height="44">
                                
                                <span class="author"><cite>${record.username}</cite></span>
                                </a> </div>
                                
								</c:forEach>
								</c:if>
						</div>
					</div>

					<div class="layui-card">
						<div class="layui-card-header">友情链接</div>
						<div class="layui-card-body">
							<a href="javascript:;"
								onclick="layer.tips('虚席以待.', this, {tips:1})" target="_blank"
								class="layui-btn layui-btn-normal"
								style="width: 100%; margin: 5px 0;">虚席以待</a> <a
								href="javascript:;"
								onclick="layer.tips('虚席以待.', this, {tips:1})" target="_blank"
								class="layui-btn layui-btn-normal"
								style="width: 100%; margin: 5px 0;">虚席以待</a> <a
								href="javascript:;"
								onclick="layer.tips('虚席以待.', this, {tips:1})" target="_blank"
								class="layui-btn layui-btn-normal"
								style="width: 100%; margin: 5px 0;">虚席以待</a>
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
	<script type="text/javascript"
		src="<%=basePath %>plugin_js/bbss/title.js"></script>


</body>
</html>
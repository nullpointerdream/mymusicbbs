<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="baidu-site-verification" content="Z6vOHj2Lpk" />
<title>iVusic - 做全网最好的DJ音乐站</title>
<%@ include file="/page/index/common/common.jsp"%>

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
				<div class="layui-col-md8">
					<div class="layui-carousel" id="indexCarouse">
						<div carousel-item>
							<div>
								<a href="http://www.ivusic.com/index/news/show/id/10.html"
									target="self" data-pjax title="网站链接 网站导航"><img
									src="<%=basePath%>/page/uploads/20180319/b524252139956f370217818fa209d80f.jpg"
									alt=""></a>
							</div>
							<div>
								<a href="http://music.163.com/song?id=544247523" target="self"
									data-pjax title="网易云音乐"><img
									src="<%=basePath%>/page/uploads/20180319/22803cf6906ee38f00ace612ad556147.png"
									alt=""></a>
							</div>
							<div>
								<a href="http://music.163.com/#/topic?id=18818108" target="self"
									data-pjax title="网易云音乐"><img
									src="<%=basePath%>/page/uploads/20180319/756ca8816201110eadd55c85a2df7f99.png"
									alt=""></a>
							</div>
							<div>
								<a href="http://music.163.com/store/newalbum/detail?id=37548020"
									target="self" data-pjax title="网易云音乐"><img
									src="<%=basePath%>/page/uploads/20180319/d7aa082856cbe394de500d5afc18a048.png"
									alt=""></a>
							</div>
							<div>
								<a href="http://music.163.com/mv?id=5853072" target="self"
									data-pjax title="网易云音乐"><img
									src="<%=basePath%>/page/uploads/20180319/a79a92a7afa8f3a997fcc04c8c3ecf3c.png"
									alt=""></a>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-card">
						<div class="layui-card-header">最新动态</div>
						<div class="layui-card-body">
							<ul class="fly-list-static">
							<c:forEach items="${result2}" var="record">
									<li><a href="<%=basePath %>news/news_detail4front.do?id=${record.id }" data-pjax>${record.title}</a></li>
								</c:forEach>

							</ul>
						</div>
					</div>

					<div class="layui-card"></div>

				</div>

				<div class="layui-col-md12">
					<div class="layui-tab layui-tab-brief" lay-filter="musicTabBrief">
						 <ul class="layui-tab-title">
                        <li class="layui-this">推荐</li>
                        <li class="pull-right"><a href="<%=basePath%>musicInfo/musicInfo_list.do" data-pjax="">更多</a></li>
                    </ul>

						<div class="layui-tab-content" style="padding: 0">
							<div class="layui-tab-item layui-show">
								<div class="layui-row">
									<div class="layui-col-md12">
										<table class="layui-table" lay-skin="line"
											style="border-right: none;">
											<%-- <colgroup>
												<col width="">
												<col width="80">
											</colgroup> --%>
											<thead>
												<tr>
													<th>歌曲名称</th>
													<th>演唱者</th>
													<th>人气</th>
													<th>上传时间</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${result}" var="record">
													<tr>
														<td><a href="<%=basePath%>musicInfo/musicInfo_musicInfo.do?id=${record.id }" title="${record.musicname }">${record.musicname }</a></td>
														<td style="max-width: 400px;" class="layui-elip"><a
															href="<%=basePath %>admin/admin_userInfoById.do?username=${record.username}"
															 >
																${record.username}(${record.types})
																</a></td>
														<td><i class="fa fa-fire" style="color:red"></i> ${record.renqi} </td>
														<td>${record.date} </td>
														<td><%-- <a href="javascript:;"
															onclick="gotoEdit('<%=basePath%>musicInfo/musicInfo_shoucang.do?id=${record.id }')"
															class="active collectThis" data-toggle="class"
															data-id="${record.id}" data-mid="4"> <i
																class="fa fa-star-o text-active"></i> <i
																class="fa fa-check-circle text-warning text"></i>
														</a> --%> <a
															class="SMPlay" data-id="${record.id }" title="播放"
															><i
																class="fa fa-headphones"></i></a>
														<a href="<%=basePath %>musicInfo/musicInfo_xiazai.do?name=${record.file}" title="下载"><i class="fa fa-cloud-download"></i></a>
														</td>
													</tr>
												</c:forEach>

											</tbody>
										</table>
									</div>

								</div>
							</div>


						</div>
					</div>
				</div>


				<div class="layui-col-md12">
					<fieldset class="layui-elem-field layui-field-title alone-title"
						style="width: 400px; text-align: center; margin: 0 auto 20px;">
						<legend>社团成员</legend>
					</fieldset>
					<div class="layui-row layui-col-space15">
						<c:forEach items="${result3}" var="record">
						   <div class="layui-col-md3">
							<div class="panel">
								<div class="panel-body text-center">
									<img alt="${record.remark}" class="img-lg img-circle mar-btm"
										src="<%=basePath %>attachment/${record.file}">
									<p class="text-lg text-semibold mar-no text-main">${record.remark}&nbsp;  新入住 </p>
									<div class="text-muted" style="min-height: 50px;">
										<p>性别：<c:if test="${record.gender==1}">男</c:if><c:if test="${record.gender==2}">女</c:if></p>
									<p>${fn:substring(record.accountCreateTime, 0, 10)}</p>

									</div>
									<div class="mar-top">
										<a  href="<%=basePath %>admin/admin_detail4front.do?username=${record.username}" data-pjax=""
											class="btn btn-mint">他的主页</a>
									</div>
								</div>
							</div>
						</div>
						</c:forEach>

					</div>
				</div>

				<div class="layui-col-md12">
					<fieldset class="layui-elem-field layui-field-title alone-title"
						style="width: 400px; text-align: center; margin: 0 auto 0;">
						<legend>伟大的思想能变成巨大的财富</legend>
					</fieldset>
					<div style="margin-top: 20px; text-align: center;">
						<p style="font-weight: 300;">偏听则暗，兼听则明</p>
						<a href="./index/about.html#comment"
							class="layui-btn layui-btn-danger mar-top" data-pjax>不妨提出</a>
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
			<a href="./index/link/index.html" data-pjax="">友情链接</a> <a
				href="./index/about.html#about" data-pjax="">关于此网站</a> <a
				href="./index/about.html#other" data-pjax="">免责声明</a> <a
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


	<script src="<%=basePath%>/page/static/index/jPlayer/jplayer.init.js"></script>



</body>
</html>
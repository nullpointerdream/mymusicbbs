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
<title>全网最好DJ曲库 - 做全网最好的DJ音乐站</title>
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
				<div class="layui-col-md8">
					<div class="layui-card">
						<div class="layui-card-header">舞曲类别</div>
						<div class="layui-card-body">

							<p class="text-semibold text-main">精确搜索</p>
							<div class="pad-ver bord-top">
								<form action="<%=basePath%>/musicInfo/musicInfo_list.do"
									class="form-inline layui-form" method="get" data-pjax>
									<div class="form-group">
										<label for="keywords" class="sr-only">精确搜索</label> <input
											type="text" name="musicname" value="${musicname }"
											placeholder="可搜索关键词" id="keywords" class="form-control"
											style="height: 33px;" lay-verify="required">
									</div>
									<button type="submit" class="btn btn-primary">搜索</button>
								</form>
							</div>


						</div>
					</div>

					<table class="layui-table setClick" lay-skin="line">
						<colgroup>
						</colgroup>
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
				 <div class="text-center pagePjax">
						 <div class="pagination">${pageInfo }</div>
										<div class="clear"></div>
                           <!--  <ul class="pagination"><li class="disabled"><span>&laquo;</span></li> <li class="active"><span>1</span></li><li><a href="/index/user/love/id/125.html?music=2#music">2</a></li><li><a href="/index/user/love/id/125.html?music=3#music">3</a></li><li><a href="/index/user/love/id/125.html?music=4#music">4</a></li><li><a href="/index/user/love/id/125.html?music=5#music">5</a></li> <li><a href="/index/user/love/id/125.html?music=2#music">&raquo;</a></li></ul>                        </div> -->
                                                <!--歌曲列表 END-->
                    </div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-card">
						<div class="layui-card-header">推荐网站</div>
						<div class="layui-card-body">
							<a href="http://www.kekedj.com" target="_blank"
								class="layui-btn layui-btn-lg"
								style="width: 100%; margin: 5px 0; background: #509524">一个极具潜力的音乐站</a>
							<a href="http://www.cfchi.com/cp.html" target="_blank"
								class="layui-btn layui-btn-lg"
								style="width: 100%; margin: 5px 0; background: #f2405b; padding:">简单
								● 易用的操盘系统</a>
						</div>
					</div>


					<div class="layui-card">
						<div class="layui-card-header">每周榜单</div>
						<div class="layui-card-body">
							<ul class="fly-panel-main fly-list-static">
								<li><a href="javascript:;" class="SMPlay" data-id="48967">【第016批
										前场串烧】前场待客蓝调串烧A =kekedj=</a></li>
								<li><a href="javascript:;" class="SMPlay" data-id="48793">郁南DJ筱何-全中文Club精选国粤语2018让你体面广东爱情故事慢摇串烧</a></li>
								<li><a href="javascript:;" class="SMPlay" data-id="48966">【第016批
										前场串烧】全英文RNB音乐酒吧早场待客必备舒服蓝调串烧 =kekedj=</a></li>
								<li><a href="javascript:;" class="SMPlay" data-id="10105">99_dj杰伦-muse超叼e-d-m爆场精品歌路
										22 nicolaz riot loun original detent[总舵主ayan]</a></li>
								<li><a href="javascript:;" class="SMPlay" data-id="48039">011.汕头U8
										Club女Dj好好定制气氛唱腔榜单歌路=KEKEDJ=</a></li>
								<li><a href="javascript:;" class="SMPlay" data-id="47337">04m
										- 新版 Maroon5 - Animals (Jin Bootleg)(可可DJ Music音乐厂牌)</a></li>
							</ul>
						</div>
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
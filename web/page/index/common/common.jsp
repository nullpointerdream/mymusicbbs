<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords"
	content="ivusic,音乐网,最新DJ,DJ资源,最全音乐,Layui DJ网,专业DJ,电音,专辑,极简DJ,流畅体验,DJ论坛">
<meta name="description"
	content="iVusic 音乐网基于 Layui 前端框架开发，颠覆传统凌乱复杂网站，旨在极简的DJ音乐网体验，全站收录最新最全的DJ资源与音乐资讯，为喜好DJ的用户提供最好的音乐盛宴。">
<link rel="icon" href="favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/page/static/index/jPlayer/jplayer.flat.css" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/page/static/index/jPlayer/css/animate.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/page/static/index/jPlayer/css/simple-line-icons.css" />

<!--STYLESHEET-->
<link
	href="<%=basePath%>/page/static/index/default/css/bootstrap.min.css"
	rel="stylesheet">
<link href='<%=basePath%>/page/static/index/default/css/font-face.css'
	rel='stylesheet' type='text/css'>
<link href="<%=basePath%>/page/static/index/default/css/nifty.min.css"
	rel="stylesheet">
<link
	href="<%=basePath%>/page/static/index/default/plugins/nprogress/nprogress.css"
	rel="stylesheet">
<link
	href="<%=basePath%>/page/static/index/default/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="<%=basePath%>/page/static/hack/layui/css/layui.css"
	rel="stylesheet">
<link href="<%=basePath%>/page/static/index/css/global.css"
	rel="stylesheet">
	
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
	<script src="<%=basePath%>/page/static/index/jPlayer/add-on/config.js"></script>
    <script src="<%=basePath%>/page/static/index/jPlayer/add-on/jplayer.playlist.js"></script>
	<script src="<%=basePath%>/page/static/index/jPlayer/jplayer.init.js"></script>
	<script src="<%=basePath%>/page/static/index/mods/music.js"></script>


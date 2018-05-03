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
    <title>用户中心  - 做全网最好的DJ音乐站</title>
    <jsp:include  page="/page/index/common/common.jsp"/>  
    
    <style>
    	.layui-form-item .layui-input-inline {
    		width: 400px;
    	}
    </style>
</head>
<body>

<div class="fly-header bg-dark">
    <jsp:include  page="/page/index/common/header.jsp"/>  
</div>

<div class="page-loading">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
</div>

<!--Pjax Start-->
<div id="container">
    <div class="fly-home fly-panel" style="background-image: url();margin-bottom: 0;">
   <img src="<%=basePath%>/attachment/${sessionScope.u.file}" alt="${sessionScope.u.remark}">
    <h1>
        ${sessionScope.u.remark}      
        <c:if test="${sessionScope.u.gender==1}"> <i class="iconfont icon-nan"></i></c:if>
        <c:if test="${sessionScope.u.gender==2}"> <i class="iconfont icon-nv"></i></c:if>
       
            </h1>
    <p class="fly-home-info">
        <i class="iconfont icon-shijian"></i><span>${sessionScope.u.accountCreateTime} 加入</span>
    </p>

    <!-- <div class="fly-sns" data-user="">
        <a href="javascript:;" class="layui-btn layui-btn-primary" onclick="layer.tips('稍后推出.', this, {tips:4})"><i class="layui-icon">&#xe63a;</i>聊天</a>
            </div> -->

</div>
    <div class="layui-container fly-marginTop">

        <div class="fly-panel fly-panel-user" pad20 id="containerUserNav">
            <div class="fly-msg" style="margin: 20px 0;"> Hi，${sessionScope.u.remark}，你已是我们的。</div>
                        <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title" id="LAY_mine">
                    <li lay-id="info">我的资料</li>
                    <li lay-id="pass">密码</li>
                </ul>
                <div class="layui-tab-content" style="padding: 20px 0;">
                    <div class="layui-form layui-form-pane layui-tab-item">
                        <form action="<%=basePath%>/admin/admin_update2.do" method="post" >
                        <div class="layui-form-item">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text"  autocomplete="off" value="${sessionScope.u.username}" disabled class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="email" required lay-verify="email" autocomplete="off" value="${sessionScope.u.email}" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">电话</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="telephone" required lay-verify="phone" autocomplete="off" value="${sessionScope.u.telephone}" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">昵称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="remark" required lay-verify="required" autocomplete="off" value="${sessionScope.u.remark}" class="layui-input">
                                </div>
                            </div>
                        <div class="layui-form-item">
                            <div class="avatar-add">
                                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过500KB</p>
                                <button type="button" class="layui-btn upload-img">
                                    <i class="layui-icon">&#xe67c;</i>上传头像
                                </button>
                                   <input type="hidden" name="fileFileName" id="fileFileName" value="${sessionScope.u.file}" class="layui-input">
                                <img src="<%=basePath%>/attachment/${sessionScope.u.file}" id="fileFileNamesrc">
                                <span class="loading"></span>
                            </div>
                        </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" lay-filter="*" lay-submit>确认修改</button>
                            </div>
                        </form>
                    </div>

                   

                    <div class="layui-form layui-form-pane layui-tab-item">
                        <form action="<%=basePath%>/admin/admin_changePassword.do" method="post">
                            <div class="layui-form-item">
                                <label class="layui-form-label">当前密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="oldpassword" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="newpassword" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">确认密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="confirm" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit alert="">确认修改</button>
                            </div>
                        </form>
                    </div>

                    <div class="layui-form layui-form-pane layui-tab-item">
                        <ul class="app-bind">
                            <li class="fly-msg app-havebind">
                                <i class="iconfont icon-qq"></i>
                                                                <a href="/index/user/QQLogin.html" onclick="layer.msg('正在绑定QQ', {icon:16, shade: 0.1, time:0})" class="acc-bind" type="qq_id">立即绑定</a>
                                <span>，即可使用QQ帐号登录Fly社区</span>
                                                            </li>
                        </ul>
                    </div>

                    <div class="layui-form layui-form-pane layui-tab-item">

                    </div>
                </div>

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
<footer class="footer hidden bg-dark" style="background-image: linear-gradient(60deg, #29323c 0%, #485563 100%);"> <!--播放器背景色-->
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
                            <div><a class="jp-previous"><i class="icon-control-rewind i-lg"></i></a>
                            </div>
                            <div>
                                <a class="jp-play"><i class="icon-control-play i-2x"></i></a>
                                <a class="jp-pause hid"><i class="icon-control-pause i-2x"></i></a>
                            </div>
                            <div><a class="jp-next"><i class="icon-control-forward i-lg"></i></a></div>
                            <div class="layui-hide"><a class="jp-stop"><i class="fa fa-stop"></i></a></div>
                            <div><a class="" data-toggle="dropdown" data-target="#playlist"><i class="icon-list"></i></a></div>
                            <div class="jp-progress layui-hide-xs">
                                <div class="jp-seek-bar layui-bg-cyan"> <!--进度条背景色-->
                                    <div class="jp-play-bar layui-bg-green" style="background-image: linear-gradient(to right, #48c6ef 0%, #6f86d6 100%);"></div> <!--播放条颜色-->
                                    <!--background-image: linear-gradient(-225deg, #22E1FF 0%, #1D8FE1 48%, #625EB1 100%);-->
                                    <!--background-image: linear-gradient(to right, #209cff 0%, #68e0cf 100%);-->
                                    <div class="jp-title text-lt"><ul><li></li></ul></div>
                                </div>
                            </div>
                            <div class="layui-hide-xs hidden-sm jp-current-time text-xs text-muted"></div>
                            <div class="layui-hide-xs hidden-sm jp-duration text-xs text-muted"></div>
                            <div class="layui-hide-xs hidden-sm layui-hide">
                                <a class="jp-mute" title="mute"><i class="icon-volume-2"></i></a>
                                <a class="jp-unmute hid" title="unmute"><i class="icon-volume-off"></i></a>
                            </div>
                            <div class="layui-hide-xs hidden-sm jp-volume layui-hide">
                                <div class="jp-volume-bar layui-bg-cyan">   <!--音量背景色-->
                                    <div class="jp-volume-bar-value layui-bg-green" style="background-image: linear-gradient(to right, #48c6ef 0%, #6f86d6 100%);"></div> <!--音量选中颜色-->
                                </div>
                            </div>
                            <!--收藏歌曲-->
                            <div>

                                <a href="javascript:;" class="active collectThis jp-love" data-toggle="class" data-id="0" data-mid="4">
                                    <i class="fa fa-star-o text-active"></i>
                                    <i class="fa fa-check-circle text-warning text"></i>
                                </a>
                            </div>
                            <!--查看歌曲-->
                            <div>
                                <a href="javascript:void(0)" class="jp-look" title="查看" data-pjax=""><i class="fa fa-music text-lt"></i></a>
                            </div>
                            <!--下载歌曲-->
                            <div>
                                <a href="javascript:void(0)" class="jp-downloads" title="下载" data-pjax=""><i class="fa fa-cloud-download text-lt"></i></a>
                            </div>
                            <!--清空播放列表-->
                            <div>
                                <a href="javascript:void(0)" class="jp-clear" title="清空播放列表" data-pjax=""><i class="fa fa-trash text-lt"></i></a>
                            </div>
                            <!--播放模式-->
                            <div class="layui-hide">
                                <a class="jp-shuffle" title="随机播放"><i class="icon-shuffle text-muted"></i></a>
                                <a class="jp-shuffle-off hid" title="shuffle off"><i class="icon-shuffle text-lt"></i></a>
                            </div>
                            <!--重复播放-->
                            <div class="layui-hide">
                                <a class="jp-repeat" title="重复播放"><i class="icon-loop text-muted"></i></a>
                                <a class="jp-repeat-off hid" title="repeat off"><i class="icon-loop text-lt"></i></a>
                            </div>
                            <div class="layui-hide">
                                <a class="jp-full-screen" title="full screen"><i class="fa fa-expand"></i></a>
                                <a class="jp-restore-screen" title="restore screen"><i class="fa fa-compress text-lt"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="jp-playlist dropup" id="playlist">
                    <ul class="dropdown-menu aside-xl animated slideInUp" style="background-image: linear-gradient(60deg, #29323c 0%, #485563 100%);"> <!--列表背景色-->
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
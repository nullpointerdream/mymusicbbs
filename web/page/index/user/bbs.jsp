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
<meta charset="utf-8" />
<style>
    	.layui-form-item .layui-input-inline {
    		width: 400px;
    	}
</style>
<title>${sessionScope.u.remark}的主页 - 做全网最好的DJ音乐站</title>
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
		<div class="fly-home fly-panel"
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
					<li class=""><a href="<%=basePath%>/admin/admin_works.do" data-pjax>作品</a></li>
					<li class="layui-this"><a href="<%=basePath%>/title/title_myTitle.do"
						data-pjax>我的帖子</a></li>
						<li ><a href="<%=basePath%>/fans/fans_fans.do" data-pjax>粉丝</a></li>
				</ul>
			</div>
		</div>
		<div class="layui-container fly-marginTop">
			<div class="fly-panel fly-panel-user" pad20>
				<div class="layui-tab layui-tab-brief" lay-filter="user">
					<ul class="layui-tab-title" id="LAY_mine">
						<li class="layui-this" lay-id="topic">帖子</li>
						
					</ul>
					<div class="layui-tab-content" style="padding: 20px 0;">
						<div class="layui-form-pane layui-tab-item layui-show">
						                          <!--歌曲列表 END-->
                        <table class="layui-table mar-no" lay-skin="line">
                            <tbody>
                            <c:choose>
                            	<c:when test="${empty result}">
									<div class="fly-none">暂时没有帖子</div>
								</c:when>
							<c:otherwise>
								 <thead>
                            <tr>
                               <th>帖子名称</th>
                               <th>主题</th>
								<th>发帖者</th>
								<th>发帖时间</th>
								<th>操作</th>
                            </tr>
                            </thead>
								<c:forEach items="${result}" var="record">
								<tr>
                               <td style="max-width: 350px;" class="layui-elip"><a href="<%=basePath%>title/title_bbsDetail.do?id=${record.id }" >${record.title}</a> </td>
														<td style="max-width: 400px;" class="layui-elip"><a
															href="<%=basePath %>admin/admin_userInfoById.do?username=${record.username}"
															> 
																${record.type}
																</a></td>
														<td><i class="fa fa-fire" style="color:red"></i> ${record.username} </td>
														<td>${record.datetime} </td>
														<td><a
															class="SMPlay" data-id="${record.id }"
															><i
																class=" fa fa-trash-o"></i></a>
														
														</td>
                            </tr>
                            </c:forEach>
								</c:otherwise>
                            </c:choose>
                                
                                                        </tbody>
                        </table>
						 <div class="text-center pagePjax">
						 <div class="pagination">${pageInfo }</div>
										<div class="clear"></div>
                          
                    		</div>
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
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
		</p>
	</div>
	

	<script type="text/javascript">
				function toPage(pageNum){
					var url = "title/title_myTitle.do?curPage="+pageNum;
					self.location.href = encodeURI(url);
				}
</script>
</body>
</html>
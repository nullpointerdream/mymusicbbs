<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/sys_jsp/base.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title><public:i18n key="system.name" module="system"></public:i18n></title>
			<script type="text/javascript" src="<%=basePath %>pro_js/applyInfo/applyInfo.js"></script>

			<script type="text/javascript">
				function toPage(pageNum){
					var url = "applyInfo/applyInfo_select.do?curPage="+pageNum;
					self.location.href = encodeURI(url);
				}
			</script>
		</head>

		<body>
			<div id="main-content">
			<div class="content-box">
			<div class="content-box-header">
				<h3><public:i18n key="function.manager" module="applyInfo"></public:i18n></h3>
				<ul class="content-box-tabs">
					<li><a href="#tab1" class="default-tab"><public:i18n key="function.list" module="applyInfo"></public:i18n></a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="content-box-content">
				<div class="tab-content default-tab" id="tab1">
				<jsp:include page="/sys_jsp/notification.jsp"></jsp:include>
					<form id="searchForm" name="searchForm" action="applyInfo/applyInfo_select.do" method="post">
			<public:i18n key="stuname" module="applyInfo"></public:i18n>: <input type="text" name="stuname"/>
			<public:i18n key="status" module="applyInfo"></public:i18n>: <input type="text" name="status"/>
						<input name="queryButton" type="submit" class="button" value='<public:i18n key="button.query" module="common"></public:i18n>' />
					</form>
					<c:choose>
						<c:when test="${empty result}">
						</c:when>
						<c:otherwise>
							<table>
								<thead>
									<tr>
								<th><public:i18n key="stuname" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="status" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="stunum" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="college" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="classinfo" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="dormitory" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="date" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="content" module="applyInfo"></public:i18n></th>
								<th><public:i18n key="remark" module="applyInfo"></public:i18n></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="11">
										<div class="pagination">${pageInfo }</div>
										<div class="clear"></div>
										</td>
									</tr>
								</tfoot>
								<tbody>
								<c:forEach items="${result}" var="record">
									<tr>
										<!--<td><a href="<%=basePath %>applyInfo/applyInfo_detail.do?id=${record.id }" title="title">${record.id }</a></td>-->
											<td>${record.stuname}</td>
											<td>${record.status}</td>
											<td>${record.stunum}</td>
											<td>${record.college}</td>
											<td>${record.classinfo}</td>
											<td>${record.dormitory}</td>
											<td>${record.date}</td>
											<td>${record.content}</td>
											<td>${record.remark}</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	</body>
	</html>

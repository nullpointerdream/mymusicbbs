<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/public.tld" prefix="public" %>
<%@ page import="com.base.common.util.DateUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Date date = new Date();
String nowTime2 = DateUtil.convDate2String(date,DateUtil.DEFAULT_DATE_TIME_PATTERN);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
body{background-color: #C7E1FA;}
	-->
	<style type="text/css">
		
		body{background-color: #C6D8EE;}
		.menu ul {margin:0;padding:0; list-style:none;}
		.menu ul li{margin:0;padding:0; list-style:none;}
		.menu{width:950px;height:50px;margin:0 auto; background:url(front2/images/bbbb.png) repeat-x;}
		.menu ul{width:950px;float:left;height:50px;display:inline;}
		.menu ul li{width:100px;height:50px;margin:1px 1px 1px 1px; line-height:50px; text-align:center; vertical-align:middle; font-weight:bold; float:left;display:inline; }
		.menu ul li a{width:100px;height:50px; float:left;text-decoration:none; color:#fff; font-size:22px}
		.menu ul li a:hover{ text-decoration:underline;background:url(front2/images/kkkk.png) repeat-x;}
		.header{width:950px;height:200px;margin:1 auto;  background:url(front2/images/header.png) repeat-x;}
		.leftmenu{width:150px;float: left;  vertical-align:top; display:inline; text-align:left;}
		.content{width:750px; float: left; vertical-align: top; display:inline;}
		.leftMenuFont{font-family: serif;font-size: 12px; text-align: left;}
		.category{border:0; bordercolor:#DEDEDE; cellpadding:0; cellspacing:0;}	
		a:hover{background:url(front2/images/kkkk.png) repeat-x; text-decoration: underline;}
		ol li{margin:0;padding:0; list-style:none;}
		a:visited {
			color: #506C00;
			text-decoration: underline;
		}

		a:link {
			color: #506C00;
			text-decoration:none;
		}
		
		/* jQuery lightBox plugin - Gallery style */
	#gallery {
		background-color:#C7E1FA;
		padding: 0px;
		width: 750px;
	}
	#gallery ul { list-style: none; }
	#gallery ul li { display: inline; }
	#gallery ul img {
		border: 5px solid #A5BDF7;
		border-width: 5px 5px 20px;
	}
	#gallery ul a:hover img {
		border: 5px solid #A07EF6;
		border-width: 5px 5px 20px;
		color: #598BED;
	}
	#gallery ul a:hover { color: #A07EF6; }
	
	html { overflow-x:hidden; }
	</style>
	
	
    
    <!-- Arquivos utilizados pelo jQuery lightBox plugin-->
    <script type="text/javascript" src="front2/js/jquery.js"></script>
    <script type="text/javascript" src="front2/js/jquery.min.js"></script>
    <script type="text/javascript" src="front2/js/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="front2/css/jquery.lightbox-0.5.css" media="screen" />
    
    <link rel="stylesheet" type="text/css" href="<%=basePath %>/front2/style.css" media="screen" />
    
   <script type="text/javascript" src="<%=basePath%>/front/front_js/calendar.js" charset="utf-8"></script>
   <script type="text/javascript" src="<%=basePath%>/front/front_js/public.js" charset="utf-8"></script>
   <script type="text/javascript">
 	function showDiv(divId){
 		var test = document.getElementById(divId);
 		var dis = test.style.display;
 		if(dis == "block") {
 			test.style.display="none";
 		}else if(dis == "none"){
 			test.style.display="block";
 		}
 	}
 	
 	
 </script>
	
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#header").css("display","none");
    		$("#header").fadeIn(7000);
    		
    		$("h3").css("background-color","#A5BDF7").css("width","166px").css("height","25px")
    		.css("text-align","center").css("padding-top","15px");
    		$("h3").mouseover(function(){
    			$(this).css("background-color","#598BED");
    		}).mouseout(function(){
    			$(this).css("background-color","#A5BDF7");
    		});
    		$("category").mouseover(function(){
    			$(this).css("background-color","#598BED");
    		}).mouseout(function(){
    			$(this).css("background-color","#A5BDF7");
    		});

    		$(function() {
    	        $('#gallery a').lightBox();
    	    });
    		$("#uploadpage").click(function () {
    			$('.theme-popover-mask').fadeIn(100);
    			$('.theme-popover').slideDown(200);
    		});
    		$('.theme-poptit .close').click(function(){
    			$('.theme-popover-mask').fadeOut(100);
    			$('.theme-popover').slideUp(200);
    		});
    		$("loginbutton").click(function(){
				var username = $("log").val();
				var password = $("pwd").val();
				if(username != "admin" || password != "admin"){
					
				}
	
        		
    			//$('.theme-popover-mask').fadeOut(100);
    			//$('.theme-popover').slideUp(200);

    			
        	});
    	});


    	function loadmenu(){
 		var url = "<%=basePath %>classify/classify_query4front.do";
					self.location.href = encodeURI(url);
 	}
    </script>
	
	 <script type="text/javascript">
    $(function(){ 
    	setInterval("getTime();",1000); //ÿ��һ��ִ��һ�� 
    	}) 
    	//ȡ��ϵͳ��ǰʱ�� 
    	function getTime(){ 
    	var myDate = new Date(); 
    	var date = myDate.toLocaleDateString(); 
    	var hours = myDate.getHours(); 
    	var minutes = myDate.getMinutes(); 
    	var seconds = myDate.getSeconds(); 
    	$("#showDate").html(date+" "+hours+":"+minutes+":"+seconds); //��ֵ����div 
    	} 
    </script>
    
    <script type="text/javascript">
     /*  var yzm=$("#yzm").val();
      if(${yzm}!=yzm){
    	  
      } */
      function check(){
    	 var yzm=$("#yzm").val();
    	  if(yzm==""){
    		  alert("����д��֤��");
    		  return false;
    	  }
    	 return true;
      }
      
    	  function  reloadCode(){
    	    	var time=new Date().getTime();
    	    	document.getElementById("yzm").src="<%=basePath %>/admin/admin_yzm.do?d="+time;
    	    	
    	    }  
     
    
    </script>
  </head>
  	
  <body >
  
  <c:if test="${needtoload ne 'NO'}">
	<script type="text/javascript">
		loadmenu();
	</script>
</c:if>
  
  <table width="950px" align="center">
  	<tr align="center">
  		<td align="center">
  		 <div class="header" align="center" id = "header" style="text-align: center;display: none;">
		  </div>
		   <div class="menu">
			<ul>
		    	<li><a href="front2/welcome.jsp" target="mainFrame">��ҳ</a></li>
		        <!-- 
		        <li><a href="front2/test.jsp" id="" target="mainFrame">������</a></li>
		        <li><a href="#" id="uploadpage">�ϴ����</a></li>  
		         -->
		        
		        
		     
			
			<li>
				<a href="<%=basePath %>musicInfo/musicInfo_query4front2.do" target="mainFrame">������Ʒ</a>
			</li>
			
			
			<%if(request.getSession().getAttribute("frontUsername") != null) {%>
			
			<li>
				<a href="<%=basePath %>/pro_jsp/applyInfo/applyInfo_add4front.jsp" target="mainFrame">��������</a>
			</li>
			
			<li>
			<a href="javascript:void(0)" onclick="showDiv('child4')">�ҵĸ���</a><br>
				<div id="child4" style="display: none;position: absolute;z-index: 9999;background-color:#13C6F5;">
					<a href="<%=basePath %>/pro_jsp/musicInfo/musicInfo_add4front.jsp" onclick="showDiv('child4')" target="mainFrame">�����ϴ�</a>
					<br/>
					<a href="<%=basePath %>musicInfo/musicInfo_query4front.do" onclick="showDiv('child4')" target="mainFrame">�ҵ��ϴ�</a>
					<br/>
					<a href="<%=basePath %>collectMusic/collectMusic_query4front.do" onclick="showDiv('child4')" target="mainFrame">�ҵ��ղ�</a>
				</div>
			
			</li>
			
			
			<%} %>
			<!--<li><a href="<%=basePath %>/login.jsp" target="_blank">��̨����</a></li>-->
			
			
			<li>
				<a href="<%=basePath %>news/news_query4front.do" target="mainFrame">���Ŷ�̬</a>
			</li>
			
			
			
			
			<li>
				<a href="javascript:void(0)"  onclick="showDiv('child11')">������̳</a></br>
				<div id="child11" style="display: none;position: absolute;z-index: 9999;background-color:#13C6F5;">
				<a href="<%=basePath %>title/title_query4front.do" target="mainFrame">������̳</a>
				<br/>
				<%if(request.getSession().getAttribute("frontUsername") != null) {%>
					<a href="<%=basePath %>title/title_myTitle.do"  target="mainFrame">�ҵ�����</a>
					<br/>
					<%} %>

				</div>
			</li>
		
		
		<li>
			<a href="javascript:void(0)" onclick="showDiv('child3')">��������</a><br>
				<div id="child3" style="display: none;position: absolute;z-index: 9999;background-color:#13C6F5;">
					<a href="<%=basePath %>/pro_jsp/liuYanBan/liuYanBan_add4front.jsp" onclick="showDiv('child3')" target="mainFrame">��������</a>
					<br/>
					<a href="<%=basePath %>liuYanBan/liuYanBan_query4front.do" onclick="showDiv('child3')" target="mainFrame">������Ϣ</a>
					<br/>

				</div>
			
			</li>

			
			<li>
				<a href="<%=basePath %>musicInfo/musicInfo_query4userinfo.do" target="mainFrame">��Ա��Ϣ</a>
			</li>
			<li>
			<a href="javascript:void(0)" onclick="showDiv('childc')">����</a><br>
				<div id="childc" style="display: none;position: absolute;z-index: 9999;background-color:#13C6F5;">
				<a href="<%=basePath %>zhaoPin/zhaoPin_query4front.do" target="mainFrame">��ļ��</a>
				<br/>
				<a href="<%=basePath %>zhaoPin/zhaoPin_query4front1.do" target="mainFrame">���</a>
				</div>
			</li>
			<li>
				
			</li>
			<!-- 
		
		    <li><a href="<%=basePath %>/login.jsp" target="_blank">��̨����</a></li> 
		     <li><a href="<%=basePath %>/pro_jsp/companyInfo/companyInfo_add4front.jsp" target="mainFrame">��ҵע��</a></li>
			 -->
		        
		    </ul>
		</div>
  		</td>
  	</tr>
  </table>
 
<table width="950px" align="center">
<tr>
	<td style="width: 200px;">
		<div class ="leftmenu" align="center">
			<div id="sidebar">
			<!-- 
			<table>
				<tr>
					<td>
						<table border="0" bordercolor="#DEDEDE" cellpadding="0" cellspacing="0">
			 				<tr bgcolor="#A5BDF7" id="category"> 
			 					<td  height="50px" width="5px" ><img src="front2/images/xiangcefeilei7.png"/></td>
			 					<td  align="left" width="145px" style="color: #000;font-size: 12px; font-weight: bold;">
			 						&nbsp;  �������б� - 
			 					</td>
			 				</tr>
	 					</table>
					</td>
				</tr>
				
				<tr>
					<td>
						<table>
						 	<tr>
			 					<td><img src="front2/images/xiangcefeilei2.png"/></td>
			 					<td width="130px" style="color: #000;font-size: 12px;">
			 						 <a href="#">&nbsp;�羰��</a>
			 					</td>
						 	</tr>
						 	<tr>
			 					<td><img src="front2/images/xiangcefeilei3.png"/></td>
			 					<td width="130px" style="color: #000;font-size: 12px;">
			 						 <a href="#">&nbsp;ʱ�о���</a>
			 					</td>
						 	</tr>
						 	<tr>
			 					<td><img src="front2/images/xiangcefeilei1.png"/></td>
			 					<td width="130px" style="color: #000;font-size: 12px;">
			 						 <a href="#">&nbsp;��ͼ</a>
			 					</td>
						 	</tr>
						 	<tr>
			 					<td><img src="front2/images/xiangcefeilei8.png"/></td>
			 					<td width="130px" style="color: #000;font-size: 12px;">
			 						 <a href="#">&nbsp;����</a>
			 					</td>
						 	</tr>
						 	<tr>
			 					<td><img src="front2/images/xiangcefeilei9.png"/></td>
			 					<td width="130px" style="color: #000;font-size: 12px;">
			 						 <a href="#">&nbsp;����</a>
			 					</td>
						 	</tr>
						 </table>
					</td>
				</tr>
				 
				<tr>
					<td>
					</td>
				</tr>
			</table>
			 -->
			<h3>������Ϣ</h3>	
				 <ul>
				 <%if(request.getSession().getAttribute("frontUsername") != null) {%>
				 <li>
				 	
				 	<img style="width: 100px; height: 100px; padding-top: 20px;" src="<%=basePath %>attachment/<%=request.getSession().getAttribute("userimage")%>"/>
				 	
				 </li>
				 <%} %>
				<li>
					<h5>��ǰʱ��</h5>
					
						<div id="showDate"></div>
					
				</li>
				<li>
				<%if(request.getSession().getAttribute("frontUsername") == null) {%>
						<h5>�û���¼</h5>
						<form action="<%=basePath %>/admin/admin_login2.do" method="post">
							<input type="hidden" name="usertype" value="2">
							<h5>�ʺ�: <input type="text" style="width: 100px;" name="username"  required/></h5>
							<h5>����: <input type="password" style="width: 100px;" name="password" required/></h5>
							<h5><img id="yzm"  alt="��֤��" src="<%=basePath %>/admin/admin_yzm.do"><a href="javascript:reloadCode();" class="link">�������</a></h5>
							<h5><input type="text" name="yzm" id="yzm"></h5>
							<h5>
								<input type="submit" value="��¼"/>
								<!-- 
								<a target="mainFrame" href="<%=basePath %>sys_jsp/admin/admin_add2.jsp">���û�ע��</a>
								
								 <a style="color: #506C00;" target="mainFrame" href="<%=basePath %>pro_jsp/studentinfo/studentinfo_add2.jsp">ѧ��ע��</a>
								 -->
								<a target="mainFrame" href="<%=basePath %>sys_jsp/admin/admin_add2.jsp">�û�ע��</a>&nbsp;<a href="<%=basePath %>/forget.jsp">��������</a><br/>
								
							</h5>
						</form>
					</li>
					<%}else { %>
						<h5><%=request.getSession().getAttribute("frontUsername") %></h5>
							<!-- 
							<a href="<%=basePath %>/admin/admin_changePwd2.do" target="mainFrame">�޸�����</a>
							 -->
							<h5>
							 <a  style="color: #506C00;"href="<%=basePath %>/sys_jsp/admin/admin_changePassword2.jsp" target="mainFrame">�޸�����</a>
							 
							<a style="color: #506C00;" href="<%=basePath %>/admin/admin_modify2.do?username=<%=request.getSession().getAttribute("u") %>" target="mainFrame">�޸ĸ�����Ϣ</a>
							</h5>
							<h5>
							<a style="color: #506C00;" href="<%=basePath %>/admin/admin_logout.do?type=2">�˳�</a>
							</h5>
						
					<%} %>
					
				<li>
					<a href="<%=basePath %>/login.jsp" target="_blank">��̨����</a>
				</li>
			</ul>
			<!-- 
			<h3>����</h3>
					<ul>
						
						<font style="font-family: cursive;font-weight:bold; color:#506C00; font-size: 12px">
						<li>
							
							<a target="mainFrame" href="<%=basePath %>/announce/announce_query2.do">����...</a>
							 
						</li>
						
						</font>
						 
					</ul>
					<br/>	
			 -->
		
			</div>
			
			<div>
				<h3>ϵͳ���</h3>
				 <table class="leftMenuFont">
				 	<tr>
				 		<td>
				 		
				 		 <MARQUEE id="go1" onmouseover=go1.stop() 
                  style="LINE-HEIGHT: normal; LETTER-SPACING: normal; TEXT-ALIGN: left" 
                  onmouseout=go1.start() scrollAmount=1 scrollDelay=50 
                  direction=up width=160 height=98>&nbsp;&nbsp;
                  <!-- 
                  <A href="http://www.wwj.suzhou.gov.cn/2052/aspx/webmain/aspx/ContentShow1.aspx?Guid=aee5b0f7-509a-40fe-95fe-16295b92e23c" 
                  target=blank><IMG src="/yd_01.gif" 
                  border=0>&nbsp;&nbsp; ���ڿ�չ�ڶ���
                  [2008-03-17]</A><BR>
                   -->
                    ����ԭ��������վ����չʾ���˼�������ִ�ѧ���������������ǵ�ԭ����Ʒ����ҵ��Ʒ��Ŀǰ��վ����3�꣬�������µ�С���ǰ������ԭ��������Ʒ��
                  &nbsp;&nbsp;
                  
                 
                  </MARQUEE>
				 		
				 		
				 		
				 		</td>
				 	</tr>
				 	<!-- 
				 	<tr>
				 		<td>�ϴ�ͼƬ</td>
				 	</tr>
				 	<tr>
				 		<td>������</td>
				 	</tr>
				 	
				 	 -->
				 </table>
				 <br/>
			</div>
			
			<div>
			
				<c:forEach items="${result}" var="record">
									<h3>
											<a href="<%=basePath %>Classify/Classify_detail4front.do?id=${record.id }" target="mainFrame" title="title">
											${record.name}
											</a>
											</h3>
								</c:forEach>
				
				
				<!--  <h3>��ϵ����</h3>
				<ul class="biaodanzi" id="ul2">
					<li>�绰��0512-62886969</li>
					<li>��ַ���й�.����</li>
					<li>���䣺0512@126.com</li>
					<li>��˾�����Ĵ�ý���޹�˾</li>
				</ul>
				-->
				
			</div>
			<div style="height: 100px">
			
			</div>
		</div>
	</td>
	<td valign="top">
		<iframe id="mainFrame" style="overflow: hidden" name="mainFrame" frameborder="0" width="100%" height="400%"  src="front2/welcome.jsp"></iframe>
		<input type="hidden" id="content" name="content" value="${content }">
	</td>
</tr>

</table>
		<div class="theme-popover">
		     <div class="theme-poptit">
		          <a href="javascript:;" title="�ر�" class="close">��</a>
		          <h4>��¼ ��һ����̬</h4>
		     </div>
		     <div class="theme-popbod dform">
		           <form class="theme-signin" name="loginform" action="" method="post">
		                <ol>
		                     <li><h4>������ȵ�¼��</h4></li>
		                     <li><strong>�û�����</strong><input class="ipt" type="text" id="log" name="log" value="" size="20" /></li>
		                     <li><strong>���룺</strong><input class="ipt" type="password" id="pwd" name="pwd" value="" size="20" /></li>
		                     <li><input class="btn btn-primary" type="button" name="submit" id="loginbutton" value=" �� ¼ " /></li>
		                </ol>
		           </form>
		     </div>
		</div>
		<div class="theme-popover-mask"></div>
  </body>
</html>

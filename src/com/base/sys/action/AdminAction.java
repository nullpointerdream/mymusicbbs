package com.base.sys.action;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONObject;
import com.base.common.util.AjaxResponseUtil;
import com.base.common.util.AjaxReturnInfo;
import com.base.common.util.CommonUtil;
import com.base.common.util.Const;
import com.base.common.util.PlaceUtil;
import com.base.common.util.SessionManager;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.sys.entity.Admin;
import com.base.sys.manager.AdminManager;
import com.base.web.tag.BTAGI18N;
import com.opensymphony.xwork2.ActionContext;
import com.pro.entity.ApplyInfo;
import com.pro.entity.Baoming;
import com.pro.entity.CollectMusic;
import com.pro.entity.MusicInfo;
import com.pro.entity.News;
import com.pro.entity.PingLun;
import com.pro.manager.ApplyInfoManager;
import com.pro.manager.CollectMusicManager;
import com.pro.manager.MusicInfoManager;
import com.pro.manager.NewsManager;
import com.pro.manager.ZhaoPinManager;


@Controller
public class AdminAction {
	@Resource
	private AdminManager adminManager;
	@Resource
	private ApplyInfoManager applyInfoManager;
	@Resource
	private ZhaoPinManager zhaoPinManager;
	@Resource
	private NewsManager newsManager;
	@Resource
	private MusicInfoManager musicInfoManager;
	private String username;
	private String password;
	private String usertype;
	private String telephone;
	private String email;
	private String address;
	private String qq;
	private String name;
	private String gender;
	private int age;
	private String isLocked;
	private String isLogon;
	private Date lastLoginTime;
	private Date accountCreateTime;
	private int passErrorTimes;
	private String flag;
	private String filename;
	private String college;
	private String remark;
	private File[] upload;//上传的文件
	private File file;//上传的文件
	private String fileContentType; //文件名称
	private String fileFileName; //文件类型
	private String[] uploadContentType; //文件名称
	private String[] uploadFileName; //文件类型
	private String isvip;
	private String isgood;
	private String yzm;
	@Resource
	private CollectMusicManager collectMusicManager;
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getYzm() {
		return yzm;
	}
	public void setYzm(String yzm) {
		this.yzm = yzm;
	}
	public String getIsvip() {
		return isvip;
	}
	public void setIsvip(String isvip) {
		this.isvip = isvip;
	}
	public String getIsgood() {
		return isgood;
	}
	public void setIsgood(String isgood) {
		this.isgood = isgood;
	}
	public File[] getUpload() {
		return upload;
	}
	public void setUpload(File[] upload) {
		this.upload = upload;
	}
	public String[] getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public String[] getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	private DefaultQueryCondition<Admin> condition;

	public String loginCheck() {
		AjaxReturnInfo info = new AjaxReturnInfo();
		Admin admin = this.adminManager.getAdminByUsername(CommonUtil.genUTF8String(this.username));
		if(admin == null) {
				info.setSuccess(false);
				info.setErrMsg(BTAGI18N.getI18NValue("error.user.notexist", "admin"));
		} else {
			if(admin.getPassword().equals(this.password)&&admin.getUsertype().equals(this.usertype)) {
					//判断 Type不对， 但是flag= Y 且密码正确
						info.setSuccess(true);
			} else {
				info.setSuccess(false);
				info.setErrMsg(BTAGI18N.getI18NValue("error.usertype.notmatch", "admin"));
				}
		}
		return AjaxResponseUtil.getInstance(info).respToClient();
	}

	public String login() {
		SessionManager.setAdminUsername(this.username);
		SessionManager.setAdminUserType(this.usertype);
		Admin admin = this.adminManager.getAdminByUsername(CommonUtil.genUTF8String(this.username));
		SessionManager.setAdminUserFlag(admin.getFlag());
		ServletActionContext.getRequest().getSession().setAttribute("u",admin);
		this.username = null;
		this.usertype = null;
		return "adminLoginSuccess";
	}
	public String userInfo() {
		CollectMusic entity = new CollectMusic();
		HttpServletRequest request = ServletActionContext.getRequest();
		if(request.getSession().getAttribute("u") == null){
			
		}else{
			Admin loginid = (Admin) request.getSession().getAttribute("u");
			entity.setStuid(loginid.getUsername());
		}
		condition = new DefaultQueryCondition(entity);
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<CollectMusic> page = this.collectMusicManager.getRecords(condition);
		List<CollectMusic> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "userInfo";
	}
	
	public String userInfoById() {
		CollectMusic entity = new CollectMusic();
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin loginid = adminManager.getAdminByUsername(this.username);
		entity.setStuid(loginid.getUsername());
		condition = new DefaultQueryCondition(entity);
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<CollectMusic> page = this.collectMusicManager.getRecords(condition);
		List<CollectMusic> resultList = page.getList();
		ActionContext.getContext().put("loginid", loginid);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "userInfoById";
	}
	public String works() {
		MusicInfo entity = new MusicInfo();
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getSession().getAttribute("u") == null) {

		} else {
			Admin loginid = (Admin) request.getSession().getAttribute("u");
			entity.setUserid(loginid.getUsername());
		}

		condition = new DefaultQueryCondition(entity);
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<MusicInfo> page = this.musicInfoManager.getRecords(condition);
		List<MusicInfo> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "works";
	}
	public String worksById() {
		MusicInfo entity = new MusicInfo();
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin loginid = adminManager.getAdminByUsername(this.username);
		entity.setUserid(this.username);

		condition = new DefaultQueryCondition(entity);
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<MusicInfo> page = this.musicInfoManager.getRecords(condition);
		List<MusicInfo> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put("loginid", loginid);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "worksById";
	}
	public void login2() {
		String username = this.getUsername();
		String password = this.getPassword();
		AjaxReturnInfo info = new AjaxReturnInfo();
		boolean isPwdCorrect = this.adminManager.checkPassword(username,password);
		info.setSuccess(false);
		if (isPwdCorrect) {
			Admin adm = this.adminManager.getSysAdminById(username);
			String type = String.valueOf(adm.getUsertype());
			if(!"3".equals(type)) {
					info.setErrMsg("账户与类型不匹配");
			}else if ("2".equals(type)|| "3".equals(type)) {
					ActionContext.getContext().getSession().put(Const.ACTION_PUT_SESSION_USRE_TYPE, usertype);
					ApplyInfo a=(ApplyInfo)this.adminManager.get(adm.getUsername());
					adm.setFile(adm.getFile()==null || "".equals(adm.getFile())?"2.png":adm.getFile());
					ActionContext.getContext().getSession().put("u", adm);
					if(a==null){
						ActionContext.getContext().getSession().put(Const.ACTION_PUT_SESSION_FRONT_USER_NAME, adm.getRemark());
					}else if("Y".equals(adm.getIsvip())){
						ActionContext.getContext().getSession().put(Const.ACTION_PUT_SESSION_FRONT_USER_NAME, adm.getRemark());
						ActionContext.getContext().getSession().put("userid", adm.getUsername());
					}else{
						ActionContext.getContext().getSession().put(Const.ACTION_PUT_SESSION_FRONT_USER_NAME, adm.getRemark());
						ActionContext.getContext().getSession().put("userid", adm.getUsername());
					}
					ActionContext.getContext().getSession().put("userimage",adm.getFile() );
					info.setSuccess(true);
					info.setErrMsg("登陆成功");
			      }
		} else {
			info.setErrMsg("密码错误");
		}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(info));
	}
	
	public String logout() {
		ActionContext.getContext().getSession().remove("u");
		HttpServletRequest request = ServletActionContext.getRequest();
		String type = request.getParameter("type");
		if ("2".equals(type)) {
			return "userLoginPage";
		} 
		String flag = (String) request.getSession().getAttribute(Const.Session.ADMIN_USER_FlAG);
		if("3".equals(type)){
			return "homePage";
		}
		return "homePage";
	}
	public String home() {
		MusicInfo entity = new MusicInfo();
		condition = new DefaultQueryCondition(entity);
		condition.setPageSize(10);
		Page<MusicInfo> page = this.musicInfoManager.getRecords("date","DESC",condition);
		List<MusicInfo> resultList = page.getList();
		News news = new News();
		DefaultQueryCondition defaultQueryCondition = new DefaultQueryCondition(news);
		defaultQueryCondition.setPageSize(10);
		Page<News> page2 = this.newsManager.getRecords("datetime","DESC",defaultQueryCondition);
		List<News> resultList2 = page2.getList();
		Admin admin = new Admin();
		admin.setUsertype("3");
		condition = new DefaultQueryCondition(admin);
		condition.setPageSize(8);
		Page<Admin> page3 = this.adminManager.getAdminList("accountCreateTime","DESC",condition);
		List<Admin> resultList3 = page3.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT3, resultList3);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT2, resultList2);
	
		return "gotoHome";
	}
	public String userCenter() {
		return "userCenter";
	}
	
	public void add() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String a=request.getParameter("flg");
		Map<String,Object> map = new HashedMap();
		if("up".equals(a)){
			Admin a1=new Admin();
			String name=request.getParameter("name");
			Admin ad=this.adminManager.getAdminByUsername(name);
			if(ad==null){
				map.put("code", "301");
				map.put("msg", "用户不存在");
			}else {
				ad.setPassword(this.password);
				this.adminManager.updateUser(ad);
				map.put("code", "200");
				map.put("msg", "更改密码成功！");
			}
		}else if(this.adminManager.isUserExit(this.username)) {
			map.put("code", "302");
			map.put("msg", "用户已存在！");
			
			
		}else {
			Admin admin = new Admin();
			admin.setUsername(this.username);
			admin.setPassword(this.password);
			admin.setUsertype(this.usertype);
			admin.setTelephone(this.telephone);
			admin.setEmail(this.email);
			admin.setCollege(this.college);
			admin.setRemark(this.remark);
			admin.setAccountCreateTime(new Date());
			admin.setGender(this.gender);
			admin.setFile("2.png");
			ActionContext.getContext().getSession().put("u", admin);
		try {
			this.adminManager.addUser(admin);
			map.put("code", "200");
			map.put("msg", "注册成功！");
		} catch (Exception e) {
			
		}
		}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}
	//重命名上传文件（非必须）  
    public String generateFileName(String fileName)  
    {  
        String formatDate = new SimpleDateFormat("yyMMddHHmmss")  
                .format(new Date());  
        int random = new Random().nextInt(10000);  
        int position = fileName.lastIndexOf(".");  
        String extension = fileName.substring(position);  
 
        return formatDate + random + extension;  
    }
    public void uploadFile(){  
    	Map<String,Object> map = new HashMap<String,Object>();
    	if (file != null) {
    		System.out.println(file);
    		HttpServletRequest request = ServletActionContext.getRequest();
    		String realpath = request.getSession().getServletContext().getRealPath("/attachment/") ;
			String name1 ="";
        	name1 = generateFileName(fileFileName);
        	File savefile = new File(new File(realpath), name1);
		        if (!savefile.getParentFile().exists())
		                savefile.getParentFile().mkdirs();
		        try {
					FileUtils.copyFile(file, savefile);
					map.put("code", 0);
					Map<String,Object> map2= new HashMap();
					map2.put("src", CommonUtil.absolutePath()+"attachment/"+name1);
					map.put("data", map2);
					map.put("path", CommonUtil.absolutePath()+"attachment/"+name1);
					map.put("msg", "文件上传成功!");
					map.put("name", name1);
				} catch (IOException e) {
					map.put("code", "305");
					map.put("msg", "文件上传失败!");
			}
    	}
    	AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
    }
       
	public String detail() {
		String userName = CommonUtil.genUTF8String(this.username);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, this.adminManager.getAdminByUsername(userName));
		this.username = null;
		return Const.Pages.MAPPING_URL;
	}
	
	
	
	public String checkOldPassword() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String oldPassword = request.getParameter("oldpassword");
		Admin admin = this.adminManager.getAdminByUsername(CommonUtil.genUTF8String(this.username));
		AjaxReturnInfo info = new AjaxReturnInfo();
		if(admin != null && oldPassword.equals(admin.getPassword())) {
			info.setSuccess(true);
		} else {
			info.setErrMsg(BTAGI18N.getI18NValue("error.oldpassword.error", "admin"));
		}
		return AjaxResponseUtil.getInstance(info).respToClient();
	}
	
	
	public String query() {
		Admin adm = new Admin();
		adm.setUsername(this.username);
		condition = new DefaultQueryCondition(adm);
		HttpServletRequest request = ServletActionContext.getRequest();
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<Admin> page = this.adminManager.getAdminList(condition);
		List<Admin> user = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, user);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,
				page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.QUERY_JSP;
	}
	
	public String del() {
		this.adminManager.deleteUser(CommonUtil.genUTF8String(this.username));
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		this.username = null;
		return Const.Pages.QUERY_DO;
	}
	
	public String dels() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String ids = CommonUtil.genUTF8String(request.getParameter("ids"));
		String[] idList = ids.split(",");
		int len = idList.length;
		for(int i=0;i<len;i++) {
			this.adminManager.deleteUser(idList[i]);
		}
		return Const.Pages.QUERY_DO;
	}
	
	public String edit() {
		String key = CommonUtil.genUTF8String(this.username);
		Admin admin = this.adminManager.getAdminByUsername(key);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, admin);
		return Const.Pages.MAPPING_URL;
	}
	
	public String update() throws Exception {
		String key = CommonUtil.genUTF8String(this.username);
		Admin admin = this.adminManager.getAdminByUsername(key);
		admin.setUsertype(this.usertype);
		if(isvip.equals("N")){
			 String hql="from ApplyInfo where 1=1 and stuid='"+key+"'";
			  List<ApplyInfo>  list=this.applyInfoManager.queryByHql(hql);
			  String hql2="from Baoming where 1=1 and userId='"+key+"'";
			  List<Baoming>  list1=this.applyInfoManager.queryByHql(hql2);
			  for(Baoming b:list1){
				  this.zhaoPinManager.delete(b);
			  }
			  applyInfoManager.deleteViaId(list.get(0).getId());
		}
		admin.setIsvip(isvip);
		admin.setIsgood(isgood);
		
		this.adminManager.updateUser(admin);
		this.username = null;
		return Const.Pages.QUERY_DO;
	}
	
	public void changePassword() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin admin2 =(Admin) ActionContext.getContext().getSession().get("u");
		String oldPassword = request.getParameter("oldpassword");
		Map<String,Object> map = new HashMap<>();
		Admin admin = this.adminManager.getAdminByUsername(admin2.getUsername());
		if(admin != null && oldPassword.equals(admin.getPassword())) {
			this.password = request.getParameter("newpassword");
			admin.setPassword(this.password);
			this.adminManager.updateUser(admin);
			map.put("code", "200");
			map.put("msg", "修改成功");
		} else {
			map.put("code", "400");
			map.put("msg", "原密码错误");
		}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}
	
	public String getCities() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		String province = request.getParameter("pid");
		String cities = PlaceUtil.genCitiesSelectString(province);
		try {
			response.getWriter().print(cities);
			response.getWriter().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String modify2() {
		String userId = CommonUtil.genUTF8String(this.username);
		Admin adm = this.adminManager.getSysAdminById(userId);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, adm);
		return Const.Pages.MAPPING_URL;
	}
	
	public void update2() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin adm2 = (Admin) request.getSession().getAttribute("u");
		String userId = this.username;
		adm2.setAddress(this.address);
		adm2.setEmail(this.email);
		adm2.setTelephone(this.telephone);
		adm2.setCollege(this.college);
		adm2.setRemark(this.remark);
		adm2.setFile(this.fileFileName);
		this.adminManager.updateUser(adm2);
		Map<String,Object> map = new HashedMap();
		map.put("code", "修改成功");
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}
	
	public AdminManager getAdminManager() {
		return adminManager;
	}

	public void setAdminManager(AdminManager adminManager) {
		this.adminManager = adminManager;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getIsLocked() {
		return isLocked;
	}

	public void setIsLocked(String isLocked) {
		this.isLocked = isLocked;
	}

	public String getIsLogon() {
		return isLogon;
	}

	public void setIsLogon(String isLogon) {
		this.isLogon = isLogon;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Date getAccountCreateTime() {
		return accountCreateTime;
	}

	public void setAccountCreateTime(Date accountCreateTime) {
		this.accountCreateTime = accountCreateTime;
	}

	public int getPassErrorTimes() {
		return passErrorTimes;
	}

	public void setPassErrorTimes(int passErrorTimes) {
		this.passErrorTimes = passErrorTimes;
	}
	
	public String detail4front() {
		String userName = CommonUtil.genUTF8String(this.username);
		ApplyInfo entity2 = this.applyInfoManager.queryById(Integer.parseInt(userName));
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity2);
		this.username = null;
		MusicInfo entity = new MusicInfo();
		HttpServletRequest request = ServletActionContext.getRequest();
		String hql="from MusicInfo where userid='"+entity2.getStuid()+"' and shenhe='通过'";
		//entity.setRenqi(this.renqi);
		//entity.setTuijian(this.tuijian);
		//entity.setShenhe(this.shenhe);
		List<MusicInfo>  resultList=this.musicInfoManager.queryByHql(hql);
		ActionContext.getContext().put("results", resultList);
		return Const.Pages.MAPPING_URL;
	}
	
	
	public void yzm() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		BufferedImage bi = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);
		Graphics g = bi.getGraphics();
		Color c = new Color(200,150,255);
		g.setColor(c);
		g.fillRect(0, 0, 68, 22);
		char[] ch = "0123456789".toCharArray();
		Random r = new Random();
		int len = ch.length, index;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 4; i++) {
			index = r.nextInt(len);
			g.setColor(new Color(r.nextInt(88), r.nextInt(188), r.nextInt(255)));
			g.drawString(ch[index] + "", (i * 15) + 3, 18);
			sb.append(ch[index]);
		}
		request.getSession().setAttribute("yzm", sb.toString());
		ImageIO.write(bi, "JPG", response.getOutputStream());

	}
	
}

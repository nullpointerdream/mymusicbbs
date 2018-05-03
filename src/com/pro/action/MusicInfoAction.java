package com.pro.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
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
import com.base.common.util.EntityAnnotation;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.sys.entity.Admin;
import com.base.sys.manager.AdminManager;
import com.base.web.tag.BTAGI18N;
import com.opensymphony.xwork2.ActionContext;
import com.pro.entity.ApplyInfo;
import com.pro.entity.CollectMusic;
import com.pro.entity.MusicInfo;
import com.pro.entity.News;
import com.pro.entity.PingLun;
import com.pro.manager.ApplyInfoManager;
import com.pro.manager.CollectMusicManager;
import com.pro.manager.MusicInfoManager;
import com.pro.manager.PingLunManager;

@Controller
public class MusicInfoAction {
	@Resource
	private MusicInfoManager musicInfoManager;
	@Resource
	private ApplyInfoManager applyInfoManager;
	private int id;

	@EntityAnnotation(desc = "歌曲类别", needUpdate = true, isQueryField = true, rule = "SELE_M;翻唱;原创")
	private String types;

	@EntityAnnotation(desc = "歌曲名称", rule = "CHAR_M_120", isDetailLink = true, needUpdate = false, isQueryField = true)
	private String musicname;

	@EntityAnnotation(desc = "歌词", rule = "CHAR_N_120", needUpdate = true, isQueryField = false)
	private String content;

	@EntityAnnotation(desc = "上传", rule = "CHAR_M_120", needUpdate = false, isQueryField = false)
	private String file;

	@EntityAnnotation(desc = "发布者id", needShow = false)
	private String userid;

	@EntityAnnotation(desc = "发布者", needUpdate = false, isQueryField = true, rule = "CHAR_M")
	private String username;

	@EntityAnnotation(desc = "人气歌曲", needUpdate = true, isQueryField = true, rule = "SELE_M;否;是")
	private String renqi;

	@EntityAnnotation(desc = "推荐歌曲", needUpdate = true, isQueryField = true, rule = "SELE_M;否;是")
	private String tuijian;

	@EntityAnnotation(desc = "发布日期", rule = "DATE_M")
	private String date;

	@EntityAnnotation(desc = "审核", needUpdate = true, isQueryField = true, rule = "SELE_M;提交;通过;未过")
	private String shenhe;

	@EntityAnnotation(desc = "备注", needUpdate = true, isQueryField = false, rule = "CHAR_N")
	private String remark;

	@EntityAnnotation(desc = "作词者", rule = "CHAR_N_120", needUpdate = true, isQueryField = false)
	private String zuociz;
	@EntityAnnotation(desc = "编曲者", rule = "CHAR_N_120", needUpdate = true, isQueryField = false)
	private String bqz;
	@EntityAnnotation(desc = "演唱者", rule = "CHAR_N_120", needUpdate = true, isQueryField = false)
	private String ycz;
	@EntityAnnotation(desc = "原唱", rule = "CHAR_N_120", needUpdate = true, isQueryField = false)
	private String yuanchang;
	private String img;
	private String fileFileName;
	public String getZuociz() {
		return zuociz;
	}

	public void setZuociz(String zuociz) {
		this.zuociz = zuociz;
	}

	public String getBqz() {
		return bqz;
	}

	public void setBqz(String bqz) {
		this.bqz = bqz;
	}
	
	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getYcz() {
		return ycz;
	}

	public void setYcz(String ycz) {
		this.ycz = ycz;
	}

	public String getYuanchang() {
		return yuanchang;
	}

	public void setYuanchang(String yuanchang) {
		this.yuanchang = yuanchang;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public String getMusicname() {
		return musicname;
	}

	public void setMusicname(String musicname) {
		this.musicname = musicname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRenqi() {
		return renqi;
	}

	public void setRenqi(String renqi) {
		this.renqi = renqi;
	}

	public String getTuijian() {
		return tuijian;
	}

	public void setTuijian(String tuijian) {
		this.tuijian = tuijian;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getShenhe() {
		return shenhe;
	}

	public void setShenhe(String shenhe) {
		this.shenhe = shenhe;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	private File[] upload;// 上传的文件
	private String[] uploadContentType; // 文件名称
	private String[] uploadFileName; // 文件类型

	public File[] getUpload() {
		return upload;
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

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	private DefaultQueryCondition condition;
	private Page page;

	public String add() {
		MusicInfo entity = new MusicInfo();
		try {
			entity.setDate(this.date);
			entity.setContent(this.content);
			entity.setRemark(this.remark);
			entity.setTypes(this.types);
			entity.setMusicname(this.musicname);
			entity.setFile(this.file);
			entity.setUserid(this.userid);
			entity.setUsername(this.username);
			entity.setRenqi(this.renqi);
			entity.setTuijian(this.tuijian);
			entity.setShenhe(this.shenhe);
			this.musicInfoManager.add(entity);
			String returnMsg = BTAGI18N.getI18NValue("add.success", "common");
			ActionContext.getContext().put(Const.Notification.SUCCESS, returnMsg);
			return Const.Pages.MAPPING_URL;
		} catch (Exception e) {
			ActionContext.getContext().put(Const.Notification.ERROR, e.getMessage());
			return Const.Pages.MAPPING_URL;
		}
	}
	public String list() {
		MusicInfo entity = new MusicInfo();
		entity.setShenhe("通过");
		entity.setMusicname(this.musicname);
		condition = new DefaultQueryCondition(entity);
		HttpServletRequest request = ServletActionContext.getRequest();
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
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,
				page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		ActionContext.getContext().put("musicname", entity.getMusicname());
		return "musiclist";
	}
	public void add4front() throws Exception {
		MusicInfo entity = new MusicInfo();
		Map<String,Object> map = new HashMap<>();
			HttpServletRequest request = ServletActionContext.getRequest();
			if (request.getSession().getAttribute("u") == null) {
				map.put("code",300);
				map.put("msg","请重新登陆！");
			}else{
				Admin loginid = (Admin) request.getSession().getAttribute("u");
				entity.setFile(fileFileName);
				int position = fileFileName.lastIndexOf(".");
				String filetype = fileFileName.substring(position, fileFileName.length());
				SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				entity.setDate(s.format(new Date()));
				entity.setContent(this.content);
					entity.setRemark(this.remark);
					entity.setTypes(this.types);
					entity.setMusicname(this.musicname);
					entity.setBqz(this.bqz);
					entity.setZuociz(this.zuociz);
					entity.setYuanchang(this.yuanchang);
					entity.setYcz(this.ycz);
					// entity.setFile(this.file);
					entity.setUserid(loginid.getUsername());
					entity.setUsername(loginid.getRemark());
					entity.setRenqi("0");
					entity.setTuijian("否");
					entity.setShenhe(this.shenhe);
					if (!filetype.endsWith("mp3") && !filetype.endsWith("wma")) {
						ActionContext.getContext().put(Const.Notification.ERROR, "");
						map.put("code",300);
						map.put("msg","请重选择歌曲！歌曲格式为MP3或wma");
					}else{
						this.musicInfoManager.add(entity);
						this.types = null;
						this.musicname = null;
						this.username = null;
						this.renqi = null;
						this.tuijian = null;
						this.shenhe = null;
						map.put("code",200);
						map.put("msg","上传成功");
					}
				}
			AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}

	// 重命名上传文件（非必须）
	public String generateFileName(String fileName) {
		String formatDate = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
		int random = new Random().nextInt(10000);
		int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);

		return formatDate + random + extension;
	}

	public String del() {
		this.musicInfoManager.deleteViaId(this.id);
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		return Const.Pages.QUERY_DO;
	}

	public String dels() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String ids = request.getParameter("ids");
		String[] idList = ids.split(",");
		int len = idList.length;
		for (int i = 0; i < len; i++) {
			this.musicInfoManager.deleteViaId(Integer.parseInt(idList[i]));
		}
		return Const.Pages.QUERY_DO;
	}

	public String update() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		entity.setDate(this.date);
		entity.setContent(this.content);
		entity.setRemark(this.remark);
		entity.setTypes(this.types);
		entity.setTuijian(this.tuijian);
		entity.setShenhe(this.shenhe);
		this.musicInfoManager.update(entity);

		this.types = null;
		this.musicname = null;
		this.username = null;
		this.renqi = null;
		this.tuijian = null;
		this.shenhe = null;
		return Const.Pages.QUERY_DO;
	}

	public String edit() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		System.out.println(entity.getYcz());
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String detail() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String detail4front2() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public void detail4front3() {

		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map2.put("mp3", CommonUtil.absolutePath() + "attachment/" + entity.getFile());
		map2.put("artist", entity.getUsername());
		map2.put("id", entity.getId());
		map2.put("title", entity.getMusicname());
		map2.put("isCollect", false);
		map.put("data", map2);
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));

	}

	public String query() {
		MusicInfo entity = new MusicInfo();
		entity.setTypes(this.types);
		entity.setMusicname(this.musicname);
		entity.setUsername(this.username);
		entity.setRenqi(this.renqi);
		entity.setTuijian(this.tuijian);
		entity.setShenhe(this.shenhe);
		condition = new DefaultQueryCondition(entity);
		HttpServletRequest request = ServletActionContext.getRequest();
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
		List<MusicInfo> resultList2 = new ArrayList<MusicInfo>();
		for (MusicInfo m : resultList) {
			int sum = 0;
			int m_id = m.getId();
			List<CollectMusic> cmlist = this.musicInfoManager.getMusicCoo(m_id);
			List<PingLun> pllist = this.musicInfoManager.getMusicPinglun(m_id);
			System.out.println(pllist.size());
			sum = cmlist.size() + pllist.size();
			m.setRenqi(sum + "");
			resultList2.add(m);
		}
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList2);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}

	public String querysoucang() {
		MusicInfo entity = new MusicInfo();
		entity.setShenhe("通过");
		condition = new DefaultQueryCondition(entity);
		HttpServletRequest request = ServletActionContext.getRequest();
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
		List<MusicInfo> resultList2 = new ArrayList<MusicInfo>();
		for (MusicInfo m : resultList) {
			int sum = 0;
			int m_id = m.getId();
			List<CollectMusic> cmlist = this.musicInfoManager.getMusicCoo(m_id);
			sum = cmlist.size();
			m.setRenqi(sum + "");
			resultList2.add(m);
		}

		for (int i = 0; i < resultList2.size() - 1; i++) {
			for (int j = 0; j < resultList2.size() - 1 - i; j++) {
				if (Integer.parseInt(resultList2.get(j).getRenqi()) < Integer
						.parseInt(resultList2.get(j + 1).getRenqi())) {
					MusicInfo m = new MusicInfo();
					m = resultList2.get(j + 1);
					resultList2.set(j + 1, resultList2.get(j));
					resultList2.set(j, m);
				}
			}
		}

		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList2);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}

	public String query2() {
		return this.query();
	}

	public String select() {
		return this.query();
	}

	public String query4front() {
		MusicInfo entity = new MusicInfo();
		// entity.setTypes(this.types);
		entity.setMusicname(this.musicname);

		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getSession().getAttribute("frontUsername") == null) {

			entity.setUsername("----");
		} else {
			String loginid = (String) request.getSession().getAttribute("frontUsername");
			entity.setUsername(loginid);
		}

		// entity.setRenqi(this.renqi);
		// entity.setTuijian(this.tuijian);
		// entity.setShenhe(this.shenhe);
		condition = new DefaultQueryCondition(entity);
		// HttpServletRequest request = ServletActionContext.getRequest();
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
		return Const.Pages.MAPPING_URL;
	}

	@Resource
	private CollectMusicManager collectMusicManager;

	public void shoucang() {
		MusicInfo entity2 = this.musicInfoManager.queryById(this.id);
		CollectMusic entity = new CollectMusic();
		Map<String,Object> map = new HashMap<>();
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			if (request.getSession().getAttribute("u") == null) {
				map.put("code", 401);
				map.put("msg", "请先登录！");
			} else {
				Admin loginid = (Admin) request.getSession().getAttribute("u");
				entity.setStuid(loginid.getUsername());
				entity.setStuname(loginid.getRemark());
				List<CollectMusic> ll = collectMusicManager
						.queryByHql("from CollectMusic where stuid='" + loginid.getUsername() + "' and musicid='" + id + "'");
				if (ll != null && ll.size() > 0) {
					collectMusicManager.deleteViaId(ll.get(0).getId());
					map.put("code", 402);
					map.put("msg", "取消收藏成功！");
				} else {
					MusicInfo m = musicInfoManager.queryById(entity2.getId());
					String renqi = m.getRenqi();
					m.setRenqi(String.valueOf((Integer.parseInt(renqi) + 1)));
					musicInfoManager.update(m);
					entity.setContent(entity2.getContent());
					entity.setMusicid(entity2.getId() + "");
					entity.setTypes(entity2.getTypes());
					entity.setMusicname(entity2.getMusicname());
					entity.setFile(entity2.getFile());
					entity.setYcz(entity2.getUsername());
					entity.setImg(loginid.getFile());
					this.collectMusicManager.add(entity);
					map.put("code", 200);
					map.put("msg", "收藏成功！");
				}
				AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
			}
		} catch (Exception e) {
			map.put("code", 403);
			map.put("msg", "服务器发生错误啦，请稍后再试！");
			
			
		}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));

	}

	public String query4front2() {
		MusicInfo entity = new MusicInfo();
		entity.setTypes(this.types);
		entity.setMusicname(this.musicname);
		// entity.setUsername(this.username);
		// entity.setRenqi(this.renqi);
		// entity.setTuijian(this.tuijian);
		entity.setShenhe("通过");
		condition = new DefaultQueryCondition(entity);
		HttpServletRequest request = ServletActionContext.getRequest();
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
		List<MusicInfo> resultList2 = new ArrayList<MusicInfo>();
		for (MusicInfo m : resultList) {
			int sum = 0;
			int m_id = m.getId();
			List<CollectMusic> cmlist = this.musicInfoManager.getMusicCoo(m_id);
			List<PingLun> pllist = this.musicInfoManager.getMusicPinglun(m_id);
			System.out.println(pllist.size());
			sum = cmlist.size() + pllist.size();
			m.setRenqi(sum + "");
			resultList2.add(m);
		}
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList2);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}

	@Resource
	private PingLunManager pingLunManager;

	public String detail4front() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);

		List ll = pingLunManager.queryByHql("from PingLun where musicid = '" + this.id + "'");
		ActionContext.getContext().put("result2", ll);

		return Const.Pages.MAPPING_URL;
	}
	public String musicInfo() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		List ll = pingLunManager.queryByHql("from PingLun where musicid = '" + this.id + "'");
		int flag=0;
		List<CollectMusic> list = collectMusicManager.queryByHql("from CollectMusic where musicid = '" + this.id + "'  ");
		//是否收藏
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getSession().getAttribute("u") != null) {
			Admin admin = (Admin) request.getSession().getAttribute("u");
			Iterator<CollectMusic> iterator = list.iterator();
			while(iterator.hasNext()){
				CollectMusic next = iterator.next();
				if(next.getStuid().endsWith(admin.getUsername())){
					flag=1;
					iterator.remove();
				}
			}
			
		}
		List<CollectMusic> subList=subList =list.size()>4? list.subList(0, 4):list;
		ActionContext.getContext().put("list", subList);
		ActionContext.getContext().put("result2", ll);
		ActionContext.getContext().put("flag", flag);
		ActionContext.getContext().put("size", ll.size());
		return "musicInfo";
	}

	public void add4huifu() {
		MusicInfo entity = this.musicInfoManager.queryById(this.id);
		HttpServletRequest request = ServletActionContext.getRequest();
		String loginid="";
		String remark="";
		Map<String,Object> map = new HashMap<>();
		if (request.getSession().getAttribute("u") == null) {

		} else {
			Admin admin = (Admin) request.getSession().getAttribute("u");
			loginid = admin.getUsername();
			remark = admin.getRemark();
			img = admin.getFile();
		}
		PingLun entity2 = new PingLun();
		try {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			entity2.setDate(sf.format(new Date()));
			entity2.setContent(this.content);
			entity2.setMusicid(this.id + "");
			entity2.setMusicname(entity.getMusicname());
			entity2.setPinlunid(loginid);
			entity2.setImg(img);
			entity2.setPinglunname(remark);
			List<PingLun> ll = pingLunManager.queryByHql("from PingLun where musicid = '" + this.id + "' order by last desc");
			entity2.setLast(ll.size()==0?1:ll.get(0).getLast()+1);
			//获取该首的评论数;
			if (this.content != null && this.content.trim() != "") {
				this.pingLunManager.add(entity2);
			}
		} catch (Exception e) {
			ActionContext.getContext().put(Const.Notification.ERROR, e.getMessage());
		}
		entity2.setDatetimestr("1");
		map.put("data", entity2);
		map.put("msg", "回复成功");
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));

		/*;
		ActionContext.getContext().put("result2", ll);*/

	}

	@Resource
	private AdminManager adminManager;

	public String query4userinfo() {
		ApplyInfo entity = new ApplyInfo();
		// adm.setUsername(this.username);
		entity.setStatus("审核通过");
		condition = new DefaultQueryCondition(entity);
		HttpServletRequest request = ServletActionContext.getRequest();
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<ApplyInfo> page = this.applyInfoManager.getRecords(condition);
		List<ApplyInfo> resultList = page.getList();

		//
		/*
		 * for(int i =0; i < resultList.size(); i++){ Admin aa = resultList.get(i);
		 * DengJi dengji = dengJiManager.querySingleRecordViaKey("username",
		 * aa.getUsername()); aa.setHunyinstatus(dengji.getChecktype());
		 * aa.setHunling(dengji.getLoveyear()); }
		 */

		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO, page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}

	public void xiazai() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String fileName = request.getParameter("name");
		String path = request.getSession().getServletContext().getRealPath("/") + "attachment\\" + fileName;
		File f = new File(path);
		InputStream fis = new BufferedInputStream(new FileInputStream(path));
		byte[] buffer = new byte[fis.available()];
		response.setContentType("application/octet-stream");
		response.addHeader("Content-Disposition",
				"attachment; filename=" + new String(fileName.getBytes("GBK"), "iso-8859-1"));
		OutputStream out = response.getOutputStream();
		out.write(buffer);
		out.flush();
		out.close();

	}
	
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public static void main(String[] args) {
		File f = new File(
				"E:\\eclipse\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MusicWeb\\attachment\\1704170147137541.mp3");
		if (f.exists()) {
			System.out.println(1);
		}
	}
}
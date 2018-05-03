package com.pro.action;

import com.base.common.util.Const;
import com.base.common.util.EntityAnnotation;
import com.pro.entity.ApplyInfo;
import com.pro.entity.Classify;
import com.pro.entity.CollectMusic;
import com.pro.entity.MusicInfo;
import com.pro.entity.News;
import com.pro.entity.PingLun;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.web.tag.BTAGI18N;
import com.opensymphony.xwork2.ActionContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import javax.annotation.Resource;
import com.base.common.util.CommonUtil;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;

import com.pro.manager.ApplyInfoManager;
import com.pro.manager.ClassifyManager;
import com.pro.manager.MusicInfoManager;
import com.pro.manager.NewsManager;

@Controller
public class ClassifyAction {
	@Resource
	private ClassifyManager classifyManager;
	private int id;
	@Resource
	private MusicInfoManager musicInfoManager;
	@Resource
	private NewsManager newsManager;
	@Resource
	private ApplyInfoManager applyInfoManager;
	@EntityAnnotation(desc = "部门名称", needUpdate = false, isQueryField = false, rule = "CHAR_M_1024")
	private String name;

	@EntityAnnotation(desc = "部门介绍", needUpdate = true, isQueryField = false, rule = "CHAR_N")
	private String remark;
	
	@EntityAnnotation(desc="歌曲类别",needUpdate=true,isQueryField=true,rule ="SELE_M;翻唱;原创")
	private String types;
	
	@EntityAnnotation(desc="歌曲名称",rule="CHAR_M_120",isDetailLink=true,needUpdate=false,isQueryField=true)
	private String musicname;
	
	@EntityAnnotation(desc="歌词",rule="CHAR_N_120",needUpdate=true,isQueryField=false)
	private String content;

	@EntityAnnotation(desc="上传",rule="CHAR_M_120",needUpdate=false,isQueryField=false)
	private String file;
	
	@EntityAnnotation(desc="发布者id",  needShow = false)
	private String userid;
	
	@EntityAnnotation(desc="发布者",  needUpdate=false, isQueryField = true, rule ="CHAR_M")
	private String username;
	
	@EntityAnnotation(desc="人气歌曲",needUpdate=true,isQueryField=true,rule ="SELE_M;否;是")
	private String renqi;
	
	@EntityAnnotation(desc="推荐歌曲",needUpdate=true,isQueryField=true,rule ="SELE_M;否;是")
	private String tuijian;
	
	@EntityAnnotation(desc="发布日期",rule="DATE_M")
	private String date;
	
	@EntityAnnotation(desc="审核",needUpdate=true,isQueryField=true,rule ="SELE_M;提交;通过;未过")
	private String shenhe;
	
	@EntityAnnotation(desc="作词者",rule="CHAR_N_120",needUpdate=true,isQueryField=false)
	private String zuociz;
	@EntityAnnotation(desc="编曲者",rule="CHAR_N_120",needUpdate=true,isQueryField=false)
	private String bqz;
	@EntityAnnotation(desc="演唱者",rule="CHAR_N_120",needUpdate=true,isQueryField=false)
	private String ycz;
	@EntityAnnotation(desc="原唱",rule="CHAR_N_120",needUpdate=true,isQueryField=false)
	private String yuanchang;
	
	

	public ClassifyManager getClassifyManager() {
		return classifyManager;
	}

	public void setClassifyManager(ClassifyManager classifyManager) {
		this.classifyManager = classifyManager;
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

	public DefaultQueryCondition getCondition() {
		return condition;
	}

	public void setCondition(DefaultQueryCondition condition) {
		this.condition = condition;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	private DefaultQueryCondition condition;
	private Page page;

	public String add() {
		Classify entity = new Classify();
		try {
			entity.setName(this.name);
			this.classifyManager.add(entity);
			String returnMsg = BTAGI18N.getI18NValue("add.success", "common");
			ActionContext.getContext().put(Const.Notification.SUCCESS, returnMsg);
			return Const.Pages.MAPPING_URL;
		} catch (Exception e) {
			ActionContext.getContext().put(Const.Notification.ERROR, e.getMessage());
			return Const.Pages.MAPPING_URL;
		}
	}

	public String del() {
		this.classifyManager.deleteViaId(this.id);
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		return Const.Pages.QUERY_DO;
	}

	public String dels() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String ids = request.getParameter("ids");
		String[] idList = ids.split(",");
		int len = idList.length;
		for (int i = 0; i < len; i++) {
			this.classifyManager.deleteViaId(Integer.parseInt(idList[i]));
		}
		return Const.Pages.QUERY_DO;
	}

	public String update() {
		Classify entity = this.classifyManager.queryById(this.id);
		this.classifyManager.update(entity);
		return Const.Pages.QUERY_DO;
	}

	public String edit() {
		Classify entity = this.classifyManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String detail() {
		Classify entity = this.classifyManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String detail4front() {
		Classify entity = this.classifyManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String query() {
		Classify entity = new Classify();
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
		Page<Classify> page = this.classifyManager.getRecords(condition);
		List<Classify> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
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
		List<Classify> resultList = classifyManager.queryAll();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put("needtoload", "NO");
		return "gotoindex";
	}
	

}
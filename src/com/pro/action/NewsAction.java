package com.pro.action;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.base.common.util.AjaxReturnInfo;
import com.base.common.util.Const;
import com.base.common.util.EntityAnnotation;
import com.base.sys.entity.Admin;
import com.pro.entity.News;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.web.tag.BTAGI18N;
import com.opensymphony.xwork2.ActionContext;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import javax.annotation.Resource;
import com.base.common.util.CommonUtil;
import org.springframework.stereotype.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import com.pro.manager.NewsManager;

@Controller
public class NewsAction {
	@Resource
	private NewsManager newsManager;
 private int id;
	
	@EntityAnnotation(desc="标题",  needUpdate=false, isQueryField = true, rule ="CHAR_M")
	private String title;
	@EntityAnnotation(desc="内容",  needUpdate=true, isQueryField = true, rule ="CHAR_M")
	private String content;
	
	@EntityAnnotation(desc="发布者id",  needShow = false)
	private String userid;
	
	@EntityAnnotation(desc="发布者",  needUpdate=false, isQueryField = true, rule ="CHAR_M")
	private String username;
	
	@EntityAnnotation(desc="时间", needUpdate=false, rule ="DATE_N")
	private String datetime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	
	
	

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}





	private DefaultQueryCondition condition;
	private Page page;
	public void add() {
		News entity = new News();
		JSONObject jsonObject = new JSONObject();
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			Admin admin = (Admin) request.getSession().getAttribute("u");
			entity.setContent(this.content);
			entity.setTitle(this.title);
			entity.setUserid(admin.getUsername());
			entity.setUsername(admin.getRemark());
			SimpleDateFormat s=new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			entity.setDatetime(s.format(new Date()));
			this.newsManager.add(entity);
			jsonObject.put("code",200);
			jsonObject.put("msg","添加成功");
		} catch(Exception e) {
			jsonObject.put("code",400);
			jsonObject.put("msg","添加失败");
		}
		AjaxReturnInfo.stringPrint(jsonObject.toJSONString());
	}

	public String del() {
		this.newsManager.deleteViaId(this.id);
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		return Const.Pages.QUERY_DO;
	}

	public String dels() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String ids = request.getParameter("ids");
		String[] idList = ids.split(",");
		int len = idList.length;
		for(int i=0;i<len;i++) {
			this.newsManager.deleteViaId(Integer.parseInt(idList[i]));
		}
		return Const.Pages.QUERY_DO;
	}

	public void update() {
		News entity = this.newsManager.queryById(this.id);
		entity.setContent(this.content);
		entity.setUserid(this.userid);
		this.newsManager.update(entity);
		JSONObject json =new JSONObject();
		json.put("code",200);
		json.put("msg","修改成功");
		this.title =null;
		content = null;
		username = null;
		AjaxReturnInfo.stringPrint(json.toJSONString());
	}

	public String edit() {
		News entity = this.newsManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String detail() {
		News entity = this.newsManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}
	
	public String detail4front() {
		News entity = this.newsManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return "newsinfo";
	}

	public String query() {
		News entity = new News();
		entity.setContent(this.content);
		entity.setTitle(this.title);
		entity.setUsername(this.username);
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
		Page<News> page = this.newsManager.getRecords("datetime","DESC",condition);
		List<News> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}

	public String query4front() {
		News entity = new News();
		//entity.setContent(this.content);
		//entity.setTitle(this.title);
		//entity.setUsername(this.username);
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
		Page<News> page = this.newsManager.getRecords(condition);
		List<News> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}
	
	public String query2() {
		return this.query();
 }	public String select() {
		return this.query();
 }}
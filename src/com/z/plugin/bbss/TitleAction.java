package com.z.plugin.bbss;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONObject;
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
import com.pro.entity.Classify;
import com.pro.entity.CollectTitle;
import com.pro.entity.PingLun;
import com.pro.manager.ClassifyManager;
import com.pro.manager.CollectTitleManager;

@Controller
public class TitleAction {
	@Resource
	private TitleManager titleManager;
    private int id;
    @Resource
	private ClassifyManager classifyManager;
    @Resource
   	private CollectTitleManager collectTitleManager;
	@EntityAnnotation(desc="标题",  needUpdate=false, isQueryField = true, rule ="CHAR_M")
	private String title;
	@EntityAnnotation(desc="内容",  needUpdate=true, isQueryField = true, rule ="CHAR_M")
	private String content;
	@EntityAnnotation(desc="发布者id",  needShow = false)
	private String userid;
	@EntityAnnotation(desc="发布者",  needUpdate=false, isQueryField = true, rule ="CHAR_M")
	private String username;
	private String type;
	private String ishot;
	private String img;
	@EntityAnnotation(desc="时间", needUpdate=false, rule ="DATE_N")
	private Date datetime;

	public String getIshot() {
		return ishot;
	}

	public void setIshot(String ishot) {
		this.ishot = ishot;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

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

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}
	private DefaultQueryCondition condition;
	private Page page;
	
	@Resource
	private MessageManager messageManager;
	public String tofatie() {
		return "fatie";
	}

	public void add() throws Exception {
		Title entity = new Title();
		Map<String,Object> map = new HashMap<>();
		HttpServletRequest request = ServletActionContext.getRequest();
		if(request.getSession().getAttribute("u") != null){
			Admin admin= (Admin) request.getSession().getAttribute("u");
			entity.setContent(this.content);
			entity.setType(this.type);
			entity.setUserid(admin.getUsername());
			entity.setUsername(admin.getRemark());
			SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			entity.setDatetime(s.format(new Date()));
			entity.setTitle(this.title);
			entity.setImg(admin.getFile());
			this.titleManager.add(entity);
			content="";
			userid ="";
			username = "";
			datetime =null;
			title = null;
			map.put("code", 200);
			map.put("msg", "发帖成功");
			}else {
				map.put("code", 201);
				map.put("msg", "登陆后,再发帖");
			}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}
	public String addUI() {
		List<Classify> queryByHql = classifyManager.queryByHql("from Classify ");
		ActionContext.getContext().put("list", queryByHql);
		return "addui";
	}
	public String addAdminUI() {
		List<Classify> queryByHql = classifyManager.queryByHql("from Classify ");
		ActionContext.getContext().put("list", queryByHql);
		return "addAdminUI";
	}

	
	public String del() {
		this.titleManager.deleteViaId(this.id);
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		return "delDO";
	}

	public String admindel() {
		this.titleManager.deleteViaId(this.id);
		ActionContext.getContext().put(Const.Notification.SUCCESS, BTAGI18N.getI18NValue("delete.success", "common"));
		return Const.Pages.QUERY_DO;
	}
	public String hot() {
		Title title=titleManager.queryById(this.id);
		if("1".equals(title.getIshot())){
			title.setIshot("0");
		}else{
			title.setIshot("1");
		}
			this.titleManager.update(title);
		return Const.Pages.QUERY_DO;
	}
	public String top() {
		Title title=titleManager.queryById(this.id);
		if("1".equals(title.getIstop())){
			title.setIstop("0");
		}else{
			title.setIstop("1");
		}
		this.titleManager.update(title);
		return Const.Pages.QUERY_DO;
	}

	public String dels() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String ids = request.getParameter("ids");
		String[] idList = ids.split(",");
		int len = idList.length;
		for(int i=0;i<len;i++) {
			this.titleManager.deleteViaId(Integer.parseInt(idList[i]));
		}
		return Const.Pages.QUERY_DO;
	}


	public String update() {
		Title entity = this.titleManager.queryById(this.id);
		entity.setContent(this.content);
		entity.setUserid(this.userid);
		this.titleManager.update(entity);
		return Const.Pages.QUERY_DO;
	}

	public String edit() {
		Title entity = this.titleManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}


	
	public String detail() {
		Title entity = this.titleManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity);
		return Const.Pages.MAPPING_URL;
	}

	public String bbsDetail() throws ParseException {
		Title entity2 = this.titleManager.queryById(this.id);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, entity2);
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin u = (Admin) request.getSession().getAttribute("u");
		int flag=0;
		List<Message> resultList = this.messageManager.queryByHql("from Message where title='"+id+"'");
		List<CollectTitle> like = this.collectTitleManager.queryByHql("from CollectTitle where titleid='"+id+"'");
		if(u!=null) {
			for(CollectTitle one :like) {
				if(one.getStuid().equals(u.getUsername())){
					flag=1;
					break;
				}
			}
		}
		ActionContext.getContext().put("flag", flag);
		ActionContext.getContext().put("result2", resultList);
		ActionContext.getContext().put("likeCount", like.size());
		ActionContext.getContext().put("count", resultList.size());
		return "bbsDetail";
	}
	
	public void addLike() throws Exception  {
		
		Title entity = this.titleManager.queryById(this.id);
		HttpServletRequest request = ServletActionContext.getRequest();
		Admin u = (Admin) request.getSession().getAttribute("u");
		JSONObject json = new JSONObject();
		if(u==null) {
			json.put("code", 3);
			json.put("msg", "请登录后再操作");
		}else {
			List<CollectTitle> collectTitle = collectTitleManager.getCollectTitle(this.id+"",u.getUsername());
			if(collectTitle==null || collectTitle.size()==0) {
				CollectTitle co = new CollectTitle();
				co.setStuid(u.getUsername());
				co.setStuname(u.getRemark());
				co.setTitleid(this.id);
				co.setTitlename(entity.getTitle());
				co.setTypes(entity.getType());
				collectTitleManager.add(co);
				json.put("code", 1);
			}else {
				collectTitleManager.delete(collectTitle.get(0));
				json.put("code", 2);
			}
			
		}
		AjaxReturnInfo.stringPrint(json.toJSONString());
		
		
	}
	
	public void huifu(){
		Message entity = new Message();
		JSONObject json  =new JSONObject();
		Admin a=(Admin) ActionContext.getContext().getSession().get("u");
		if(a==null){
			json.put("msg", "请登录后操作");
			json.put("code", "0");
		
		}else {
			
			try {
				entity.setContent(this.content);
				SimpleDateFormat sfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				entity.setUsername(a.getRemark());
				entity.setUserid(a.getUsername());
				entity.setDatetime(sfd.format(new Date()));
				entity.setTitle(id+"");
				entity.setImg(a.getFile());
				List<Message> ll = messageManager.queryByHql("from Message where title = '" + this.id + "' order by last desc");
				entity.setLast(ll.size()==0?1:ll.get(0).getLast()+1);
				this.messageManager.add(entity);
				userid ="";
				username ="";
				content ="";
				json.put("msg", "评论成功");
				json.put("code", "1");
				json.put("data", entity);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		AjaxReturnInfo.stringPrint(json.toJSONString());
		
	}
	@Resource
	private AdminManager adminManager;
	
	public String query() {
		Title entity = new Title();
		entity.setContent(this.content);
		entity.setUsername(this.username);
		HttpServletRequest request = ServletActionContext.getRequest();
		entity.setTitle(this.title);
		condition = new DefaultQueryCondition(entity);
		String curPage = request.getParameter(Page.CURRENT_PAGE);
		String pageSize = request.getParameter(Page.PAGE_SIZE);
		if (CommonUtil.isNotEmpty(curPage)) {
			condition.setPageIndex(Integer.parseInt(curPage));
		}
		if (CommonUtil.isNotEmpty(pageSize)) {
			condition.setPageSize(Integer.parseInt(pageSize));
		}
		Page<Title> page = this.titleManager.getRecords("datetime","DESC",condition);
		List<Title> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}
	
	
	public String myTitle() {
		Title entity = new Title();
		Admin a=(Admin) ActionContext.getContext().getSession().get("u");
        entity.setUserid(a.getUsername());
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
		Page<Title> page = this.titleManager.getRecords("datetime","DESC",condition);
		List<Title> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "mytitle";
	}

	public String query4front() {
		Title entity = new Title();
		entity.setContent(this.content);
		entity.setUsername(this.username);
		entity.setTitle(this.title);
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
		Page<Title> page = this.titleManager.getRecords(condition);
		List<Title> resultList = page.getList();
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return Const.Pages.MAPPING_URL;
	}
	public String bbsList() {
		Title entity = new Title();
		entity.setContent(this.content);
		entity.setUsername(this.username);
		entity.setTitle(this.title);
		entity.setType(this.type);
		entity.setIshot(this.ishot);
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
		Page<Title> page = this.titleManager.getRecords("datetime","DESC",condition);
		List<Title> resultList = page.getList();
		for(Title one :resultList) {
			List<Message> count = this.messageManager.queryByHql("from Message where title='"+one.getId()+"'");
			one.setCount(count.size());
		}
		type=null;
		this.username=null;
		List<Title> hot = titleManager.queryByHql("from Title group by userid order by count(userid) desc limit 4");
		this.ishot=null;
		List<Title> hotbbs = titleManager.queryByHql("from Title where istop=1 order by datetime desc limit 4");
		List<Classify> queryByHql = classifyManager.queryByHql("from Classify ");
		ActionContext.getContext().put("classlist", queryByHql);
		ActionContext.getContext().put("hot", hot);
		ActionContext.getContext().put("hotbbs", hotbbs);
		ActionContext.getContext().put(Const.Action.PAGE_REUSLT, resultList);
		ActionContext.getContext().put(Const.Action.PAGINATION_INFO,page.getNavigation());
		ActionContext.getContext().put(Page.CURRENT_PAGE, page.getCurrentPage());
		return "bbsList";
	}
	public String query2() {
		return this.query();
 }	public String select() {
		return this.query();
 }}
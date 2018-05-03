package com.pro.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSONObject;
import com.base.common.util.AjaxReturnInfo;
import com.base.common.util.CommonUtil;
import com.base.pagination.util.Page;
import com.base.sys.entity.Admin;
import com.base.sys.manager.AdminManager;
import com.opensymphony.xwork2.ActionContext;
import com.pro.entity.Fans;
import com.pro.manager.FansManager;

@Controller
public class FansAction {
	
	private String userId;
	@Resource
	private FansManager fansManager;
	@Resource
	private AdminManager adminManager;
	
	public void add() throws Exception {
		Map<String,Object> map = new HashMap();
		Admin admin  = CommonUtil.getCurrentUser();
		if(admin==null) {
			map.put("code", 0);
			map.put("msg", "登录后再操作");
		}else {
			Fans fans = new Fans();
	
			Admin user = adminManager.getAdminByUsername(userId);
			 String hql="from Fans where userId='"+userId+"' and followId='"+admin.getUsername()+"'";
			List<Fans> list = fansManager.queryByHql(hql);
			if(list!=null && list.size()>0) {
				Fans fans2 = list.get(0);
				fansManager.deleteViaId(fans2.getId());
				map.put("code", 2);
				map.put("msg", "取消关注成功");
			}else {
				fans.setUserId(userId);
				fans.setUserName(user.getRemark());
				fans.setUserImg(user.getFile());
				fans.setFollowId(admin.getUsername());
		        fans.setFollowImg(admin.getFile());
		        fans.setFollowName(admin.getRemark());
				fansManager.add(fans);
				map.put("code", 1);
				map.put("msg", "关注成功");
			}
		}
		AjaxReturnInfo.stringPrint(JSONObject.toJSONString(map));
	}
	
	public String fans() {
		Admin admin  = CommonUtil.getCurrentUser();
		String hql="from Fans where followId='"+admin.getUsername()+"'";
		List<Fans> fanslist = fansManager.queryByHql(hql);
		
		String hql2="from Fans where userId='"+admin.getUsername()+"'";
		List<Fans> followlist = fansManager.queryByHql(hql2);
		
		ActionContext.getContext().put("fanslist", fanslist);
		ActionContext.getContext().put("followlist", followlist);
		return "fans";
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}

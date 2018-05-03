package com.pro.entity;

import com.base.common.util.EntityAnnotation;

public class CollectTitle {
	
	private int id;
	@EntityAnnotation(desc="用户ID",needShow=false,isQueryField=false)
	private String stuid;
	
	@EntityAnnotation(desc="用户",needUpdate=false,isQueryField=false)
	private String stuname;
	
	@EntityAnnotation(desc="帖子ID",needShow=false,isQueryField=false)
	private Integer titleid;
	
	@EntityAnnotation(desc="帖子类别",needUpdate=true,isQueryField=true)
	private String types;
	
	@EntityAnnotation(desc="帖子名称",isDetailLink=true,needUpdate=false,isQueryField=true)
	private String titlename;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStuid() {
		return stuid;
	}

	public void setStuid(String stuid) {
		this.stuid = stuid;
	}

	public String getStuname() {
		return stuname;
	}

	public void setStuname(String stuname) {
		this.stuname = stuname;
	}
	
	public Integer getTitleid() {
		return titleid;
	}

	public void setTitleid(Integer titleid) {
		this.titleid = titleid;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public String getTitlename() {
		return titlename;
	}

	public void setTitlename(String titlename) {
		this.titlename = titlename;
	}
	
	
}

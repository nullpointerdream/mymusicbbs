package com.base.sys.entity;

import com.base.common.util.EntityAnnotation;
import com.base.sys.entity.BaseEntity;

public class Shortcut extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7447574369431412501L;
	@EntityAnnotation(beanName = "首页推荐", needShow = false)
	private int id;
	@EntityAnnotation(desc = "推荐名称", isDetailLink = true, isQueryField = true, rule = "CHAR_M_200")
	private String name;
	@EntityAnnotation(desc = "推荐地址", rule = "CHAR_M_200")
	private String url;
	@EntityAnnotation(needShow = false, needUpdate = false)
	private String username;
	private String img;

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}

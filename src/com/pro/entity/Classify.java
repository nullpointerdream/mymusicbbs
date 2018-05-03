package com.pro.entity;

import com.base.common.util.EntityAnnotation;
import com.base.sys.entity.BaseEntity;

public class Classify extends BaseEntity {

	@EntityAnnotation(needShow=false,beanName="分类")
	private int id;
	
	
	@EntityAnnotation(desc="分类名称",needUpdate=false, isQueryField = false,rule="CHAR_M_1024")
	private String name;

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




	
	
}

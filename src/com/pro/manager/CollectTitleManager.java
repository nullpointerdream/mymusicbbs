package com.pro.manager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.sys.dao.IBaseDAO;
import com.pro.entity.CollectTitle;

@Service
public class CollectTitleManager {
	@Resource private IBaseDAO collectTitleDAOImpl;
	
	public void add(CollectTitle entity) throws Exception {
		try {
			this.collectTitleDAOImpl.add(entity);
		} catch(Exception e) {
			throw new Exception("添加失败");
		}
	}

	 public  void delete(CollectTitle entity){
		 try{
		 this.collectTitleDAOImpl.delete(entity);
		 }catch(Exception e){
			 System.out.println(e);
		 }
	 }
	
	public boolean isExist(String key, String value) {
		List list = this.collectTitleDAOImpl.getViaHql("from CollectTitle where titleid='"+key+"' and stuid='"+value+"'");
		return (list != null && list.size() > 0) ? true : false;
	}

	public List<CollectTitle> getCollectTitle(String key, String value) {
		List<CollectTitle> list = this.collectTitleDAOImpl.getViaHql("from CollectTitle where titleid='"+key+"' and stuid='"+value+"'");
		return list;
	}
	
	public List<CollectTitle> queryAll() {
		return this.collectTitleDAOImpl.getAll();
	}

	public void deleteViaId(Integer id) {
		this.collectTitleDAOImpl.delete(id);
	}

	public List queryByHql(String hql) {
		return this.collectTitleDAOImpl.getViaHql(hql);
	}

	public CollectTitle queryById(Integer id) {
		return (CollectTitle)this.collectTitleDAOImpl.getById(id);
	}

	public CollectTitle querySingleRecordViaKey(String key, String value) {
		List list = this.collectTitleDAOImpl.getViaHql("from CollectTitle where "+key+"='"+value+"'");
	if(list != null && list.size() > 0){
		return (CollectTitle)this.collectTitleDAOImpl.getViaHql("from CollectTitle where "+key+"='"+value+"'").get(0);
	}else{
	return null;
	}
	}
	public void update(CollectTitle entity) {
		this.collectTitleDAOImpl.update(entity);
	}

	public Page<CollectTitle> getRecords(DefaultQueryCondition condition) {
		return this.collectTitleDAOImpl.getRecord(condition);
	}
}

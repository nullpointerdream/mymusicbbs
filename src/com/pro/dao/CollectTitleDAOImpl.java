package com.pro.dao;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.sys.dao.BaseDAO;
import com.pro.entity.CollectMusic;
import com.pro.entity.CollectTitle;

@Service
@Transactional
public class CollectTitleDAOImpl extends BaseDAO<CollectTitle, Integer>{
	@Resource private SessionFactory sessionFactory;
	protected Class<CollectTitle> getReferenceClass() {
		return CollectTitle.class;
	}
	@Override
	public Page getRecord(DefaultQueryCondition condition) {
		
		return null;
	}

	@Override
	public Page getRecord(String column, String order, DefaultQueryCondition condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected SessionFactory getSessionFactory() {
		
		return this.sessionFactory;
	}

	

}

package com.pro.dao;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import com.base.common.util.CommonUtil;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.base.sys.dao.BaseDAO;
import com.pro.entity.ApplyInfo;
import com.pro.entity.Fans;

@Service
@Transactional
public class FansDAOImpl extends BaseDAO<Fans, Integer> {
	@Resource private SessionFactory sessionFactory;
	protected Class<Fans> getReferenceClass() {
		return Fans.class;
	}

	protected SessionFactory getSessionFactory() {
		return this.sessionFactory;
	}

	@Override
	public Page getRecord(DefaultQueryCondition condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Page getRecord(String column, String order, DefaultQueryCondition condition) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
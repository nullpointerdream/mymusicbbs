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
import com.pro.entity.Classify;

@Service
@Transactional
public class ClassifyDAOImpl extends BaseDAO<Classify, Integer> {
	@Resource private SessionFactory sessionFactory;
	protected Class<Classify> getReferenceClass() {
		return Classify.class;
	}

	protected SessionFactory getSessionFactory() {
		return this.sessionFactory;
	}

	public Page<Classify> getRecord(DefaultQueryCondition condition) {
		Classify entity = (Classify)condition.getCondition();
		return this.getPagers(condition);
	}

	@Override
	public Page getRecord(String column, String order,
                          DefaultQueryCondition condition) {
		// TODO Auto-generated method stub
		return null;
	}
}
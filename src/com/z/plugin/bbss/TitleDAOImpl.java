package com.z.plugin.bbss;
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

@Service
@Transactional
public class TitleDAOImpl extends BaseDAO<Title, Integer> {
	@Resource private SessionFactory sessionFactory;
	protected Class<Title> getReferenceClass() {
		return Title.class;
	}

	protected SessionFactory getSessionFactory() {
		return this.sessionFactory;
	}

	public Page<Title> getRecord(DefaultQueryCondition condition) {
		Title entity = (Title)condition.getCondition();
		
		Criterion cr1 = null;
		if(CommonUtil.isNotEmpty(entity.getTitle())) {
			cr1 = Restrictions.like("title",entity.getTitle(), MatchMode.ANYWHERE);
		}
		Criterion cr2 = null;
		if(CommonUtil.isNotEmpty(entity.getContent())) {
			cr2 = Restrictions.like("content",entity.getContent(), MatchMode.ANYWHERE);
		}
		Criterion cr3 = null;
		if(CommonUtil.isNotEmpty(entity.getUsername())) {
			cr3 = Restrictions.like("username",entity.getUsername(), MatchMode.ANYWHERE);
		}
		Criterion cr4 = null;
		if(CommonUtil.isNotEmpty(entity.getUserid())) {
			cr4 = Restrictions.eq("userid", entity.getUserid());
		}
		
		return this.getPagers(condition,cr1,cr2,cr3,cr4);
	}

	@Override
	public Page getRecord(String column, String order,
                          DefaultQueryCondition condition) {
		Title entity = (Title)condition.getCondition();
		
		Criterion cr1 = null;
		if(CommonUtil.isNotEmpty(entity.getTitle())) {
			cr1 = Restrictions.like("title",entity.getTitle(), MatchMode.ANYWHERE);
		}
		Criterion cr2 = null;
		if(CommonUtil.isNotEmpty(entity.getContent())) {
			cr2 = Restrictions.like("content",entity.getContent(), MatchMode.ANYWHERE);
		}
		Criterion cr3 = null;
		if(CommonUtil.isNotEmpty(entity.getUsername())) {
			cr3 = Restrictions.like("username",entity.getUsername(), MatchMode.ANYWHERE);
		}
		Criterion cr4 = null;
		if(CommonUtil.isNotEmpty(entity.getUserid())) {
			cr4 = Restrictions.eq("userid", entity.getUserid());
		}
		Criterion cr5 = null;
		if(CommonUtil.isNotEmpty(entity.getType())) {
			cr5 = Restrictions.eq("type", entity.getType());
		}
		return this.getPagers(column,order,condition,cr1,cr2,cr3,cr4,cr5);
	}
}
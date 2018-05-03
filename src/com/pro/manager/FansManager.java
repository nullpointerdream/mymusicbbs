package com.pro.manager;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.base.sys.dao.IBaseDAO;
import com.pro.entity.Fans;

@Service
public class FansManager {
	@Resource private IBaseDAO fansDAOImpl;
	
	public void add(Fans entity) throws Exception {
		try {
			this.fansDAOImpl.add(entity);
		} catch(Exception e) {
			throw new Exception("添加失败");
		}
	}
	
	public List<Fans> queryByHql(String hql) {
		return this.fansDAOImpl.getViaHql(hql);
	}
	
	public void deleteViaId(Integer id) {
		this.fansDAOImpl.delete(id);
	}
}

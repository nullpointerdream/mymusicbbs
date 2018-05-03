package com.pro.manager;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.base.sys.dao.IBaseDAO;
import com.base.pagination.util.DefaultQueryCondition;
import com.base.pagination.util.Page;
import com.pro.entity.Classify;

@Service
public class ClassifyManager{
    @Resource private IBaseDAO classifyDAOImpl;
    public void add(Classify entity) throws Exception {
        try {
            this.classifyDAOImpl.add(entity);
        } catch(Exception e) {
            throw new Exception("添加失败");
        }
    }

    public boolean isExist(String key, String value) {
        List list = this.classifyDAOImpl.getViaHql("from Classify where "+key+"='"+value+"'");
        return (list != null && list.size() > 0) ? true : false;
    }

    public List<Classify> queryAll() {
        return this.classifyDAOImpl.getAll();
    }

    public void deleteViaId(Integer id) {
        this.classifyDAOImpl.delete(id);
    }

    public List queryByHql(String hql) {
        return this.classifyDAOImpl.getViaHql(hql);
    }

    public Classify queryById(Integer id) {
        return (Classify)this.classifyDAOImpl.getById(id);
    }

    public Classify querySingleRecordViaKey(String key, String value) {
        List list = this.classifyDAOImpl.getViaHql("from Classify where "+key+"='"+value+"'");
    if(list != null && list.size() > 0){
        return (Classify)this.classifyDAOImpl.getViaHql("from Classify where "+key+"='"+value+"'").get(0);
    }else{
    return null;
    }
    }
    public void update(Classify entity) {
        this.classifyDAOImpl.update(entity);
    }

    public Page<Classify> getRecords(DefaultQueryCondition condition) {
        return this.classifyDAOImpl.getRecord(condition);
    }

}
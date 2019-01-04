package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.po.Med;


/**
 * @Title MedDao.java
 * @Package com.dao.impl
 * @version 1.0 
 * 药材dao实现类
 */
public class MedDao extends SqlMapClientDaoSupport implements IMedDao {

	@Override
	public Integer findByCount(Med med) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Med.findByCount",med);
	}
	
	@SuppressWarnings("unchecked")
	public List<Med> findByList(Med med) {
		return (List<Med>)getSqlMapClientTemplate().queryForList("Med.findByList",med);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Med> findByCpcPlant(Med med) {
		return (List<Med>)getSqlMapClientTemplate().queryForList("Med.findByCpcPlant",med);
	}

	@Override
	public Integer save(Med med) {
		return (Integer)getSqlMapClientTemplate().insert("Med.save",med);
	}
    
	public Med findByCpc(Med med) {
		List<Med> medlist = (List<Med>)getSqlMapClientTemplate().queryForList("Med.findByCpc",med);
		if(medlist!=null&&medlist.size()>0){
			return medlist.get(0);
		}else{
			return null;
		}
	}
	

}


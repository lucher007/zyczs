package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICheckMatDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;


public class CheckMatDao extends SqlMapClientDaoSupport implements ICheckMatDao {

	@Override
	public Integer save(CheckMat checkMat) {
		return (Integer) getSqlMapClientTemplate().insert("CheckMat.save", checkMat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CheckMat> findById(Check check) {
		return (List<CheckMat>)getSqlMapClientTemplate().queryForList("CheckMat.findById",check);
	}

	@Override
	public Integer deleteObejct(Integer matid) {
		return (Integer) getSqlMapClientTemplate().delete("CheckMat.deleteById",matid);
	}

	@Override
	public CheckMat findByIdMatImage(String matcontent) {
		return (CheckMat)getSqlMapClientTemplate().queryForObject("CheckMat.findByIdMatImage",matcontent);
	}
    
}

package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengFckTmpDao;
import cn.gov.zyczs.cspt.po.ChengFck;
import cn.gov.zyczs.cspt.po.ChengFckTmp;

/**
 * @Title ChengFckTmpDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ChengFckTmpDao extends SqlMapClientDaoSupport implements IChengFckTmpDao {

	@Override
	public ChengFckTmp findById(ChengFckTmp chengfcktmp) {
		return (ChengFckTmp)getSqlMapClientTemplate().queryForObject("ChengFckTmp.findById",chengfcktmp);
	}

	@Override
	public Integer findByCount(ChengFckTmp chengfcktmp) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengFckTmp.findByCount",chengfcktmp);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFckTmp> findByList(ChengFckTmp chengfcktmp) {
		return (List<ChengFckTmp>) getSqlMapClientTemplate().queryForList("ChengFckTmp.findByList",chengfcktmp);
	}

	@Override
	public Integer save(ChengFckTmp chengfcktmp) {
		return (Integer) getSqlMapClientTemplate().insert("ChengFckTmp.save",chengfcktmp);
	}

	@Override
	public Integer delete(ChengFckTmp chengfcktmp) {
		return (Integer) getSqlMapClientTemplate().delete("ChengFckTmp.delete",chengfcktmp);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFckTmp> quryByList(ChengFckTmp chengfcktmp) {
		return (List<ChengFckTmp>) getSqlMapClientTemplate().queryForList("ChengFckTmp.quryByList",chengfcktmp);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFckTmp> quryListByTmpid(ChengFckTmp chengfcktmp) {
		return (List<ChengFckTmp>) getSqlMapClientTemplate().queryForList("ChengFckTmp.quryListByTmpid",chengfcktmp);
	}
}

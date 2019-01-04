package cn.gov.zyczs.cspt.dao.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ILabelPrintDao;
import cn.gov.zyczs.cspt.po.LabelPrint;

public class LabelPrintDao extends SqlMapClientDaoSupport implements ILabelPrintDao{

	@Override
	public LabelPrint findByOrgId(LabelPrint labelPrint) {
		return (LabelPrint)getSqlMapClientTemplate().queryForObject("LabelPrint.findByOrgId",labelPrint);
	}

	@Override
	public Integer save(LabelPrint labelPrint) {
		return (Integer)getSqlMapClientTemplate().insert("LabelPrint.save",labelPrint);
	}

	@Override
	public Integer update(LabelPrint labelPrint) {
		return (Integer)getSqlMapClientTemplate().update("LabelPrint.update",labelPrint);
	}

}

package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.TabletBase;
import cn.gov.zyczs.cspt.po.ZyczsXml;


public class ZyczsXmlDao extends SqlMapClientDaoSupport implements IZyczsXmlDao {

	@Override
	public void saveOjbect(ZyczsXml zyczsXml) {
		getSqlMapClientTemplate().insert("ZyczsXml.save",zyczsXml);
	}

//	@Override
//	public Integer deleteById(String guid) {
//		return (Integer) getSqlMapClientTemplate().update("ZyczsXml.deleteById", guid);
//	}

	@Override
	public List<ZyczsXml> findByList() {
		return (List<ZyczsXml>)getSqlMapClientTemplate().queryForList("ZyczsXml.findByList");
	}

}

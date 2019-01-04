package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.po.CodeArea;

public class CodeAreaDao extends SqlMapClientDaoSupport implements ICodeAreaDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<CodeArea> findCodeAreaByPcode(CodeArea codeArea) {
		return getSqlMapClientTemplate().queryForList("CodeArea.findCodeAreaByPcode", codeArea);
	}

	@Override
	public String findByName(CodeArea codeArea) {
		return (String)getSqlMapClientTemplate().queryForObject("CodeArea.findByName", codeArea);
	}

	@Override
	public String findShortName(String code) {
		return (String)getSqlMapClientTemplate().queryForObject("CodeArea.findShortName", code);
	}

	@Override
	public String findNameByCode(String code) {
		return (String)getSqlMapClientTemplate().queryForObject("CodeArea.findNameByCode", code);
	}

}

package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.po.OrgUpload;

public class OrgUploadDao extends SqlMapClientDaoSupport implements IOrgUploadDao{

	@Override
	public Integer save(OrgUpload orgupload) {
		return (Integer) getSqlMapClientTemplate().insert("OrgUpload.save", orgupload);
	}

	@Override
	public List<OrgUpload> findByCondtion(OrgUpload orgupload) {
		return (List<OrgUpload>)getSqlMapClientTemplate().queryForList("OrgUpload.findByCondtion", orgupload);
	}

	@Override
	public Integer deleteObj(OrgUpload orgupload) {
		return getSqlMapClientTemplate().delete("OrgUpload.deleteObj", orgupload);
	}

	@Override
	public OrgUpload findByIdUploadImage(String uploadcontent) {
		return (OrgUpload)getSqlMapClientTemplate().queryForObject("OrgUpload.findByIdUploadImage", uploadcontent);
	}

	@Override
	public Integer updateByIds(OrgUpload orgUpload) {
		return (Integer)getSqlMapClientTemplate().update("OrgUpload.updateByIds",orgUpload);
	}

	@Override
	public List<OrgUpload> findUploadContent(OrgUpload orgUpload) {
		return (List<OrgUpload>)getSqlMapClientTemplate().queryForList("OrgUpload.findUploadContent",orgUpload);
	}

	@Override
	public List<OrgUpload> findByUploadids(OrgUpload orgUpload) {
		return (List<OrgUpload>)getSqlMapClientTemplate().queryForList("OrgUpload.findByUploadids",orgUpload);
	}

	@Override
	public Integer updateByTokenIdAndType(OrgUpload orgUpload) {
		return (Integer)getSqlMapClientTemplate().update("OrgUpload.updateByTokenIdAndType",orgUpload);
	}

	@Override
	public List<OrgUpload> findByTokenIdAndType(OrgUpload orgUpload) {
		return (List<OrgUpload>)getSqlMapClientTemplate().queryForList("OrgUpload.findByTokenIdAndType",orgUpload);
	}

	@Override
	public Integer updateByUploadId(OrgUpload orgUpload) {
		return (Integer)getSqlMapClientTemplate().update("OrgUpload.updateByUploadId",orgUpload); 
	}

}

package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.TabletBase;

/**
 * @Title IMedBaseDao.java
 * @version 1.0 
 * 药材基础
 */
public interface IMedBaseDao {
	
	/**
	 * 根据药材名称查询药材
	 * @param growMed
	 * @return
	 */
	public MedBase findByName(MedBase medBase);
	
	
	/**
	 * 分页查询 列表
	 * @param TabletBase
	 * @return 
	 */
	public List<MedBase> findByList(MedBase medBase);
	
	/**
	 * 分页查询 总记录
	 * @param TabletBase
	 * @return 
	 */
	public Integer findByCount(MedBase medBase);
}


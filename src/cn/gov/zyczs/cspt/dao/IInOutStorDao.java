package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.InOutStor;

/**
 * @Title IInOutStorageDao.java
 * @Package 
 * @version 1.0 
 * 出入库记录表
 */
public interface IInOutStorDao {
	/**
	 * 出入库添加
	 * @param inOutStorage
	 * @return
	 */
	public Integer save(InOutStor inOutStorage);
	/**
	 * 出入库更新
	 * @param inOutStorage
	 * @return
	 */
	public Integer updateById(InOutStor inOutStorage);
	/**
	 * 出入库分页总数
	 * @param inOutStorage
	 * @return
	 */
	public Integer findByCount(InOutStor inOutStorage);
	/**
	 * 出入库列表查询
	 * @param inOutStorage
	 * @return
	 */
	public List<InOutStor> findByList(InOutStor inOutStorage);
	
	/**
	 * 出入库查询根据ID
	 * @param inOutStorage
	 * @return
	 */
	public InOutStor findById(InOutStor inOutStorage);
	
	/**
	 * 采购企业名称 分页总数
	 * @param inOutStorage
	 * @return
	 */
	public Integer findByCompanyCount(InOutStor inOutStorage);
	
	/**
	 * 采购企业名称 列表查询
	 * @param inOutStorage
	 * @return
	 */
	public List<InOutStor> findByCompanyList(InOutStor inOutStorage);
	
	/**
	 * 查询企业最近6个月某个饮片的入库信息
	 * @param inOutStorage
	 * @return
	 */
	public List<InOutStor> findByList_Search(InOutStor inOutStorage);
	
}

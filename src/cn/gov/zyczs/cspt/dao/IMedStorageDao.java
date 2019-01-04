package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.MedStorage;

/**
 * @Title IMedStorageDao.java
 * @Package
 * @version 1.0 药材库存表接口
 */
public interface IMedStorageDao {

	/**
	 * 分页查询 列表
	 * 
	 * @param MedStorage
	 * @return
	 */
	public List<MedStorage> findByList(MedStorage medStorage);

	/**
	 * 分页查询 总记录
	 * 
	 * @param MedStorage
	 * @return
	 */
	public Integer findByCount(MedStorage medStorage);
	
	
	
	/**
	 * 批次分组分页查询 列表
	 * 
	 * @param MedStorage
	 * @return
	 */
	public List<MedStorage> findGroupByList(MedStorage medStorage);

	/**
	 * 批次分组分页查询 总记录
	 * 
	 * @param MedStorage
	 * @return
	 */
	public Integer findGroupByCount(MedStorage medStorage);
	
	
	
	/**
	 * 批次溯源称销售重量查询
	 * 
	 * @param MedStorage
	 * @return
	 */
	public Integer findChengWeightCount(String batchcpc,Integer orgid);
	
	/**
	 * 新增药材库存记录
	 * 
	 * @param medStorage
	 * @return
	 */
	public Integer save(MedStorage medStorage);

	/**
	 * 分页查询检验管理 总记录
	 * 
	 * @param medStorage
	 * @return
	 */
	Integer findByCheckCount(MedStorage medStorage);

	/**
	 * 分页查询检验管理 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByCheckList(MedStorage medStorage);

	/**
	 * 分页查询生产平台的药材检验 总记录
	 * 
	 * @param medStorage
	 * @return
	 */
	Integer findByProductionMedCheckCount(MedStorage medStorage);

	/**
	 * 分页查询生产平台的药材检验 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByProductionMedCheckList(MedStorage medStorage);

	/**
	 * 分页查询已检药材 总记录
	 * 
	 * @param medStorage
	 * @return
	 */
	Integer findByCheckedCount(MedStorage medStorage);

	/**
	 * 分页查询已检药材 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByCheckedList(MedStorage medStorage);

	/**
	 * 分页查询生产平台的已检药材 总记录
	 * 
	 * @param medStorage
	 * @return
	 */
	Integer findByProductionMedCheckedCount(MedStorage medStorage);

	/**
	 * 分页查询生产平台的已检药材 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByProductionMedCheckedList(MedStorage medStorage);

	/**
	 * 更新药材检验状态
	 * 
	 * @param check
	 * @return
	 */
	Integer updateByCheck(Check check);

	/**
	 * 查询一条药材库存信息
	 * 
	 * @return
	 */
	public MedStorage findMedStorage(MedStorage medStorage);

	/**
	 * 根据扫描箱码查询
	 * 
	 * @param ID
	 * @return MedStorage
	 */
	public List<MedStorage> findByBox(Map map);

	/**
	 * 更新药材库存相关信息
	 * 
	 * @param medStorage
	 * @return
	 */
	public Integer update(MedStorage medStorage);

	// //////////////////////////以下为饮片平台,药材库存管理////////////////////////////////////////////////
	/**
	 * 库存药材列表
	 * 
	 * @param MedStorage
	 * @return
	 */
	public List<MedStorage> findTabletMedStorage(MedStorage medStorage);
	
	/**
	 * 库存药材列表,显示药材内部批次号
	 * 
	 * @param MedStorage
	 * @return
	 */
	public List<MedStorage> findTabletMedStorage2(MedStorage medStorage);


	/**
	 * 库存药材列表总记录
	 * 
	 * @param MedStorage
	 * @return
	 */
	public Integer findTabletMedStorageCount(MedStorage medStorage);
	/**
	 * 库存药材列表总记录，显示药材内部批次号
	 * 
	 * @param MedStorage
	 * @return
	 */
	public Integer findTabletMedStorageCount2(MedStorage medStorage);

	/**
	 * 库存药材根据ID查询
	 * 
	 * @param MedStorage
	 * @return
	 */
	public MedStorage findById(MedStorage medStorage);

	// //////////////////////////以下为药材经销商////////////////////////////////////////////////
	public List<MedStorage> findMainMeds(MedStorage medStorage);

	// //////////////市场////////////////
	/**
	 * 市场的药材库存统计 总数量
	 */
	Integer findByMedmarketMedStatCount(MedStorage medStorage);

	/**
	 * 市场的药材库存统计 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByMedmarketMedStatList(MedStorage medStorage);

	/**
	 * 市场的药材库存统计 总重量
	 * 
	 * @param medStorage
	 * @return
	 */
	String findByMedmarketMedStatTotalweight(MedStorage medStorage);

	// /////////药材经销统计分析///////////
	/**
	 * 药材经销库存统计 总数量
	 */
	Integer findByMedsellStatCount(MedStorage medStorage);

	/**
	 * 药材经销库存统计 列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findByMedsellStatList(MedStorage medStorage);

	/**
	 * 药材经销库存统计 总重量
	 * 
	 * @param medStorage
	 * @return
	 */
	String findByMedsellStatTotalweight(MedStorage medStorage);
    
	/**
	 * 根据medcpc来查询药材库存列表
	 * 
	 * @param medStorage
	 * @return
	 */
	List<MedStorage> findMedByMedcpc(MedStorage medStorage);
	
	/**
	 * 根据组织id,商品编码,药材批次号查询当前最新库存
	 * @param medStorage
	 * @return
	 */
	public MedStorage findCurrentMedWeight(MedStorage medStorage);
	
	
	/**
	 * 手持机调用接口
	 */
	
	/*
	 * 【库存信息】
	 * 根据企业orgid查询药材库存列表(药材名称相同的合并)、可分页显示
	 */
	public List<MedStorage> findMedListByCpccorp(int pager_offset,int pager_openset,Integer orgid);
	
	/*
	 * 【库存信息】
	 * 根据企业cpc查询药材库存条数(药材名称相同的合并)
	 */
	public Integer findMedCountByCpccorp(Integer orgid);
	
	/*
	 * 【库存信息】-
	 * 根据药材编码查询药材库存列表(批次号相同的合并)、可分页显示
	 */
	public List<MedStorage> findMedListByProdcode(int pager_offset,int pager_openset,Integer orgid,String prodcode);
	
	/*
	 * 【库存信息】
	 * 根据药材编码查询药材库存条数(批次号相同的合并)
	 */
	public Integer findMedCountByProdcode(Integer orgid,String prodcode);
	
	
	/*
	 * 【超售信息】
	 * 根据企业orgid查询药材超售列表(药材名称相同的合并)、可分页显示
	 */
	public List<MedStorage> findMedExceedListByCpccorp(int pager_offset,int pager_openset,Integer orgid,String begtime,String endtime);
	
	/*
	 * 【超售信息】
	 * 根据企业cpc查询药材超售条数(药材名称相同的合并)
	 */
	public Integer findMedExceedCountByCpccorp(Integer orgid,String begtime,String endtime);
	
	/**
	 * 查询批次合并的实际库存重量
	 * @param medStorage
	 * @return
	 */
	public Double findChangeMedWeight(MedStorage medStorage);
	
	/**
	 * 查询市场下的所有药材
	 * @param medStorage
	 * @return
	 */
	public List<MedStorage> findMarketMainMeds(MedStorage medStorage); 
}

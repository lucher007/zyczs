package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;

/**
 * @Title IOrgDao.java
 * @Package
 * @version 1.0 组织表接口
 */
public interface IOrgDao {
	/**
	 * 组织添加
	 * 
	 * @param org
	 * @return
	 */
	public Integer save(Org org);

	/**
	 * 组织更新
	 * 
	 * @param org
	 * @return
	 */
	public Integer updateById(Org org);

	/**
	 * 组织分页总数
	 * 
	 * @param org
	 * @return
	 */
	public Integer findByCount(Org org);

	/**
	 * 组织列表查询
	 * 
	 * @param org
	 * @return
	 */
	public List<Org> findByList(Org org);
	
	
	/**
	 * 根据企业审核状态来查询组织总数
	 * 
	 * @param org
	 * @return
	 */
	public Integer findByCount_companystate(Org org);
	
	/**
	 * 根据企业审核状态来查询组织
	 * 
	 * @param org
	 * @return
	 */
	public List<Org> findByList_companystate(Org org);

	/**
	 * 组织查询根据ID
	 * 
	 * @param org
	 * @return
	 */
	public Org findById(Org org);

	// /////////市场统计分析///////////////
	/**
	 * 经营户统计 总数量
	 */
	Integer findByMedmarketUserStatCount(Org org);

	/**
	 * 经营户统计 列表
	 * 
	 * @param map
	 * @return
	 */
	List<Org> findByMedmarketUserStatList(Org org);

	// //////市场刷卡商户信息/////////
	/**
	 * 获取商户刷卡信息
	 */
	List<Org> findByCpccorp(Org org);
	/**
	 * 更新
	 * @param map
	 * @return
	 */
	Integer updateByMap(Map<String, Object> map);
	
	/**
	 * 根据companyId查询org
	 * @param companyId
	 * @return
	 */
	public List<Org> findByCompanyId(Integer companyId);
	
	/**
	 * 在前台注册的组织cpccorp暂未企业id
	 * 根据企业id删除企业
	 * @param companyId
	 * @return
	 */
	public Integer deleteByCompanyId(Integer companyId);
	
	/**
	 * 查询非市场的称的信息
	 * @return
	 */
	public List<Org> findOrgCheng();
	/**
	 * 更新组织经纬度
	 * @param org
	 * @return
	 */
	public Integer updateLogLat(Org org);
	
	/**
	 * 查询市场的称的信息
	 * @return
	 */
	public List<Org> findMarket();
	/**
	 * 根据组织名称查询组织是否存在
	 * @param orgname
	 * @return
	 */
	public List<Org> findByExist(String orgname);
	/**
	 * 根据组织CPC查组织
	 * @param orgname
	 * @return
	 */
	public Org findByCpccorpObject(String cpccorp);
	/**
	 * 根据Cpc查询，是否是该市场下的经销商
	 * @param orgname
	 * @return
	 */
	public Org findByMarketcode(Org org);
	
	/**
	 * 根据组织名称拼接字符串查询组织是否存在
	 * @param orgname
	 * @return
	 */
	public List<Org> findExistByOrgnames(String orgnames);
	
	/**
	 * 根据企业cpc修改org关联信息
	 * @param supercpccode
	 * @return
	 */
	public Integer updateBySuperCpC(Org org);
	
	/**
	 * 根据商户cpc查询该商户是否已经发过卡
	 * @param cpccorp
	 * @return
	 */
	public Integer findCardByCpc_JiLin(String cpccorp);
	
	/**
	 * 根据orgid和uploadtype查询pic
	 * @param org
	 * @return
	 */
	public List<OrgUpload> findPic_JiLin(Org org);
}

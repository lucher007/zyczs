package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.MarketMap;
import cn.gov.zyczs.cspt.po.OrgUpload;

/**
 * 市场区域图dao接口
 * @author Administrator
 *
 */
public interface IMarketMapDao {
	/**
	 * 查询市场区域信息
	 * @param plant
	 * @return
	 */
	public List<MarketMap> findByList(MarketMap marketMap);
	
	/**
	 * 查询市场区域信息数量
	 * @param MarketMap
	 * @return
	 */
	public Integer findByCount(MarketMap marketMap);
	
	/**
	 * 新增市场平面图信息
	 * @param MarketMap
	 * @return
	 */
	public Integer save(MarketMap marketMap);
	
	/**
	 * 根据市场cpc查询该市场当前最大的区编号
	 * @param cpccorp
	 * @return
	 */
	public Integer findMaxareanum(String cpccorp);
	
	/**
	 * 更细市场平面图信息
	 * @param marketMap
	 * @return
	 */
	public Integer updateById(MarketMap marketMap);
	
	/**
	 * 查询上传附件
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findByCondtion(MarketMap marketMap);
	
	/**
	 * 根据id查询图片刘
	 * @param uploadcontent
	 * @return
	 */
	public MarketMap findByIdMarketMapImage(String mapcontent);
	/**
	 * 删除平面图信息
	 * @param marketMap
	 * @return
	 */
	public Integer updateImage(MarketMap marketMap);
	
	/**
	 * 根据cpc查询该市场有几区几楼
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findMarketAreaAndFloor(MarketMap marketMap);
	/**
	 * 根据cpc查询该市场有几区
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findMarketAreaByCpc(MarketMap marketMap);
	/**
	 * 根据cpc查询该市场有几楼
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findMarketFloorByCpc(MarketMap marketMap);
	/**
	 * 根据cpc,区域编号,楼层编号查询对应的楼层平面图
	 * @param uploadcontent
	 * @return
	 */
	public MarketMap findMarketFloorImage(MarketMap marketMap);
	/**
	 * 查询该市场该区是否已经建立
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findExist(MarketMap marketMap);
	/**
	 * 更新区楼信息
	 * @param marketMap
	 * @return
	 */
	public Integer updateAreaFloor(MarketMap marketMap);
	/**
	 * 删除楼层区域信息
	 * @param id
	 * @return
	 */
	public Integer delMarketMap(MarketMap marketMap);
	
	/**
	 * 根据市场cpccorp查询该市场所有floor
	 * @param marketMap
	 * @return
	 */
	public List<MarketMap> findFloorByCpc(MarketMap marketMap);
}

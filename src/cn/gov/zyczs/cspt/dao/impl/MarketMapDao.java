package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMarketMapDao;
import cn.gov.zyczs.cspt.po.MarketMap;
/**
 * 市场区域图dao实现类
 * @author Administrator
 *
 */
public class MarketMapDao extends SqlMapClientDaoSupport implements IMarketMapDao {

	@Override
	public Integer findByCount(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MarketMap.findByCount",marketMap);
	}

	@Override
	public List<MarketMap> findByList(MarketMap marketMap) {
		return(List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findByList", marketMap);
	}

	@Override
	public Integer save(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().insert("MarketMap.save",marketMap);
	}

	@Override
	public Integer findMaxareanum(String cpccorp) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MarketMap.findMaxareanum",cpccorp);
	}

	@Override
	public Integer updateById(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().update("MarketMap.updateById",marketMap);
	}

	@Override
	public List<MarketMap> findByCondtion(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findByCondtion",marketMap);
	}

	@Override
	public MarketMap findByIdMarketMapImage(String mapcontent) {
		return (MarketMap)getSqlMapClientTemplate().queryForObject("MarketMap.findByIdMarketMapImage",mapcontent);
	}

	@Override
	public Integer updateImage(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().update("MarketMap.updateImage",marketMap);
	}

	@Override
	public List<MarketMap> findMarketAreaAndFloor(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findMarketAreaAndFloor",marketMap);
	}

	@Override
	public List<MarketMap> findMarketAreaByCpc(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findMarketAreaByCpc",marketMap);
	}

	@Override
	public List<MarketMap> findMarketFloorByCpc(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findMarketFloorByCpc",marketMap);
	}

	@Override
	public MarketMap findMarketFloorImage(MarketMap marketMap) {
		return (MarketMap)getSqlMapClientTemplate().queryForObject("MarketMap.findMarketFloorImage",marketMap);
	}

	@Override
	public List<MarketMap> findExist(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findExist",marketMap);
	}

	@Override
	public Integer updateAreaFloor(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().update("MarketMap.updateAreaFloor",marketMap);
	}

	@Override
	public Integer delMarketMap(MarketMap marketMap) {
		return (Integer)getSqlMapClientTemplate().delete("MarketMap.delMarketMap",marketMap);
	}

	@Override
	public List<MarketMap> findFloorByCpc(MarketMap marketMap) {
		return (List<MarketMap>)getSqlMapClientTemplate().queryForList("MarketMap.findFloorByCpc",marketMap);
	}

}

package cn.gov.zyczs.cspt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.po.TabletStorage;


/**
 * @Title TabletStorageDao.java
 * @version 1.0 
 * 饮片库存dao实现类
 */
public class TabletStorageDao extends SqlMapClientDaoSupport implements ITabletStorageDao {

	@SuppressWarnings("unchecked")
	public List<TabletStorage> findByList(TabletStorage tabletStorage) {
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByList", tabletStorage);
	}

	@Override
	public Integer findByCount(TabletStorage tabletStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStorage.findByCount", tabletStorage);
	}

	@SuppressWarnings("unchecked")
	public List<TabletStorage> findByList_codeType(TabletStorage tabletStorage) {
		if(tabletStorage!=null && tabletStorage.getCodetype() == 8){
			return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByList_codeType_8", tabletStorage);
		}else{
			return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByList_codeType", tabletStorage);
		}
	}
	@Override
	public Integer findByCount_codeType(TabletStorage tabletStorage) {
		if(tabletStorage!=null && tabletStorage.getCodetype() == 8){
			return (Integer) getSqlMapClientTemplate().queryForObject("TabletStorage.findByCount_codeType_8", tabletStorage);
		}else{
			return (Integer) getSqlMapClientTemplate().queryForObject("TabletStorage.findByCount_codeType", tabletStorage);
		}
		
	}
	
	public List<TabletStorage> findBoxListByList(TabletStorage tabletStorage) {
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findBoxListByList", tabletStorage);
	}
	
	public List<TabletStorage> findBoxListByAll(String packCode,Integer orgid) {
		Map map=new HashMap();
		map.put("packcode", packCode);
		map.put("orgid", orgid);
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findBoxListByAll", map);
	}

	@Override
	public Integer findBoxListByCount(TabletStorage tabletStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStorage.findBoxListByCount", tabletStorage);
	}

	@Override
	public Integer save(TabletStorage tabletStorage) {
		if(tabletStorage.getState()==null){
			tabletStorage.setState(0);//如果该为空，默认赋值0(0-有库存；1-无库存)
		}
		return (Integer) getSqlMapClientTemplate().insert("TabletStorage.save", tabletStorage);
	}
	
	@Override
	public TabletStorage findById(TabletStorage tabletStorage) {
		return (TabletStorage)getSqlMapClientTemplate().queryForObject("TabletStorage.findById",tabletStorage);
	}

	
	@Override
	public Integer updateWeightById(Double currTotal,Integer state,Integer tabletstorid)
	{
		Map map=new HashMap();
		map.put("tabletstorid", tabletstorid);
		map.put("currTotal", currTotal);
		map.put("state", state);
		return (Integer) getSqlMapClientTemplate().update("TabletStorage.updateWeightById",map);
		
	}


	@SuppressWarnings("unchecked")
	public List<TabletStorage> findByBox(Map map) {
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByBox", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<TabletStorage> findByBox_8(Map map) {
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByBox_8", map);
	}
	
//	@SuppressWarnings("unchecked")
//	public List<TabletStorage> findByBoxPackCode(Map map) {
//		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findByBoxPackCode", map);
//	}

	@Override
	public Integer update(TabletStorage tabletStorage) {
		return (Integer) getSqlMapClientTemplate().update("TabletStorage.update", tabletStorage);
	}
	
	@SuppressWarnings("unchecked")
	public List<TabletStorage> findDownCodeByList(TabletStorage tabletStorage) {
		return (List<TabletStorage>) getSqlMapClientTemplate().queryForList("TabletStorage.findDownCodeByList", tabletStorage);
	}

	@Override
	public Integer findDownCodeByCount(TabletStorage tabletStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStorage.findDownCodeByCount", tabletStorage);
	}

}

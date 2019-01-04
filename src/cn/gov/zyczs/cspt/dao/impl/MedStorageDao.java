package cn.gov.zyczs.cspt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.MedStorage;


public class MedStorageDao extends SqlMapClientDaoSupport implements IMedStorageDao {

	@SuppressWarnings("unchecked")
	public List<MedStorage> findByList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByList", medStorage);
	}

	@Override
	public Integer findByCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByCount", medStorage);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<MedStorage> findGroupByList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findGroupByList", medStorage);
	}

	@Override
	public Integer findGroupByCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findGroupByCount", medStorage);
	}
	
	@Override
	public Integer findChengWeightCount(String batchcpc,Integer orgid) {
		Map map=new HashMap();
		map.put("batchcpc", batchcpc);
		map.put("orgid", orgid);
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findChengWeightCount", map);
	}
	
	

	@Override
	public Integer save(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().insert("MedStorage.save", medStorage);
	}

	@Override
	public Integer findByCheckCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByCheckCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByCheckList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByCheckList", medStorage);
	}

	@Override
	public Integer findByCheckedCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByCheckedCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByCheckedList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByCheckedList", medStorage);
	}

	@Override
	public Integer updateByCheck(Check check) {
		return getSqlMapClientTemplate().update("MedStorage.updateByCheck", check);
	}

	@Override
	public MedStorage findMedStorage(MedStorage medStorage) {
		return (MedStorage) getSqlMapClientTemplate().queryForObject("MedStorage.findMedStorage", medStorage);
	}

	@Override
	public Integer update(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().update("MedStorage.update", medStorage);
	}

	@SuppressWarnings("unchecked")
	public List<MedStorage> findByBox(Map map) {				
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByBox", map);	
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findTabletMedStorage(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findTabletMedStorage", medStorage);
	}

	@Override
	public Integer findTabletMedStorageCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findTabletMedStorageCount", medStorage);
	}

	@Override
	public Integer findByProductionMedCheckCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByProductionMedCheckCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByProductionMedCheckList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByProductionMedCheckList", medStorage);
	}

	@Override
	public Integer findByProductionMedCheckedCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByProductionMedCheckedCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByProductionMedCheckedList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByProductionMedCheckedList", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findMainMeds(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findMainMeds", medStorage);
	}

	@Override
	public MedStorage findById(MedStorage medStorage) {
		return (MedStorage) getSqlMapClientTemplate().queryForObject("MedStorage.findById", medStorage);
	}

	@Override
	public Integer findByMedmarketMedStatCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByMedmarketMedStatCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByMedmarketMedStatList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByMedmarketMedStatList", medStorage);
	}

	@Override
	public String findByMedmarketMedStatTotalweight(MedStorage medStorage) {
		return (String) getSqlMapClientTemplate().queryForObject("MedStorage.findByMedmarketMedStatTotalweight", medStorage);
	}

	@Override
	public Integer findByMedsellStatCount(MedStorage medStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findByMedsellStatCount", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findByMedsellStatList(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findByMedsellStatList", medStorage);
	}

	@Override
	public String findByMedsellStatTotalweight(MedStorage medStorage) {
		return (String) getSqlMapClientTemplate().queryForObject("MedStorage.findByMedsellStatTotalweight", medStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findMedByMedcpc(MedStorage medStorage) {
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findMedByMedcpc", medStorage);
	}

	@Override
	public MedStorage findCurrentMedWeight(MedStorage medStorage) {
		return (MedStorage) getSqlMapClientTemplate().queryForObject("MedStorage.findCurrentMedWeight", medStorage);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findMedListByCpccorp(int pager_offset,int pager_openset,Integer orgid) {
		Map map=new HashMap();
		map.put("pager_offset", pager_offset);
		map.put("pager_openset", pager_openset);
		map.put("orgid", orgid);
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findMedListByCpccorp", map);
	}
	
	@Override
	public Integer findMedCountByCpccorp(Integer orgid) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findMedCountByCpccorp", orgid);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<MedStorage> findMedListByProdcode(int pager_offset,int pager_openset,Integer orgid,String prodcode) {
		Map map=new HashMap();
		map.put("pager_offset", pager_offset);
		map.put("pager_openset", pager_openset);
		map.put("orgid", orgid);
		map.put("prodcode", prodcode);
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findMedListByProdcode", map);
	}
	
	@Override
	public Integer findMedCountByProdcode(Integer orgid,String prodcode) {
		Map map=new HashMap();
		map.put("prodcode", prodcode);
		map.put("orgid", orgid);
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findMedCountByProdcode", map);
	}
	
	
	@Override
	public List<MedStorage> findMedExceedListByCpccorp(int pager_offset,int pager_openset,Integer orgid,String begtime,String endtime) {
		Map map=new HashMap();
		map.put("pager_offset", pager_offset);
		map.put("pager_openset", pager_openset);
		map.put("orgid", orgid);
		map.put("begtime", begtime);
		map.put("endtime", endtime);
		return (List<MedStorage>) getSqlMapClientTemplate().queryForList("MedStorage.findMedExceedListByCpccorp", map);
	}
	
	@Override
	public Integer findMedExceedCountByCpccorp(Integer orgid,String begtime,String endtime) {
		Map map=new HashMap();
		map.put("orgid", orgid);
		map.put("begtime", begtime);
		map.put("endtime", endtime);
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStorage.findMedExceedCountByCpccorp", map);
	}

	@Override
	public Double findChangeMedWeight(MedStorage medStorage) {
		return (Double)getSqlMapClientTemplate().queryForObject("MedStorage.findChangeMedWeight",medStorage);
	}

	@Override
	public List<MedStorage> findMarketMainMeds(MedStorage medStorage) {
		return (List<MedStorage>)getSqlMapClientTemplate().queryForList("MedStorage.findMarketMainMeds",medStorage);
	}

	@Override
	public List<MedStorage> findTabletMedStorage2(MedStorage medStorage) {
		return (List<MedStorage>)getSqlMapClientTemplate().queryForList("MedStorage.findTabletMedStorage2",medStorage);
	}

	@Override
	public Integer findTabletMedStorageCount2(MedStorage medStorage) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MedStorage.findTabletMedStorageCount2",medStorage);
	}

}

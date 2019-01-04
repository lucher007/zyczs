package cn.gov.zyczs.cspt.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IChengDao;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengState;
import cn.gov.zyczs.cspt.po.Device;

/**
 * @Title ChengDao.java
 * @version 1.0 溯源秤dao实现类
 */
public class ChengDao extends SqlMapClientDaoSupport implements IChengDao {

	@Override
	public Cheng findById(Cheng cheng) {
		return (Cheng) getSqlMapClientTemplate().queryForObject("Cheng.findById", cheng);
	}

	@Override
	public Integer findByCount(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Cheng.findByCount", cheng);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Cheng> findByList(Cheng cheng) {
		return (List<Cheng>) getSqlMapClientTemplate().queryForList("Cheng.findByList", cheng);
	}
	
	@Override
	public Integer findByCount_statelog(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Cheng.findByCount_statelog", cheng);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Cheng> findByList_statelog(Cheng cheng) {
		return (List<Cheng>) getSqlMapClientTemplate().queryForList("Cheng.findByList_statelog", cheng);
	}

	@Override
	public Integer save(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().insert("Cheng.save", cheng);
	}
	@Override
	public Integer update(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().update("Cheng.update", cheng);
	}
	@Override
	public Cheng findByCode(Cheng cheng) {
		return (Cheng) getSqlMapClientTemplate().queryForObject("Cheng.findByCode", cheng);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Cheng> queryByList(Cheng cheng) {
		return (List<Cheng>) getSqlMapClientTemplate().queryForList("Cheng.queryByList", cheng);
	}
	
	@Override
	public void saveChengStatXml(Cheng cheng) {
		getSqlMapClientTemplate().queryForObject("Cheng.saveChengStatXml",cheng);
	}
	
	@Override
	public Integer delete(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().update("Cheng.delete", cheng);
	}

	@Override
	public List<ChengState> findWeekStateLog(ChengState chengState) {
		List<ChengState> ordList = (List<ChengState>)getSqlMapClientTemplate().queryForList("Cheng.findWeekStateLog",chengState);
		if(ordList != null && ordList.size() > 3){
			List<ChengState> newList = new ArrayList<ChengState>();
			for(int i = 0,j = ordList.size() ; i < j  ; i++){
				if(i != j-1){
					ChengState qian_cheng = ordList.get(i);
					ChengState hou_cheng = ordList.get(i+1);
					long minute = Tools.diffTime(qian_cheng.getAddtime(), hou_cheng.getAddtime());
					//如果时间差大于心跳时间,则新增一条空记录用于断线
					if(minute > 10){
						ChengState temp = new ChengState();
						//temp.setChengcode(qian_cheng.getChengcode());
						temp.setAddtime(qian_cheng.getAddtime());
						temp.setState("");
						newList.add(temp);
					}else{
					}
					 newList.add(qian_cheng);
				}
			}
				System.out.println("newList>>>>>>>"+newList.size());
				return newList;
		}else{
			return ordList;
		}
	}
	
	@Override
	public Integer findByCount_mobile(Cheng cheng) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Cheng.findByCount_mobile", cheng);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Cheng> findByList_mobile(Cheng cheng) {
		return (List<Cheng>) getSqlMapClientTemplate().queryForList("Cheng.findByList_mobile", cheng);
	}
	
}

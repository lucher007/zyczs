package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengFck;
import cn.gov.zyczs.cspt.po.ChengFckTmp;
/**
 * @Title IChengFckTmpDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤 模板快捷键
 */
public interface IChengFckTmpDao {
	/**
	 * 溯源秤 模板快捷键添加
	 * @param org
	 * @return
	 */
	public Integer save(ChengFckTmp chengfcktmp);
	/**
	 * 溯源秤 模板快捷键分页总数
	 * @param chengfcktmp
	 * @return
	 */
	public Integer findByCount(ChengFckTmp chengfcktmp);
	/**
	 * 溯源秤 模板快捷键列表查询
	 * @param chengfcktmp
	 * @return
	 */
	public List<ChengFckTmp> findByList(ChengFckTmp chengfcktmp);
	
	/**
	 * 溯源秤 模板快捷键查询
	 * @param chengfcktmp
	 * @return
	 */
	public ChengFckTmp findById(ChengFckTmp chengfcktmp);
	
	/**
	 * 删除 模板快捷键
	 * @param chengfcktmp
	 * @return
	 */
	public Integer delete(ChengFckTmp chengfcktmp);
	/**
	 * 溯源秤 模板快捷键列表查询
	 * @param chengfcktmp
	 * @return
	 */
	public List<ChengFckTmp> quryByList(ChengFckTmp chengfcktmp);
	/**
	 * 根据模板编号查询已配置PLU值的KEY信息
	 * @param chengfck
	 * @return
	 */
	public List<ChengFckTmp> quryListByTmpid(ChengFckTmp chengfcktmp);
}

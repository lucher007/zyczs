package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.IndexUser;

/**
 * @Title IIndexUserDao.java
 * @Package com.dao
 * @version 1.0 
 */
public interface IIndexUserDao {
	/*************************新增操作**************************************/
	/**
	 * 将xml数据写入数据库
	 * @param indexUser
	 * @return
	 */
	public int saveIndexUser(IndexUser indexUser);
	/**
	 * 将xml数据写入数据库
	 * @param indexUser
	 * @return
	 */
	public int saveIndexUser(List<IndexUser> indexUsers);
	/***********************************************************************/
	
	
	/*************************读取操作**************************************/
	/**
	 *根据品名查询该药材的价格走势
	 * @param plantName
	 * @return
	 */
	//public List<IndexUser> getPriceChartByPlantName(IndexUser indexUser);
	
	public List<IndexUser> findPriceChart(IndexUser indexUser);
	
	
}


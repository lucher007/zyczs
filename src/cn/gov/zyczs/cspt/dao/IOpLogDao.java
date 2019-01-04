package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.OpLog;

/**
 * @Title IOpLogDao.java
 * @Package 
 * @version 1.0 
 * 操作日志接口
 */
public interface IOpLogDao {
	
	/**
	 * 保存箱码
	 * @param table
	 * @return Integer
	 */
	public Integer saveOjbect(OpLog opLog);
	
	/**
	 * 查询分页数
	 * @Title: findByCount 
	 * @Description: TODO
	 *
	 */
	public Integer findByCount(OpLog opLog);
	/**
	 * 查询列表
	 * @Title: findByList 
	 * @Description: TODO
	 *
	 */
	public List<OpLog> findByList(OpLog opLog);

}

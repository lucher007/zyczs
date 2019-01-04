package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Pesticide;

/**
 * @Title IPesticideDao.java
 * @version 1.0 
 * 农药dao接口
 */
public interface IPesticideDao {
	/**
	 * 根据农药信息查询农药数量
	 * @param pesticide
	 * @return
	 */
	public Integer findByCount(Pesticide pesticide);
	/**
	 * 根据农药信息查询农药集合
	 * @param pesticide
	 * @return
	 */
	public List<Pesticide> findByList(Pesticide pesticide);
	/**
	 * 根据id查询农药具体信息
	 * @param pesticide
	 * @return
	 */
	public Pesticide findById(Pesticide pesticide);
	/**
	 * 新增农药信息
	 * @param pesticide
	 * @return
	 */
	public Integer save(Pesticide pesticide);
	
}


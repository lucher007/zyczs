package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.MedStorage;

public interface ICheckDao {

	/**
	 * 新增检验信息
	 * 
	 * @param check
	 *            检验实体类
	 * @return 返回当前信息的ID
	 */
	Integer save(Check check);
	/**
	 * 查询检验详情
	 * @param map
	 * @return
	 */
	Check findCheckDetail(Check check);
	/**
	 * 查询饮片的检验详情
	 * @param check
	 * @return
	 */
	Check findTabletCheckDetail(Check check);
	
	
	/**
	 * 分页查询 列表
	 * 
	 * @param MedStorage
	 * @return
	 */
	public List<Check> findByList(Check check);
}

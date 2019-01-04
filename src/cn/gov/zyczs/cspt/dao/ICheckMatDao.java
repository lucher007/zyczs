package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;

public interface ICheckMatDao {

	/**
	 * 新增检验报告信息
	 * 
	 * @param checkMat
	 *            检验报告实体类
	 * @return 返回当前信息的ID
	 */
	Integer save(CheckMat checkMat);
	/**
	 * 查询检验报告
	 * @param map
	 * @return
	 */
	List<CheckMat> findById(Check check);
	/**
	 * 根据检验报告ID删除该检验报告
	 * @param matid
	 * @return
	 */
	Integer deleteObejct(Integer matid);
	
	/**
	 * 根据路尽检验报告
	 * @param matid
	 * @return
	 */
	CheckMat findByIdMatImage(String matcontent);
}

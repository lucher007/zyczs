package cn.gov.zyczs.cspt.dao;

import cn.gov.zyczs.cspt.po.LabelPrint;

/**
 * 标示打印dao接口
 * @author Administrator
 *
 */
public interface ILabelPrintDao {
	/**
	 * 根据labelPrint查询该企业标示打印配置
	 * @param fertilizer
	 * @return
	 */
	public LabelPrint findByOrgId(LabelPrint labelPrint);
	/**
	 * 新增企业标示打印配置
	 * @param LabelPrint
	 * @return
	 */
	public Integer save(LabelPrint labelPrint);
	/**
	 * 更新企业标示打印信息
	 * @param labelPrint
	 * @return
	 */
	public Integer update(LabelPrint labelPrint);
}

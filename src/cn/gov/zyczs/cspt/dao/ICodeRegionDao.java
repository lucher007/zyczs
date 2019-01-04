package cn.gov.zyczs.cspt.dao;

public interface ICodeRegionDao {
	/**
	 * 查询国际地区码
	 * @param CodeRegion
	 * @return String
	 */
	public String findByName(String gbname);
}

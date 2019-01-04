package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengSql;

public interface IChengSqlDao {
	/**
	 * 保存秤的SQL语句
	 * @param table
	 * @return Integer
	 */
	public Integer saveOutSql(ChengSql chengsql);
	/**
	 * 根据条件查询秤SQL语句的总数
	 * @param table
	 * @return List
	 */
	public Integer findOutSqlByCount(ChengSql chengsql);
	/**
	 * 根据条件查询秤SQL语句的LIST
	 * @param table
	 * @return List
	 */
	public List<ChengSql> findOutSqlByList(ChengSql chengsql);
}

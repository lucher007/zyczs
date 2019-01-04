package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.CodeArea;

public interface ICodeAreaDao {

	/**
	 * 根据pcode查询
	 * 
	 * @param codeArea
	 * @return
	 */
	List<CodeArea> findCodeAreaByPcode(CodeArea codeArea);
	
	/**
	 * 根据省市区查询区域代码
	 * @param codeArea
	 * @return
	 */
	public String findByName(CodeArea codeArea);
	
	
	/**
	 * 根据区域代码查询省市简称
	 * @param codeArea
	 * @return
	 */
	public String findShortName(String code);
	
	/**
	 * 根据区域代码返回省市区组合
	 * @param code
	 * @return
	 */
	public String findNameByCode(String code);
}

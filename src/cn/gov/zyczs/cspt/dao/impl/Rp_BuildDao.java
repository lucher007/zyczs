package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IRp_BuildDao;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.Rp_Build;

public class Rp_BuildDao extends SqlMapClientDaoSupport implements IRp_BuildDao{
    
	//平台建设统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findPlatformBuildStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findPlatformBuildStat", build);
	}
    
	
	//溯源秤分发统计
	@Override
	public  Rp_Build findChengSendStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findChengSendStat", build);
	}
	
	//溯源秤开机统计
	@Override
	public  Rp_Build findChengStartStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findChengStartStat", build);
	}
	
	//导出溯源秤开机统计EXCEL
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findChengStartStat_excel(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findChengStartStat_excel", build);
	}
	
	//溯源秤使用统计
	@Override
	public  Rp_Build findChengUserStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findChengUserStat", build);
	}
	
	//导出溯源秤使用统计EXCEL
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findChengUserStat_excel(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findChengUserStat_excel", build);
	}
	
	//溯源药材统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findFormalMedStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findFormalMedStat", build);
	}
	
	//种子种苗来源所占比统计
	@Override
	public  Rp_Build findPlantSourceStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findPlantSourceStat", build);
	}
	
	//中药材流通追溯交易次数统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findTradeTimesStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findTradeTimesStat", build);
	}
	
	//中药材饮片交易次数比统计
	@Override
	public  Rp_Build findTradeTimesByMonthStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findTradeTimesByMonthStat", build);
	}
	
	//中药材流通追溯打码数量统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findCodeNumStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findCodeNumStat", build);
	}
	
	//中药材饮片打码数量比统计按月
	@Override
	public Rp_Build findCodeNumByMonthStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findCodeNumByMonthStat", build);
	}
	
	//中药材检验率统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findMedCheckedStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findMedCheckedStat", build);
	}
	
	//中药材检验率统计按月份
	@Override
	public  Rp_Build findMedCheckedByMonthStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findMedCheckedByMonthStat", build);
	}
	
	//中药材上传检验报告(合格)率统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findMedMattedStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findMedMattedStat", build);
	}
	
	//中药材上传检验报告(合格)率统计按月份
	@Override
	public  Rp_Build findMedMattedByMonthStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findMedMattedByMonthStat", build);
	}
	
	//中药饮片上传检验报告(合格)率统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findTabletMattedStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findTabletMattedStat", build);
	}
	
	//中药饮片上传检验报告(合格)率统计按月份
	@Override
	public  Rp_Build findTabletMattedByMonthStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findTabletMattedByMonthStat", build);
	}
	
	//库存量和交易量统计
	@Override
	public  Rp_Build findStorAndTradeStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findStorAndTradeStat", build);
	}
	
	
	//市场发秤用户统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findMarketUserByChengStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findMarketUserByChengStat", build);
	}
	
	//市场发秤用户统计分页查询总个数
	@Override
	public Integer findMarketUserByChengStat_count(Rp_Build build) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Rp_Build.findMarketUserByChengStat_count", build);
	}
    
	//市场发秤用户统计分页查询
	@SuppressWarnings("unchecked")
	@Override
	public List<Rp_Build> findMarketUserByChengStat_page(Rp_Build build) {
		return (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findMarketUserByChengStat_page", build);
	}
	
	//企业打印溯源码数量统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findOrgCodeNumStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findOrgCodeNumStat", build);
	}
	
	//企业打印溯源码数量统计分页查询总个数
	@Override
	public Integer findOrgCodeNumStat_count(Rp_Build build) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Rp_Build.findOrgCodeNumStat_count", build);
	}
    
	//企业打印溯源码数量统计分页查询
	@SuppressWarnings("unchecked")
	@Override
	public List<Rp_Build> findOrgCodeNumStat_page(Rp_Build build) {
		return (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findOrgCodeNumStat_page", build);
	}
	
	//企业溯源秤交易统计
	@SuppressWarnings("unchecked")
	@Override
	public  List<Rp_Build> findOrgChengTradeStat(Rp_Build build) {
		return  (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findOrgChengTradeStat", build);
	}
	
	//企业溯源秤交易统计分页查询总个数
	@Override
	public Integer findOrgChengTradeStat_count(Rp_Build build) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Rp_Build.findOrgChengTradeStat_count", build);
	}
    
	//企业溯源秤交易统计分页查询
	@SuppressWarnings("unchecked")
	@Override
	public List<Rp_Build> findOrgChengTradeStat_page(Rp_Build build) {
		return (List<Rp_Build>) getSqlMapClientTemplate().queryForList("Rp_Build.findOrgChengTradeStat_page", build);
	}
	
	//药材、饮片、溯源秤打码次数统计
	@Override
	public  Rp_Build findMedTabletChengCodeNumStat(Rp_Build build) {
		return  (Rp_Build) getSqlMapClientTemplate().queryForObject("Rp_Build.findMedTabletChengCodeNumStat", build);
	}
}

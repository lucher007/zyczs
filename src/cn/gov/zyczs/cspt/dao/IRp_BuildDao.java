package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Rp_Build;

public interface IRp_BuildDao {
	
	//平台建设统计
	public List<Rp_Build> findPlatformBuildStat(Rp_Build build);
	
	//溯源秤分发统计
	public Rp_Build findChengSendStat(Rp_Build build);
	
	//溯源秤开机统计
	public Rp_Build findChengStartStat(Rp_Build build);
	
	//导出溯源秤开机统计EXCEL
	public List<Rp_Build> findChengStartStat_excel(Rp_Build build);
	
	//溯源秤使用统计
	public Rp_Build findChengUserStat(Rp_Build build);
	
	//导出溯源秤使用统计EXCEL
	public List<Rp_Build> findChengUserStat_excel(Rp_Build build);
	
	//溯源药材统计
	public List<Rp_Build> findFormalMedStat(Rp_Build build);
	
	//种子种苗所占比统计
	public Rp_Build findPlantSourceStat(Rp_Build build);
	
	//中药材流通追溯交易次数统计
	public List<Rp_Build> findTradeTimesStat(Rp_Build build);
	
	//中药材饮片交易次数比统计(按月份)
	public Rp_Build findTradeTimesByMonthStat(Rp_Build build);
	
	//中药材流通追溯打码数量统计
	public List<Rp_Build> findCodeNumStat(Rp_Build build);
	
	//中药材饮片打码数量比统计(按月份)
	public Rp_Build findCodeNumByMonthStat(Rp_Build build);
	
	//中药材流通追溯检验率统计
	public List<Rp_Build> findMedCheckedStat(Rp_Build build);
	
	//中药材流通追溯检验率比统计(按月份)
	public Rp_Build findMedCheckedByMonthStat(Rp_Build build);
	
	//中药材上传检验报告(合格)率统计
	public List<Rp_Build> findMedMattedStat(Rp_Build build);
	
	//中药材上传检验报告(合格)率比统计(按月份)
	public Rp_Build findMedMattedByMonthStat(Rp_Build build);
	
	//中药饮片上传检验报告(合格)率统计
	public List<Rp_Build> findTabletMattedStat(Rp_Build build);
	
	//中药饮片上传检验报告(合格)率比统计(按月份)
	public Rp_Build findTabletMattedByMonthStat(Rp_Build build);
	
	//库存量和交易量统计
	public Rp_Build findStorAndTradeStat(Rp_Build build);
	
	//市场发秤用户统计
	public List<Rp_Build> findMarketUserByChengStat(Rp_Build build);
	
	
	//市场发秤用户统计分页总数
	public Integer findMarketUserByChengStat_count(Rp_Build build);

	//市场发秤用户统计分页查询
	public List<Rp_Build> findMarketUserByChengStat_page(Rp_Build build);
	
	//企业打印溯源码数量统计
	public List<Rp_Build> findOrgCodeNumStat(Rp_Build build);
	
	//企业打印溯源码数量统计分页总数
	public Integer findOrgCodeNumStat_count(Rp_Build build);

	//企业打印溯源码数量统计分页查询
	public List<Rp_Build> findOrgCodeNumStat_page(Rp_Build build);
	
	//企业溯源秤交易统计
	public List<Rp_Build> findOrgChengTradeStat(Rp_Build build);
	
	//企业溯源秤交易统计分页总数
	public Integer findOrgChengTradeStat_count(Rp_Build build);

	//企业溯源秤交易统计分页查询
	public List<Rp_Build> findOrgChengTradeStat_page(Rp_Build build);
	
	//药材、饮片、溯源秤打码次数统计
	public Rp_Build findMedTabletChengCodeNumStat(Rp_Build build);
	
} 

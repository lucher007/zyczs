package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.GovmentTabletStat;
import cn.gov.zyczs.cspt.po.TabletBase;

public interface IGovmentTabletStatDao {
	
	
	/**
	 * 分页查询 列表
	 * @param TabletBase
	 * @return 
	 */
	public List<GovmentTabletStat> findByTabletList(GovmentTabletStat govmentTabletStat);
	
	/**
	 * 分页查询 总记录
	 * @param TabletBase
	 * @return 
	 */
	public Integer findByTabletCount(GovmentTabletStat govmentTabletStat);
	
	
	public GovmentTabletStat findByOutStor(GovmentTabletStat govmentTabletStat);

}

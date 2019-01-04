package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@SuppressWarnings("serial")
public class ChengSql implements Serializable{
    private Integer serno;    //序列号
    private String sql;       //更新语句
    private Date date;        //生产时间
    
    //分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private List<ChengSql> chengsqllist;
	private ChengSql chengsql;
	
	public Integer getSerno() {
		return serno;
	}
	public void setSerno(Integer serno) {
		this.serno = serno;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pagerCount) {
		pager_count = pagerCount;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pagerOffset) {
		pager_offset = pagerOffset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pagerOpenset) {
		pager_openset = pagerOpenset;
	}
	public List<ChengSql> getChengsqllist() {
		return chengsqllist;
	}
	public void setChengsqllist(List<ChengSql> chengsqllist) {
		this.chengsqllist = chengsqllist;
	}
	public ChengSql getChengsql() {
		return chengsql;
	}
	public void setChengsql(ChengSql chengsql) {
		this.chengsql = chengsql;
	}
	
}

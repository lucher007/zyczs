package cn.gov.zyczs.cspt.po;

import java.util.List;

public class ScoreDeduct {
	private Integer id;//主键
	private Integer orgid;//关联组织机构id
	private Integer score;//扣的分数
	private String deductreason;//扣分原因
	private String deducttype;//扣分类型
	private String addtime;//扣分时间
	private String endtime;//扣分时间
	private String deductoper;//扣分操作人
	private ScoreDeduct scorededuct;
	private List<ScoreDeduct> scoredeductlist;
	
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	
	private Org org;
	private List<Org> orglist;
	private String orgname;
	private String cpccorp;//企业cpc
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getDeductreason() {
		return deductreason;
	}
	public void setDeductreason(String deductreason) {
		this.deductreason = deductreason;
	}
	
	public String getDeducttype() {
		return deducttype;
	}
	public void setDeducttype(String deducttype) {
		this.deducttype = deducttype;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getDeductoper() {
		return deductoper;
	}
	public void setDeductoper(String deductoper) {
		this.deductoper = deductoper;
	}
	public ScoreDeduct getScorededuct() {
		return scorededuct;
	}
	public void setScorededuct(ScoreDeduct scorededuct) {
		this.scorededuct = scorededuct;
	}
	public List<ScoreDeduct> getScoredeductlist() {
		return scoredeductlist;
	}
	public void setScoredeductlist(List<ScoreDeduct> scoredeductlist) {
		this.scoredeductlist = scoredeductlist;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
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
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	public List<Org> getOrglist() {
		return orglist;
	}
	public void setOrglist(List<Org> orglist) {
		this.orglist = orglist;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	
	
}

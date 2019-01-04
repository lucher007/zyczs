package cn.gov.zyczs.cspt.po;

import java.util.List;

public class ScoreFinal {
	private Integer id;//主键
	private Integer orgid;//关联组织机构id
	private String cpccorp;//企业cpc
	private String corpname;//企业名称
	private String zyctype;//药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,,其他-00000001
	private String areacode;//区域号
	private Integer score;//最终得分
	private String addtime;//统计时间
	private String endtime;//统计时间
	private Integer addscorebase;//企业基本信息
	private Integer addscoreproduct;//产品信息
	private Integer addscoremanage;//企业经营信息
	private Integer deductscore; //扣分数
	private Integer grade;//等级
	private Integer addscore;//加分总数
	private ScoreFinal scorefinal;
	private List<ScoreFinal> scorefinallist;
	
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private List<String> addtimelist;//时间列表
	private Integer dscore;//当前扣分数;
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
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getCorpname() {
		return corpname;
	}
	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public String getAddtime() {
		if(addtime == null || addtime.length() < 19){
			addtime = null;
		}else{
			addtime = addtime.substring(0,19);
		}
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getAddscorebase() {
		return addscorebase;
	}
	public void setAddscorebase(Integer addscorebase) {
		this.addscorebase = addscorebase;
	}
	public Integer getAddscoreproduct() {
		return addscoreproduct;
	}
	public void setAddscoreproduct(Integer addscoreproduct) {
		this.addscoreproduct = addscoreproduct;
	}
	public Integer getAddscoremanage() {
		return addscoremanage;
	}
	public void setAddscoremanage(Integer addscoremanage) {
		this.addscoremanage = addscoremanage;
	}
	public Integer getDeductscore() {
		return deductscore;
	}
	public void setDeductscore(Integer deductscore) {
		this.deductscore = deductscore;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public ScoreFinal getScorefinal() {
		return scorefinal;
	}
	public void setScorefinal(ScoreFinal scorefinal) {
		this.scorefinal = scorefinal;
	}
	public List<ScoreFinal> getScorefinallist() {
		return scorefinallist;
	}
	public void setScorefinallist(List<ScoreFinal> scorefinallist) {
		this.scorefinallist = scorefinallist;
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
	public List<String> getAddtimelist() {
		return addtimelist;
	}
	public void setAddtimelist(List<String> addtimelist) {
		this.addtimelist = addtimelist;
	}
	public Integer getAddscore() {
		return addscore;
	}
	public void setAddscore(Integer addscore) {
		this.addscore = addscore;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Integer getDscore() {
		return dscore;
	}
	public void setDscore(Integer dscore) {
		this.dscore = dscore;
	}
	
	
}




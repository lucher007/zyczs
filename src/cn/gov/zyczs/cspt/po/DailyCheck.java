package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
/**
 * @version
 * @author Administrator
 * 日常检查实体类
 */
public class DailyCheck implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;//序列号
	private Integer checkproject;//监管项目
	private Integer checkresult;//监管结果 
	private String checkdate;//监管时间
	private String checkperson;//监管人员
	private String checknote;//备注信息
	private String cpcmeds;//药材批次号,多个用逗号隔开
	private String deductscore;//扣分
	private Integer userid;//关联用户表id
	private String cpccorp;//经营户cpc
	private String orgname;//商户名称
	private String marketname;//市场名称
	private String opername;//执行单位
	private String supercpccorp;//商户所在市场cpc
	private String loginname;//登录人员
	
	///////////////////数据库辅助字段//////////////
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private List<DailyCheck> list;//集合
	private String startcheckdate;
	private String endcheckdate;
	private DailyCheck form;
	
	{
		checkproject = -1;
		checkresult = -1;
	}
	
	public String getStartcheckdate() {
		return startcheckdate;
	}
	public void setStartcheckdate(String startcheckdate) {
		this.startcheckdate = startcheckdate;
	}
	public String getEndcheckdate() {
		return endcheckdate;
	}
	public void setEndcheckdate(String endcheckdate) {
		this.endcheckdate = endcheckdate;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pager_count) {
		this.pager_count = pager_count;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pager_offset) {
		this.pager_offset = pager_offset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pager_openset) {
		this.pager_openset = pager_openset;
	}
	public List<DailyCheck> getList() {
		return list;
	}
	public void setList(List<DailyCheck> list) {
		this.list = list;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCheckproject() {
		return checkproject;
	}
	public void setCheckproject(Integer checkproject) {
		this.checkproject = checkproject;
	}
	public Integer getCheckresult() {
		return checkresult;
	}
	public void setCheckresult(Integer checkresult) {
		this.checkresult = checkresult;
	}
	public String getCheckdate() {
		return checkdate;
	}
	public void setCheckdate(String checkdate) {
		this.checkdate = checkdate;
	}
	public String getCheckperson() {
		return checkperson;
	}
	public void setCheckperson(String checkperson) {
		this.checkperson = checkperson;
	}
	public String getChecknote() {
		return checknote;
	}
	public void setChecknote(String checknote) {
		this.checknote = checknote;
	}
	public String getCpcmeds() {
		return cpcmeds;
	}
	public void setCpcmeds(String cpcmeds) {
		this.cpcmeds = cpcmeds;
	}
	public String getDeductscore() {
		return deductscore;
	}
	public void setDeductscore(String deductscore) {
		this.deductscore = deductscore;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getMarketname() {
		return marketname;
	}
	public void setMarketname(String marketname) {
		this.marketname = marketname;
	}
	public String getOpername() {
		return opername;
	}
	public void setOpername(String opername) {
		this.opername = opername;
	}
	public DailyCheck getForm() {
		return form;
	}
	public void setForm(DailyCheck form) {
		this.form = form;
	}
	public String getSupercpccorp() {
		return supercpccorp;
	}
	public void setSupercpccorp(String supercpccorp) {
		this.supercpccorp = supercpccorp;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
}

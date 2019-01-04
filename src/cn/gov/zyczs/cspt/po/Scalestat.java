package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * SScalestat entity. @author MyEclipse Persistence Tools
 */

public class Scalestat implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String scalecode;         //溯源秤号
	private String usercode;          //企业代码
	private Integer locked;           //是否锁定
	private Long pluver;              //plu的版本
	private Integer keyver;           //快捷键版本
	private Integer plucnt;           //快捷键数量
	private String hearttime;         //上次同步时间
	private String cellid;            //小区id，暂为空
	private String ip;                //ip地址，暂为空
	private Integer comlocked;        //命令锁定溯源秤0，不锁定，1是锁定
	private Long compluver;           //命令更新为指定版本
	private Integer comkeyver;        //命令更新快捷键
	private String cpccorp;           //企业代码去除前面三位和最后一位
	private List<Scalestat> scalestatList;
	
	private String corpname;			    //组织名称
	
	private String returninfo;	        //返回消息
	private int pager_count;	        //分页总数
	private int pager_offset;	        //分页量
	private int pager_openset;	        //分页量
	
	/**
	 * 
	 */
	public Scalestat() {
		super();
	}

	
	/**
	 * @param scalecode
	 * @param usercode
	 * @param locked
	 * @param pluver
	 * @param keyver
	 * @param plucnt
	 * @param hearttime
	 * @param cellid
	 * @param ip
	 * @param comlocked
	 * @param compluver
	 * @param comkeyver
	 * @param cpccorp
	 * @param scalestatList
	 * @param corpname
	 * @param returninfo
	 * @param pager_count
	 * @param pager_offset
	 * @param pager_openset
	 */
	public Scalestat(String scalecode, String usercode, Integer locked,
			Long pluver, Integer keyver, Integer plucnt, String hearttime,
			String cellid, String ip, Integer comlocked, Long compluver,
			Integer comkeyver, String cpccorp, List<Scalestat> scalestatList,
			String corpname, String returninfo, int pager_count,
			int pager_offset, int pager_openset) {
		super();
		this.scalecode = scalecode;
		this.usercode = usercode;
		this.locked = locked;
		this.pluver = pluver;
		this.keyver = keyver;
		this.plucnt = plucnt;
		this.hearttime = hearttime;
		this.cellid = cellid;
		this.ip = ip;
		this.comlocked = comlocked;
		this.compluver = compluver;
		this.comkeyver = comkeyver;
		this.cpccorp = cpccorp;
		this.scalestatList = scalestatList;
		this.corpname = corpname;
		this.returninfo = returninfo;
		this.pager_count = pager_count;
		this.pager_offset = pager_offset;
		this.pager_openset = pager_openset;
	}


	public String getScalecode() {
		return scalecode;
	}

	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public Integer getLocked() {
		return locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	public Long getPluver() {
		return pluver;
	}

	public void setPluver(Long pluver) {
		this.pluver = pluver;
	}

	public Integer getKeyver() {
		return keyver;
	}

	public void setKeyver(Integer keyver) {
		this.keyver = keyver;
	}

	public Integer getPlucnt() {
		return plucnt;
	}

	public void setPlucnt(Integer plucnt) {
		this.plucnt = plucnt;
	}

	public String getHearttime() {
//		if(hearttime == null || hearttime.length() < 10){
//			return null;
//		}else{
//			hearttime	= hearttime.substring(0,10);
//		}
//		return hearttime;
		return hearttime;
	}

	public void setHearttime(String hearttime) {
		this.hearttime = hearttime;
	}

	public String getCellid() {
		return cellid;
	}

	public void setCellid(String cellid) {
		this.cellid = cellid;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Integer getComlocked() {
		return comlocked;
	}

	public void setComlocked(Integer comlocked) {
		this.comlocked = comlocked;
	}

	public Long getCompluver() {
		return compluver;
	}

	public void setCompluver(Long compluver) {
		this.compluver = compluver;
	}

	public Integer getComkeyver() {
		return comkeyver;
	}

	public void setComkeyver(Integer comkeyver) {
		this.comkeyver = comkeyver;
	}

	public List<Scalestat> getScalestatList() {
		return scalestatList;
	}

	public void setScalestatList(List<Scalestat> scalestatList) {
		this.scalestatList = scalestatList;
	}

	public String getCorpname() {
		return corpname;
	}

	public void setCorpname(String corpname) {
		this.corpname = corpname;
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


	public String getCpccorp() {
		return cpccorp;
	}

	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	
}
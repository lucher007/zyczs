package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @Title MedStorage.java
 * @Package com.po
 * @version 1.0 药材库存表
 */
public class MedStorage implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer medstorid; // 药材库存ID
	private String medname; // 药材名
	private String prodcode; // 商品编码
	private String cpcmed; // 药材批次号 系统生成
	private Double medweight; // 实际产量(单位:g),库存量
	private Integer mednum; // 药材包数
	private Double mednumweight; // 药材规格,每包重量(单位:g)
	private String province; // 省
	private String city; // 市
	private String area; // 区
	private String areacode; // 地区编码,按国标处理
	private String addtime; // 系统添加时间
	private Integer state; // 药材库存状态:0有库存,1无库存
	private Integer medtype; // 药材是否分包:0药材未分包,1药材已分包
	private Integer printstate; // 打印状态:0未打印,1已打印
	private Integer orgid; // 组织编码
	private Integer checkstate; // 检验状态:0未检,1已检
	private Integer downstate;// 下载状态：0未下载,1已下载
	private Integer userid; // 用户ID
	
	private String batchcpc;
	private Double orimedweight;//原始药材库存量,此值不变
	private Double change;//medtype值为0代表修改库存,为1代表修改规格
	private Double oldchange;//上一次修改后medtype值为0代表修改库存,为1代表修改规格
	/** ***************数据库辅助字段******************* */
	private String returninfo; // 返回消息
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量

	private Integer checkid;// 检验表ID

	private String harvesttime; // 收获时间
	private String plantaddtime;// 种植开始时间
	private String checktime; // 检验时间
	private String mcontent;
	private String boxcodes; // 页面上扫描上的一连串溯源码
	private String boxcode; // 箱码
	private String boxweight;// 每箱重量
	private String boxnum;// 箱数
	private String mednumber;// 企业内部批次号
	private String fertilizer;// 肥料状况
	private String source;// 药材类型
	private String pesticide;// 农药状况
	private String intime;// 入库时间
	Map<String, List<MedStorage>> outstoragemap; // 出库MAP

	private String endtime;

	private MedStorage vo;
	private List<MedStorage> list;
	private List<Org> orglist; // 组织列表
	private String orgname;// 商户名称
	private Double leftmedweight;// 剩下的药材库存
	private String packstr;// 分包字符串拼接信息
	private String usetotal;// 分包已经使用的重量
	private String codestr; // 成功箱码
	private String uncodestr;// 失败箱码
	private String flag;// 1打印赋码 2出库
	private Integer type;// 0-药材, 1-饮片
	private String medaddtime;// 市场药材库存统计, 查询使用的入库开始时间
	private String medendtime;// 市场药材库存统计, 查询使用的入库结束时间

	private String totalweight;// 统计后的总重量

	private Integer medstate; // 药材状态. 0-溯源, 1-非溯源
	
	private String cpccorp;   //组织单位CPC
	private Integer returncode;
	public Integer getReturncode() {
		return returncode;
	}

	public void setReturncode(Integer returncode) {
		this.returncode = returncode;
	}

	public List<Org> getOrglist() {
		return orglist;
	}

	public void setOrglist(List<Org> orglist) {
		this.orglist = orglist;
	}

	public String getUsetotal() {
		return usetotal;
	}

	public void setUsetotal(String usetotal) {
		this.usetotal = usetotal;
	}

	public String getPackstr() {
		return packstr;
	}

	public void setPackstr(String packstr) {
		this.packstr = packstr;
	}

	public Double getLeftmedweight() {
		return leftmedweight;
	}

	public void setLeftmedweight(Double leftmedweight) {
		this.leftmedweight = leftmedweight;
	}

	public String getMedname() {
		return medname;
	}

	public void setMedname(String medname) {
		this.medname = medname;
	}

	public String getProdcode() {
		return prodcode;
	}

	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}

	public String getCpcmed() {
		return cpcmed;
	}

	public void setCpcmed(String cpcmed) {
		this.cpcmed = cpcmed;
	}

	public Double getMedweight() {
		return medweight;
	}

	public void setMedweight(Double medweight) {
		this.medweight = medweight;
	}

	public Integer getMednum() {
		return mednum;
	}

	public void setMednum(Integer mednum) {
		this.mednum = mednum;
	}

	public Double getMednumweight() {
		return mednumweight;
	}

	public void setMednumweight(Double mednumweight) {
		this.mednumweight = mednumweight;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAreacode() {
		return areacode;
	}

	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	public String getAddtime() {
		if (addtime == null || addtime.length() < 19) {
			addtime = null;
		} else {
			addtime = addtime.substring(0, 19);
		}
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public Integer getMedstorid() {
		return medstorid;
	}

	public void setMedstorid(Integer medstorid) {
		this.medstorid = medstorid;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getMedtype() {
		return medtype;
	}

	public void setMedtype(Integer medtype) {
		this.medtype = medtype;
	}

	public Integer getPrintstate() {
		return printstate;
	}

	public void setPrintstate(Integer printstate) {
		this.printstate = printstate;
	}

	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}

	public Integer getCheckstate() {
		return checkstate;
	}

	public void setCheckstate(Integer checkstate) {
		this.checkstate = checkstate;
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

	public MedStorage getVo() {
		return vo;
	}

	public void setVo(MedStorage vo) {
		this.vo = vo;
	}

	public List<MedStorage> getList() {
		return list;
	}

	public void setList(List<MedStorage> list) {
		this.list = list;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getHarvesttime() {
		if (harvesttime == null || harvesttime.length() < 10) {
			return null;
		} else {
			harvesttime = harvesttime.substring(0, 10);
		}
		return harvesttime;
	}

	public void setHarvesttime(String harvesttime) {
		this.harvesttime = harvesttime;
	}

	public String getPlantaddtime() {
		if (plantaddtime == null || plantaddtime.length() < 10) {
			return null;
		} else {
			plantaddtime = plantaddtime.substring(0, 10);
		}
		return plantaddtime;
	}

	public void setPlantaddtime(String plantaddtime) {
		this.plantaddtime = plantaddtime;
	}

	public String getMcontent() {
		return mcontent;
	}

	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}

	public String getChecktime() {
		if (checktime == null || checktime.length() < 10) {
			return null;
		} else {
			checktime = checktime.substring(0, 10);
		}
		return checktime;
	}

	public void setChecktime(String checktime) {
		this.checktime = checktime;
	}

	public Integer getCheckid() {
		return checkid;
	}

	public void setCheckid(Integer checkid) {
		this.checkid = checkid;
	}

	public String getBoxcodes() {
		return boxcodes;
	}

	public void setBoxcodes(String boxcodes) {
		this.boxcodes = boxcodes;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getBoxweight() {
		return boxweight;
	}

	public void setBoxweight(String boxweight) {
		this.boxweight = boxweight;
	}

	public String getBoxcode() {
		return boxcode;
	}

	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}

	public String getBoxnum() {
		return boxnum;
	}

	public void setBoxnum(String boxnum) {
		this.boxnum = boxnum;
	}

	public Map<String, List<MedStorage>> getOutstoragemap() {
		return outstoragemap;
	}

	public void setOutstoragemap(Map<String, List<MedStorage>> outstoragemap) {
		this.outstoragemap = outstoragemap;
	}

	public Integer getDownstate() {
		return downstate;
	}

	public void setDownstate(Integer downstate) {
		this.downstate = downstate;
	}

	public String getMednumber() {
		return mednumber;
	}

	public void setMednumber(String mednumber) {
		this.mednumber = mednumber;
	}

	public String getFertilizer() {
		return fertilizer;
	}

	public void setFertilizer(String fertilizer) {
		this.fertilizer = fertilizer;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getPesticide() {
		return pesticide;
	}

	public void setPesticide(String pesticide) {
		this.pesticide = pesticide;
	}

	public String getIntime() {
		return intime;
	}

	public void setIntime(String intime) {
		this.intime = intime;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getCodestr() {
		return codestr;
	}

	public void setCodestr(String codestr) {
		this.codestr = codestr;
	}

	public String getUncodestr() {
		return uncodestr;
	}

	public void setUncodestr(String uncodestr) {
		this.uncodestr = uncodestr;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getMedaddtime() {
		return medaddtime;
	}

	public void setMedaddtime(String medaddtime) {
		this.medaddtime = medaddtime;
	}

	public String getMedendtime() {
		return medendtime;
	}

	public void setMedendtime(String medendtime) {
		this.medendtime = medendtime;
	}

	public String getTotalweight() {
		return totalweight;
	}

	public void setTotalweight(String totalweight) {
		this.totalweight = totalweight;
	}

	public Integer getMedstate() {
		return medstate;
	}

	public void setMedstate(Integer medstate) {
		this.medstate = medstate;
	}

	public String getCpccorp() {
		return cpccorp;
	}

	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}

	public String getBatchcpc() {
		return batchcpc;
	}

	public void setBatchcpc(String batchcpc) {
		this.batchcpc = batchcpc;
	}

	public Double getOrimedweight() {
		return orimedweight;
	}

	public void setOrimedweight(Double orimedweight) {
		this.orimedweight = orimedweight;
	}

	public Double getOldchange() {
		return oldchange;
	}

	public void setOldchange(Double oldchange) {
		this.oldchange = oldchange;
	}

	public Double getChange() {
		return change;
	}

	public void setChange(Double change) {
		this.change = change;
	}

}

package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Tablet.java
 * @Package com.po
 * @version 1.0
 * 饮片生产表  
 */
public class Tablet implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Integer tabletid;
	private String tabletname;//饮片名
	private String tabletnumber;//饮片企业内部批次号
	private String tabletspec;//饮片规格
	private String execstandard;//执行标准
	private String medname;//原药材品名
	private String cpcmed;//原药材批次号
	private Double medweight;//原药材总重量
	private Double meduseweight;//使用重量
	private String medaddress;//原药材产地
	private String pick;
	private String winnowing;
	private String filtrate;
	private String impurity;
	private String nub;
	private String stem;
	private String twigs;
	private String cot;
	private String hair;
	private String heart;
	private String pit;
	private String flesh;
	private String cephalopodium;
	private String username1;
	private String argosols;
	private String elutriation;
	private String soakage;
	private String marinate;
	private String steam;
	private String username2;
	private String flake;
	private String slab;
	private String slice;
	private String slice1;
	private String segment;
	private String segment1;
	private String drawing;
	private String quadrel;
	private String quadrel1;
	private String quadrel2;
	private String silk;
	private String silk1;
	private String pulverize;
	private String pulverize1;
	private String wool;
	private String username3;
	private String hypothermia;
	private String mesotherm;
	private String thermotherapy;
	private String username4;
	private String downaperture;
	private String downaperture1;
	private String upaperture;
	private String upaperture1;
	private String username5;
	private String fryyellowish;
	private String frybaketobrown;
	private String frycharring;
	private String frybran;
	private String fryrice;
	private String frysoil;
	private String roasthoney;
	private String roastwine;
	private String roastvinegar;
	private String roastbrine;
	private String roastgingerjuice;
	private String roastliquorice;
	private String roastsoybean;
	private String roastsaponin;
	private String roastbile;
	private String roastsuet;
	private String steamwine;
	private String steamvinegar;
	private String steambrine;
	private String steamliquorice;
	private String steamsoybean;
	private String steamgingerjuice;
	private String steamsimple;
	private String cookmarslin;
	private String cookgingerjuice;
	private String cookradish;
	private String cookliquorice;
	private String cooksoybean;
	private String hotgrit;
	private String hotvinegar;
	private String hotclamshell;
	private String hotpowder;
	private String calciningopenly;
	private String calciningobturation;
	private String calciningquench;
	private String simmernoodle;
	private String simmerpapyrus;
	private String simmerwheat;
	private String processdrug;
	private String processalum;
	private String processliquorice;
	private String fbjj;
	private String water;
	private String ferment;
	private String mix;
	private String frostlike;
	private String deoil;
	private String username6;
	private String specialpill;
	private String isfit;
	private String username7;
	private String operator;//工艺员
	private String manager;//生产部经理
	private String qa;     //QA
	private String createtime; //生产日期
	private String remark; //备注
	private String processflow;
	private Integer state; //
	private String cpctabletimg;//二维码图片路径
	private Double tabletweight; //饮片实际产量,待包装重量(单位：g)
	private Integer medid;       //原药材id,关联zs_medstorage
	private String usermethod1;
	private String usermethod2;
	private String usermethod3;
	private String usermethod4;
	private String usermethod5;
	private String usermethod6;
	private String usermethod7;
	private String cpctablet;	//生产系统批次号
	private String prodcode;
	private String areacode;
	private String province;
	private String city;
	private String area;
	private Integer userid;
	private Integer orgid;
	private Integer checkstate;   //检验状态:0未检,1已检
	private String prodcontent;
	
	
	List<TabletPackLog> packLogList;
	
	//检验信息
	
	
	
	//分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private String mcontent;      //页面查询内容
	private String endtime;//结束日期
	private List<Tablet> tabletlist;
	private List<TabletAssist> assList;//辅料信息列表
	private String returninfo;	//返回消息
	private int returncode;		//登录返回状态
	//辅料信息列表
	private String assistStr;
	
	private Tablet vo;
	private Med med;
	private List<Tablet> list;
	
	public Tablet getVo() {
		return vo;
	}
	public void setVo(Tablet vo) {
		this.vo = vo;
	}
	public Med getMed() {
		return med;
	}
	public void setMed(Med med) {
		this.med = med;
	}
	public List<Tablet> getList() {
		return list;
	}
	public void setList(List<Tablet> list) {
		this.list = list;
	}
	public Integer getTabletid() {
		return tabletid;
	}
	public void setTabletid(Integer tabletid) {
		this.tabletid = tabletid;
	}
	public String getTabletname() {
		return tabletname;
	}
	public void setTabletname(String tabletname) {
		this.tabletname = tabletname;
	}
	public String getTabletnumber() {
		return tabletnumber;
	}
	public void setTabletnumber(String tabletnumber) {
		this.tabletnumber = tabletnumber;
	}
	public String getTabletspec() {
		return tabletspec;
	}
	public void setTabletspec(String tabletspec) {
		this.tabletspec = tabletspec;
	}
	public String getExecstandard() {
		return execstandard;
	}
	public void setExecstandard(String execstandard) {
		this.execstandard = execstandard;
	}
	public String getMedname() {
		return medname;
	}
	public void setMedname(String medname) {
		this.medname = medname;
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
	public String getMedaddress() {
		return medaddress;
	}
	public void setMedaddress(String medaddress) {
		this.medaddress = medaddress;
	}
	public String getPick() {
		return pick;
	}
	public void setPick(String pick) {
		this.pick = pick;
	}
	public String getWinnowing() {
		return winnowing;
	}
	public void setWinnowing(String winnowing) {
		this.winnowing = winnowing;
	}
	public String getFiltrate() {
		return filtrate;
	}
	public void setFiltrate(String filtrate) {
		this.filtrate = filtrate;
	}
	public String getImpurity() {
		return impurity;
	}
	public void setImpurity(String impurity) {
		this.impurity = impurity;
	}
	public String getNub() {
		return nub;
	}
	public void setNub(String nub) {
		this.nub = nub;
	}
	public String getStem() {
		return stem;
	}
	public void setStem(String stem) {
		this.stem = stem;
	}
	public String getTwigs() {
		return twigs;
	}
	public void setTwigs(String twigs) {
		this.twigs = twigs;
	}
	public String getCot() {
		return cot;
	}
	public void setCot(String cot) {
		this.cot = cot;
	}
	public String getHair() {
		return hair;
	}
	public void setHair(String hair) {
		this.hair = hair;
	}
	public String getHeart() {
		return heart;
	}
	public void setHeart(String heart) {
		this.heart = heart;
	}
	public String getPit() {
		return pit;
	}
	public void setPit(String pit) {
		this.pit = pit;
	}
	public String getFlesh() {
		return flesh;
	}
	public void setFlesh(String flesh) {
		this.flesh = flesh;
	}
	public String getCephalopodium() {
		return cephalopodium;
	}
	public void setCephalopodium(String cephalopodium) {
		this.cephalopodium = cephalopodium;
	}
	public String getUsername1() {
		return username1;
	}
	public void setUsername1(String username1) {
		this.username1 = username1;
	}
	public String getArgosols() {
		return argosols;
	}
	public void setArgosols(String argosols) {
		this.argosols = argosols;
	}
	public String getElutriation() {
		return elutriation;
	}
	public void setElutriation(String elutriation) {
		this.elutriation = elutriation;
	}
	public String getSoakage() {
		return soakage;
	}
	public void setSoakage(String soakage) {
		this.soakage = soakage;
	}
	public String getMarinate() {
		return marinate;
	}
	public void setMarinate(String marinate) {
		this.marinate = marinate;
	}
	public String getSteam() {
		return steam;
	}
	public void setSteam(String steam) {
		this.steam = steam;
	}
	public String getUsername2() {
		return username2;
	}
	public void setUsername2(String username2) {
		this.username2 = username2;
	}
	public String getFlake() {
		return flake;
	}
	public void setFlake(String flake) {
		this.flake = flake;
	}
	public String getSlab() {
		return slab;
	}
	public void setSlab(String slab) {
		this.slab = slab;
	}
	public String getSlice() {
		return slice;
	}
	public void setSlice(String slice) {
		this.slice = slice;
	}
	public String getSlice1() {
		return slice1;
	}
	public void setSlice1(String slice1) {
		this.slice1 = slice1;
	}
	public String getSegment() {
		return segment;
	}
	public void setSegment(String segment) {
		this.segment = segment;
	}
	public String getSegment1() {
		return segment1;
	}
	public void setSegment1(String segment1) {
		this.segment1 = segment1;
	}
	public String getDrawing() {
		return drawing;
	}
	public void setDrawing(String drawing) {
		this.drawing = drawing;
	}
	public String getQuadrel() {
		return quadrel;
	}
	public void setQuadrel(String quadrel) {
		this.quadrel = quadrel;
	}
	public String getQuadrel1() {
		return quadrel1;
	}
	public void setQuadrel1(String quadrel1) {
		this.quadrel1 = quadrel1;
	}
	public String getQuadrel2() {
		return quadrel2;
	}
	public void setQuadrel2(String quadrel2) {
		this.quadrel2 = quadrel2;
	}
	public String getSilk() {
		return silk;
	}
	public void setSilk(String silk) {
		this.silk = silk;
	}
	public String getSilk1() {
		return silk1;
	}
	public void setSilk1(String silk1) {
		this.silk1 = silk1;
	}
	public String getPulverize() {
		return pulverize;
	}
	public void setPulverize(String pulverize) {
		this.pulverize = pulverize;
	}
	public String getPulverize1() {
		return pulverize1;
	}
	public void setPulverize1(String pulverize1) {
		this.pulverize1 = pulverize1;
	}
	public String getWool() {
		return wool;
	}
	public void setWool(String wool) {
		this.wool = wool;
	}
	public String getUsername3() {
		return username3;
	}
	public void setUsername3(String username3) {
		this.username3 = username3;
	}
	public String getHypothermia() {
		return hypothermia;
	}
	public void setHypothermia(String hypothermia) {
		this.hypothermia = hypothermia;
	}
	public String getMesotherm() {
		return mesotherm;
	}
	public void setMesotherm(String mesotherm) {
		this.mesotherm = mesotherm;
	}
	public String getThermotherapy() {
		return thermotherapy;
	}
	public void setThermotherapy(String thermotherapy) {
		this.thermotherapy = thermotherapy;
	}
	public String getUsername4() {
		return username4;
	}
	public void setUsername4(String username4) {
		this.username4 = username4;
	}
	public String getDownaperture() {
		return downaperture;
	}
	public void setDownaperture(String downaperture) {
		this.downaperture = downaperture;
	}
	public String getDownaperture1() {
		return downaperture1;
	}
	public void setDownaperture1(String downaperture1) {
		this.downaperture1 = downaperture1;
	}
	public String getUpaperture() {
		return upaperture;
	}
	public void setUpaperture(String upaperture) {
		this.upaperture = upaperture;
	}
	public String getUpaperture1() {
		return upaperture1;
	}
	public void setUpaperture1(String upaperture1) {
		this.upaperture1 = upaperture1;
	}
	public String getUsername5() {
		return username5;
	}
	public void setUsername5(String username5) {
		this.username5 = username5;
	}
	public String getFryyellowish() {
		return fryyellowish;
	}
	public void setFryyellowish(String fryyellowish) {
		this.fryyellowish = fryyellowish;
	}
	public String getFrybaketobrown() {
		return frybaketobrown;
	}
	public void setFrybaketobrown(String frybaketobrown) {
		this.frybaketobrown = frybaketobrown;
	}
	public String getFrycharring() {
		return frycharring;
	}
	public void setFrycharring(String frycharring) {
		this.frycharring = frycharring;
	}
	public String getFrybran() {
		return frybran;
	}
	public void setFrybran(String frybran) {
		this.frybran = frybran;
	}
	public String getFryrice() {
		return fryrice;
	}
	public void setFryrice(String fryrice) {
		this.fryrice = fryrice;
	}
	public String getFrysoil() {
		return frysoil;
	}
	public void setFrysoil(String frysoil) {
		this.frysoil = frysoil;
	}
	public String getRoasthoney() {
		return roasthoney;
	}
	public void setRoasthoney(String roasthoney) {
		this.roasthoney = roasthoney;
	}
	public String getRoastwine() {
		return roastwine;
	}
	public void setRoastwine(String roastwine) {
		this.roastwine = roastwine;
	}
	public String getRoastvinegar() {
		return roastvinegar;
	}
	public void setRoastvinegar(String roastvinegar) {
		this.roastvinegar = roastvinegar;
	}
	public String getRoastbrine() {
		return roastbrine;
	}
	public void setRoastbrine(String roastbrine) {
		this.roastbrine = roastbrine;
	}
	public String getRoastgingerjuice() {
		return roastgingerjuice;
	}
	public void setRoastgingerjuice(String roastgingerjuice) {
		this.roastgingerjuice = roastgingerjuice;
	}
	public String getRoastliquorice() {
		return roastliquorice;
	}
	public void setRoastliquorice(String roastliquorice) {
		this.roastliquorice = roastliquorice;
	}
	public String getRoastsoybean() {
		return roastsoybean;
	}
	public void setRoastsoybean(String roastsoybean) {
		this.roastsoybean = roastsoybean;
	}
	public String getRoastsaponin() {
		return roastsaponin;
	}
	public void setRoastsaponin(String roastsaponin) {
		this.roastsaponin = roastsaponin;
	}
	public String getRoastbile() {
		return roastbile;
	}
	public void setRoastbile(String roastbile) {
		this.roastbile = roastbile;
	}
	public String getRoastsuet() {
		return roastsuet;
	}
	public void setRoastsuet(String roastsuet) {
		this.roastsuet = roastsuet;
	}
	public String getSteamwine() {
		return steamwine;
	}
	public void setSteamwine(String steamwine) {
		this.steamwine = steamwine;
	}
	public String getSteamvinegar() {
		return steamvinegar;
	}
	public void setSteamvinegar(String steamvinegar) {
		this.steamvinegar = steamvinegar;
	}
	public String getSteambrine() {
		return steambrine;
	}
	public void setSteambrine(String steambrine) {
		this.steambrine = steambrine;
	}
	public String getSteamliquorice() {
		return steamliquorice;
	}
	public void setSteamliquorice(String steamliquorice) {
		this.steamliquorice = steamliquorice;
	}
	public String getSteamsoybean() {
		return steamsoybean;
	}
	public void setSteamsoybean(String steamsoybean) {
		this.steamsoybean = steamsoybean;
	}
	public String getSteamgingerjuice() {
		return steamgingerjuice;
	}
	public void setSteamgingerjuice(String steamgingerjuice) {
		this.steamgingerjuice = steamgingerjuice;
	}
	public String getSteamsimple() {
		return steamsimple;
	}
	public void setSteamsimple(String steamsimple) {
		this.steamsimple = steamsimple;
	}
	public String getCookmarslin() {
		return cookmarslin;
	}
	public void setCookmarslin(String cookmarslin) {
		this.cookmarslin = cookmarslin;
	}
	public String getCookgingerjuice() {
		return cookgingerjuice;
	}
	public void setCookgingerjuice(String cookgingerjuice) {
		this.cookgingerjuice = cookgingerjuice;
	}
	public String getCookradish() {
		return cookradish;
	}
	public void setCookradish(String cookradish) {
		this.cookradish = cookradish;
	}
	public String getCookliquorice() {
		return cookliquorice;
	}
	public void setCookliquorice(String cookliquorice) {
		this.cookliquorice = cookliquorice;
	}
	public String getCooksoybean() {
		return cooksoybean;
	}
	public void setCooksoybean(String cooksoybean) {
		this.cooksoybean = cooksoybean;
	}
	public String getHotgrit() {
		return hotgrit;
	}
	public void setHotgrit(String hotgrit) {
		this.hotgrit = hotgrit;
	}
	public String getHotvinegar() {
		return hotvinegar;
	}
	public void setHotvinegar(String hotvinegar) {
		this.hotvinegar = hotvinegar;
	}
	public String getHotclamshell() {
		return hotclamshell;
	}
	public void setHotclamshell(String hotclamshell) {
		this.hotclamshell = hotclamshell;
	}
	public String getHotpowder() {
		return hotpowder;
	}
	public void setHotpowder(String hotpowder) {
		this.hotpowder = hotpowder;
	}
	public String getCalciningopenly() {
		return calciningopenly;
	}
	public void setCalciningopenly(String calciningopenly) {
		this.calciningopenly = calciningopenly;
	}
	public String getCalciningobturation() {
		return calciningobturation;
	}
	public void setCalciningobturation(String calciningobturation) {
		this.calciningobturation = calciningobturation;
	}
	public String getCalciningquench() {
		return calciningquench;
	}
	public void setCalciningquench(String calciningquench) {
		this.calciningquench = calciningquench;
	}
	public String getSimmernoodle() {
		return simmernoodle;
	}
	public void setSimmernoodle(String simmernoodle) {
		this.simmernoodle = simmernoodle;
	}
	public String getSimmerpapyrus() {
		return simmerpapyrus;
	}
	public void setSimmerpapyrus(String simmerpapyrus) {
		this.simmerpapyrus = simmerpapyrus;
	}
	public String getSimmerwheat() {
		return simmerwheat;
	}
	public void setSimmerwheat(String simmerwheat) {
		this.simmerwheat = simmerwheat;
	}
	public String getProcessdrug() {
		return processdrug;
	}
	public void setProcessdrug(String processdrug) {
		this.processdrug = processdrug;
	}
	public String getProcessalum() {
		return processalum;
	}
	public void setProcessalum(String processalum) {
		this.processalum = processalum;
	}
	public String getProcessliquorice() {
		return processliquorice;
	}
	public void setProcessliquorice(String processliquorice) {
		this.processliquorice = processliquorice;
	}
	public String getFbjj() {
		return fbjj;
	}
	public void setFbjj(String fbjj) {
		this.fbjj = fbjj;
	}
	public String getWater() {
		return water;
	}
	public void setWater(String water) {
		this.water = water;
	}
	public String getFerment() {
		return ferment;
	}
	public void setFerment(String ferment) {
		this.ferment = ferment;
	}
	public String getMix() {
		return mix;
	}
	public void setMix(String mix) {
		this.mix = mix;
	}
	public String getFrostlike() {
		return frostlike;
	}
	public void setFrostlike(String frostlike) {
		this.frostlike = frostlike;
	}
	public String getDeoil() {
		return deoil;
	}
	public void setDeoil(String deoil) {
		this.deoil = deoil;
	}
	public String getUsername6() {
		return username6;
	}
	public void setUsername6(String username6) {
		this.username6 = username6;
	}
	public String getSpecialpill() {
		return specialpill;
	}
	public void setSpecialpill(String specialpill) {
		this.specialpill = specialpill;
	}
	public String getIsfit() {
		return isfit;
	}
	public void setIsfit(String isfit) {
		this.isfit = isfit;
	}
	public String getUsername7() {
		return username7;
	}
	public void setUsername7(String username7) {
		this.username7 = username7;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getQa() {
		return qa;
	}
	public void setQa(String qa) {
		this.qa = qa;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getProcessflow() {
		return processflow;
	}
	public void setProcessflow(String processflow) {
		this.processflow = processflow;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getCpctabletimg() {
		return cpctabletimg;
	}
	public void setCpctabletimg(String cpctabletimg) {
		this.cpctabletimg = cpctabletimg;
	}
	public Double getTabletweight() {
		return tabletweight;
	}
	public void setTabletweight(Double tabletweight) {
		this.tabletweight = tabletweight;
	}
	public Integer getMedid() {
		return medid;
	}
	public void setMedid(Integer medid) {
		this.medid = medid;
	}
	public String getUsermethod1() {
		return usermethod1;
	}
	public void setUsermethod1(String usermethod1) {
		this.usermethod1 = usermethod1;
	}
	public String getUsermethod2() {
		return usermethod2;
	}
	public void setUsermethod2(String usermethod2) {
		this.usermethod2 = usermethod2;
	}
	public String getUsermethod3() {
		return usermethod3;
	}
	public void setUsermethod3(String usermethod3) {
		this.usermethod3 = usermethod3;
	}
	public String getUsermethod4() {
		return usermethod4;
	}
	public void setUsermethod4(String usermethod4) {
		this.usermethod4 = usermethod4;
	}
	public String getUsermethod5() {
		return usermethod5;
	}
	public void setUsermethod5(String usermethod5) {
		this.usermethod5 = usermethod5;
	}
	public String getUsermethod6() {
		return usermethod6;
	}
	public void setUsermethod6(String usermethod6) {
		this.usermethod6 = usermethod6;
	}
	public String getUsermethod7() {
		return usermethod7;
	}
	public void setUsermethod7(String usermethod7) {
		this.usermethod7 = usermethod7;
	}
	public String getCpctablet() {
		return cpctablet;
	}
	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getCreatetime() {
		if(createtime==null||createtime.length()<10)
		{
			createtime=null;
		}else
		{
			createtime=createtime.substring(0, 19);
		}
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public Integer getCheckstate() {
		return checkstate;
	}
	public void setCheckstate(Integer checkstate) {
		this.checkstate = checkstate;
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
	public List<Tablet> getTabletlist() {
		return tabletlist;
	}
	public void setTabletlist(List<Tablet> tabletlist) {
		this.tabletlist = tabletlist;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public String getAssistStr() {
		return assistStr;
	}
	public void setAssistStr(String assistStr) {
		this.assistStr = assistStr;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public Double getMeduseweight() {
		return meduseweight;
	}
	public void setMeduseweight(Double meduseweight) {
		this.meduseweight = meduseweight;
	}
	public List<TabletAssist> getAssList() {
		return assList;
	}
	public void setAssList(List<TabletAssist> assList) {
		this.assList = assList;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getProdcontent() {
		return prodcontent;
	}
	public void setProdcontent(String prodcontent) {
		this.prodcontent = prodcontent;
	}
	public List<TabletPackLog> getPackLogList() {
		return packLogList;
	}
	public void setPackLogList(List<TabletPackLog> packLogList) {
		this.packLogList = packLogList;
	}
	

}

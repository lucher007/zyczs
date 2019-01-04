package cn.gov.zyczs.cspt.po;

import java.util.List;
/**
 * 查询机实体类
 * @author Administrator
 *
 */
public class Search{
	private String searchtype;
	private String sourcecode;
	/************饮片*****************/
	private String piece_sourcecode;//溯源码
	private String piece_name; //饮片名称
	private String piece_productioncompanies;//生产企业
	private String piece_salescompanies;//销售企业
	private String piece_batchcode;//饮片批次号
	
	private String piece_spec; //生产规格
	private String piece_standard; //执行标准
	private String piece_processflow;//生产流程
	private String piece_operator;//工艺员
	private String piece_manager;//生产部经理
	private String piece_qa;//QA
	private String piece_producedate;//生产日期
	private String piece_remark;  //备注
	private String piece_weight;//待包装重量(单位:g)		
	private String piece_areacode;//地区编码,按国标处理
	
	
	private String piece_material_corpcode;//企业代码(14位)，流通节点编号
	private String piece_material_checkmethod;//检验方法
	private String piece_material_checkgrade;//质量级别
	private String piece_material_checkthickmethod;//粗加工方法
	private String piece_material_checkcondition;//贮藏条件
	private String piece_material_checkuser;//检验人员
	private String piece_material_checktime;//检验时间
	private String piece_report_type;//检验报告类型
	private String piece_report_url;//检验报告地址
	
	/*********************************/
	
	
	/************药材*****************/
	private String medicine_medicinecode;//药材批次号
	private String medicine_medicinename;//药材名称
	private String medicine_medicinesource;//药材来源
	private String medicine_harvesttime;//收获时间
	private String medicine_salescompanies;//销售企业
	/*********************************/
	
	
	/************植物*****************/
	private String plant_plantcode;//植物批次码
	private String plant_corpname;//种植企业
	private String plant_plantname;//植物名称
	private String plant_plantsource;//种子来源:自购|栽培|野生
	private String plant_plantarea;//种植区域(单位:亩)
	private String plant_plantcycle;//种植周期(单位：月）
	private String plant_planttime;//种植时间
	private String plant_plantuser;//负责人
	/*********************************/
	
	/***********田间管理***************/
	private String fieldmanagement_name;//名称
	private String fieldmanagement_type;//类型
	private String fieldmanagement_weight;//用量
	private String fieldmanagement_addtime;//时间
	private String fieldmanagement_remark;//备注
	/*********************************/
	
	
	/***********检验******************/
	private String medicine_material_corpname;//企业名称
	private String medicine_material_corpcode;//企业代码(14位)，流通节点编号
	private String medicine_material_checkmethod;//检验方法
	private String medicine_material_checkgrade;//质量级别
	private String medicine_material_checkthickmethod;//粗加工方法
	private String medicine_material_checkcondition;//贮藏条件
	private String medicine_material_checkuser;//检验人员
	private String medicine_material_checktime;//检验时间
	private String medicine_report_type;//检验报告类型：(检验报告|产地报告)
	private String medicine_report_url;//检验报告地址
	/*********************************/
	
	/***********查询机企业实体******************/
	private Integer id;
	private String orgname;//企业名称
	private String cpc;//企业cpc
	private Integer area;//区域标示0安国 1玉林 2成都 3亳州
	private String mac;//查询机MAC地址
	
	////////////////////数据库辅助字段/////////////////////////////
	private Search  search;
	private List<Search> list;
	private List<TabletBase> tabletbaselist;
	private String prodname;//饮片名称
	private List<InOutStor> inoutstorlist;//入库集合
	/*********************************/
	private List<Search> searchlist_materialmed;//药材检验 列表
	private List<Search> searchlist_reportmed;//药材检验报告 列表
	private List<Search> searchlist_reporttablet;//饮片检验报告 列表
	public String getSearchtype() {
		return searchtype;
	}
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	public String getPiece_sourcecode() {
		return piece_sourcecode;
	}
	public void setPiece_sourcecode(String pieceSourcecode) {
		piece_sourcecode = pieceSourcecode;
	}
	public String getPiece_name() {
		return piece_name;
	}
	public void setPiece_name(String pieceName) {
		piece_name = pieceName;
	}
	public String getPiece_productioncompanies() {
		return piece_productioncompanies;
	}
	public void setPiece_productioncompanies(String pieceProductioncompanies) {
		piece_productioncompanies = pieceProductioncompanies;
	}
	public String getPiece_salescompanies() {
		return piece_salescompanies;
	}
	public void setPiece_salescompanies(String pieceSalescompanies) {
		piece_salescompanies = pieceSalescompanies;
	}
	public String getPiece_batchcode() {
		return piece_batchcode;
	}
	public void setPiece_batchcode(String pieceBatchcode) {
		piece_batchcode = pieceBatchcode;
	}
	public String getPiece_spec() {
		return piece_spec;
	}
	public void setPiece_spec(String pieceSpec) {
		piece_spec = pieceSpec;
	}
	public String getPiece_standard() {
		return piece_standard;
	}
	public void setPiece_standard(String pieceStandard) {
		piece_standard = pieceStandard;
	}
	public String getPiece_processflow() {
		return piece_processflow;
	}
	public void setPiece_processflow(String pieceProcessflow) {
		piece_processflow = pieceProcessflow;
	}
	public String getPiece_operator() {
		return piece_operator;
	}
	public void setPiece_operator(String pieceOperator) {
		piece_operator = pieceOperator;
	}
	public String getPiece_manager() {
		return piece_manager;
	}
	public void setPiece_manager(String pieceManager) {
		piece_manager = pieceManager;
	}
	public String getPiece_qa() {
		return piece_qa;
	}
	public void setPiece_qa(String pieceQa) {
		piece_qa = pieceQa;
	}
	public String getPiece_producedate() {
		return piece_producedate;
	}
	public void setPiece_producedate(String pieceProducedate) {
		piece_producedate = pieceProducedate;
	}
	public String getPiece_remark() {
		return piece_remark;
	}
	public void setPiece_remark(String pieceRemark) {
		piece_remark = pieceRemark;
	}
	public String getPiece_weight() {
		return piece_weight;
	}
	public void setPiece_weight(String pieceWeight) {
		piece_weight = pieceWeight;
	}
	public String getPiece_areacode() {
		return piece_areacode;
	}
	public void setPiece_areacode(String pieceAreacode) {
		piece_areacode = pieceAreacode;
	}
	public String getPiece_material_corpcode() {
		return piece_material_corpcode;
	}
	public void setPiece_material_corpcode(String pieceMaterialCorpcode) {
		piece_material_corpcode = pieceMaterialCorpcode;
	}
	public String getPiece_material_checkmethod() {
		return piece_material_checkmethod;
	}
	public void setPiece_material_checkmethod(String pieceMaterialCheckmethod) {
		piece_material_checkmethod = pieceMaterialCheckmethod;
	}
	public String getPiece_material_checkgrade() {
		return piece_material_checkgrade;
	}
	public void setPiece_material_checkgrade(String pieceMaterialCheckgrade) {
		piece_material_checkgrade = pieceMaterialCheckgrade;
	}
	public String getPiece_material_checkthickmethod() {
		return piece_material_checkthickmethod;
	}
	public void setPiece_material_checkthickmethod(
			String pieceMaterialCheckthickmethod) {
		piece_material_checkthickmethod = pieceMaterialCheckthickmethod;
	}
	public String getPiece_material_checkcondition() {
		return piece_material_checkcondition;
	}
	public void setPiece_material_checkcondition(String pieceMaterialCheckcondition) {
		piece_material_checkcondition = pieceMaterialCheckcondition;
	}
	public String getPiece_material_checkuser() {
		return piece_material_checkuser;
	}
	public void setPiece_material_checkuser(String pieceMaterialCheckuser) {
		piece_material_checkuser = pieceMaterialCheckuser;
	}
	public String getPiece_material_checktime() {
		return piece_material_checktime;
	}
	public void setPiece_material_checktime(String pieceMaterialChecktime) {
		piece_material_checktime = pieceMaterialChecktime;
	}
	public String getPiece_report_type() {
		return piece_report_type;
	}
	public void setPiece_report_type(String pieceReportType) {
		piece_report_type = pieceReportType;
	}
	public String getPiece_report_url() {
		return piece_report_url;
	}
	public void setPiece_report_url(String pieceReportUrl) {
		piece_report_url = pieceReportUrl;
	}
	public String getMedicine_medicinecode() {
		return medicine_medicinecode;
	}
	public void setMedicine_medicinecode(String medicineMedicinecode) {
		medicine_medicinecode = medicineMedicinecode;
	}
	public String getMedicine_medicinename() {
		return medicine_medicinename;
	}
	public void setMedicine_medicinename(String medicineMedicinename) {
		medicine_medicinename = medicineMedicinename;
	}
	public String getMedicine_medicinesource() {
		return medicine_medicinesource;
	}
	public void setMedicine_medicinesource(String medicineMedicinesource) {
		medicine_medicinesource = medicineMedicinesource;
	}
	public String getMedicine_harvesttime() {
		return medicine_harvesttime;
	}
	public void setMedicine_harvesttime(String medicineHarvesttime) {
		medicine_harvesttime = medicineHarvesttime;
	}
	public String getPlant_plantcode() {
		return plant_plantcode;
	}
	public void setPlant_plantcode(String plantPlantcode) {
		plant_plantcode = plantPlantcode;
	}
	public String getPlant_corpname() {
		return plant_corpname;
	}
	public void setPlant_corpname(String plantCorpname) {
		plant_corpname = plantCorpname;
	}
	public String getPlant_plantname() {
		return plant_plantname;
	}
	public void setPlant_plantname(String plantPlantname) {
		plant_plantname = plantPlantname;
	}
	public String getPlant_plantsource() {
		return plant_plantsource;
	}
	public void setPlant_plantsource(String plantPlantsource) {
		plant_plantsource = plantPlantsource;
	}
	public String getPlant_plantarea() {
		return plant_plantarea;
	}
	public void setPlant_plantarea(String plantPlantarea) {
		plant_plantarea = plantPlantarea;
	}
	public String getPlant_plantcycle() {
		return plant_plantcycle;
	}
	public void setPlant_plantcycle(String plantPlantcycle) {
		plant_plantcycle = plantPlantcycle;
	}
	public String getPlant_planttime() {
		return plant_planttime;
	}
	public void setPlant_planttime(String plantPlanttime) {
		plant_planttime = plantPlanttime;
	}
	public String getPlant_plantuser() {
		return plant_plantuser;
	}
	public void setPlant_plantuser(String plantPlantuser) {
		plant_plantuser = plantPlantuser;
	}
	public String getFieldmanagement_name() {
		return fieldmanagement_name;
	}
	public void setFieldmanagement_name(String fieldmanagementName) {
		fieldmanagement_name = fieldmanagementName;
	}
	public String getFieldmanagement_type() {
		return fieldmanagement_type;
	}
	public void setFieldmanagement_type(String fieldmanagementType) {
		fieldmanagement_type = fieldmanagementType;
	}
	public String getFieldmanagement_weight() {
		return fieldmanagement_weight;
	}
	public void setFieldmanagement_weight(String fieldmanagementWeight) {
		fieldmanagement_weight = fieldmanagementWeight;
	}
	public String getFieldmanagement_addtime() {
		return fieldmanagement_addtime;
	}
	public void setFieldmanagement_addtime(String fieldmanagementAddtime) {
		fieldmanagement_addtime = fieldmanagementAddtime;
	}
	public String getFieldmanagement_remark() {
		return fieldmanagement_remark;
	}
	public void setFieldmanagement_remark(String fieldmanagementRemark) {
		fieldmanagement_remark = fieldmanagementRemark;
	}
	public String getMedicine_material_corpcode() {
		return medicine_material_corpcode;
	}
	public void setMedicine_material_corpcode(String medicineMaterialCorpcode) {
		medicine_material_corpcode = medicineMaterialCorpcode;
	}
	public String getMedicine_material_checkmethod() {
		return medicine_material_checkmethod;
	}
	public void setMedicine_material_checkmethod(String medicineMaterialCheckmethod) {
		medicine_material_checkmethod = medicineMaterialCheckmethod;
	}
	public String getMedicine_material_checkgrade() {
		return medicine_material_checkgrade;
	}
	public void setMedicine_material_checkgrade(String medicineMaterialCheckgrade) {
		medicine_material_checkgrade = medicineMaterialCheckgrade;
	}
	public String getMedicine_material_checkthickmethod() {
		return medicine_material_checkthickmethod;
	}
	public void setMedicine_material_checkthickmethod(
			String medicineMaterialCheckthickmethod) {
		medicine_material_checkthickmethod = medicineMaterialCheckthickmethod;
	}
	public String getMedicine_material_checkcondition() {
		return medicine_material_checkcondition;
	}
	public void setMedicine_material_checkcondition(
			String medicineMaterialCheckcondition) {
		medicine_material_checkcondition = medicineMaterialCheckcondition;
	}
	public String getMedicine_material_checkuser() {
		return medicine_material_checkuser;
	}
	public void setMedicine_material_checkuser(String medicineMaterialCheckuser) {
		medicine_material_checkuser = medicineMaterialCheckuser;
	}
	public String getMedicine_material_checktime() {
		return medicine_material_checktime;
	}
	public void setMedicine_material_checktime(String medicineMaterialChecktime) {
		medicine_material_checktime = medicineMaterialChecktime;
	}
	public String getMedicine_report_type() {
		return medicine_report_type;
	}
	public void setMedicine_report_type(String medicineReportType) {
		medicine_report_type = medicineReportType;
	}
	public String getMedicine_report_url() {
		return medicine_report_url;
	}
	public void setMedicine_report_url(String medicineReportUrl) {
		medicine_report_url = medicineReportUrl;
	}
	public List<Search> getSearchlist_reportmed() {
		return searchlist_reportmed;
	}
	public void setSearchlist_reportmed(List<Search> searchlistReportmed) {
		searchlist_reportmed = searchlistReportmed;
	}
	public List<Search> getSearchlist_reporttablet() {
		return searchlist_reporttablet;
	}
	public void setSearchlist_reporttablet(List<Search> searchlistReporttablet) {
		searchlist_reporttablet = searchlistReporttablet;
	}
	public String getMedicine_salescompanies() {
		return medicine_salescompanies;
	}
	public void setMedicine_salescompanies(String medicineSalescompanies) {
		medicine_salescompanies = medicineSalescompanies;
	}
	public String getSourcecode() {
		return sourcecode;
	}
	public void setSourcecode(String sourcecode) {
		this.sourcecode = sourcecode;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getCpc() {
		return cpc;
	}
	public void setCpc(String cpc) {
		this.cpc = cpc;
	}
	public Integer getArea() {
		return area;
	}
	public void setArea(Integer area) {
		this.area = area;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public Search getSearch() {
		return search;
	}
	public void setSearch(Search search) {
		this.search = search;
	}
	public List<Search> getList() {
		return list;
	}
	public void setList(List<Search> list) {
		this.list = list;
	}
	public List<TabletBase> getTabletbaselist() {
		return tabletbaselist;
	}
	public void setTabletbaselist(List<TabletBase> tabletbaselist) {
		this.tabletbaselist = tabletbaselist;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public List<InOutStor> getInoutstorlist() {
		return inoutstorlist;
	}
	public void setInoutstorlist(List<InOutStor> inoutstorlist) {
		this.inoutstorlist = inoutstorlist;
	}
	public List<Search> getSearchlist_materialmed() {
		return searchlist_materialmed;
	}
	public void setSearchlist_materialmed(List<Search> searchlistMaterialmed) {
		searchlist_materialmed = searchlistMaterialmed;
	}
	public String getMedicine_material_corpname() {
		return medicine_material_corpname;
	}
	public void setMedicine_material_corpname(String medicineMaterialCorpname) {
		medicine_material_corpname = medicineMaterialCorpname;
	}
	
}

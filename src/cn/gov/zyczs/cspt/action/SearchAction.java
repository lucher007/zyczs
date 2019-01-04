package cn.gov.zyczs.cspt.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.zyczs.device.TerminalDeviceComponent;

import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.ISearchDao;
import cn.gov.zyczs.cspt.dao.ITabletBaseDao;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.Search;
import com.opensymphony.xwork2.ModelDriven;

public class SearchAction extends BaseAction implements ModelDriven<Search> {
	private static final long serialVersionUID = 1L;
	Search form =new Search();
	@Override
	public Search getModel() {
		return form;
	}
	
	private ISearchDao searchDao;
	public void setSearchDao(ISearchDao searchDao) {
		this.searchDao = searchDao;
	}

	private ITabletBaseDao tabletBaseDao;
	public void setTabletBaseDao(ITabletBaseDao tabletBaseDao) {
		this.tabletBaseDao = tabletBaseDao;
	}
	
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}


	public static void main(String[] args){
		TerminalDeviceComponent tdc = new TerminalDeviceComponent();
		String result = tdc.handler("zyczs_chengdu", "chengdu123","00-E0-4C-10-26-21", "51012730011459600004014011400000093");
		System.out.println(result);
		
	}


	public String findBySourceCode() throws Exception{
		
		String sourcecode=form.getSourcecode().trim();
		
		if(sourcecode==null||"".equals(sourcecode)){
			return "error";
		}
		if(!(sourcecode.length()==28||sourcecode.length()==35)){
			return "error";
		}
		String firstchar=sourcecode.substring(0,1);
		if(!(firstchar.equals("2")||firstchar.equals("3")||firstchar.equals("4")||firstchar.equals("5")||firstchar.equals("6"))){
			return "error";
		}
		if(form.getMac()==null||"".equals(form.getMac().trim())){
			return "error";
		}
		
		if(firstchar.equals("2")){
			form.setSearchtype("2");
		}else if(firstchar.equals("3")){
			form.setSearchtype("3");
		}else if(firstchar.equals("4")){
			form.setSearchtype("4");
		}else if(firstchar.equals("5")){
			form.setSearchtype("5");
		}else if(firstchar.equals("6")){
			form.setSearchtype("6");
		}
		System.out.println(ServletActionContext.getServletContext().getInitParameter("serach_user"));
		System.out.println(ServletActionContext.getServletContext().getInitParameter("serach_pwd"));
		TerminalDeviceComponent tdc = new TerminalDeviceComponent();
		String result = tdc.handler(ServletActionContext.getServletContext().getInitParameter("serach_user"), ServletActionContext.getServletContext().getInitParameter("serach_pwd"),form.getMac(), sourcecode);
//		String result = "<?xml version=\'1.0\' encoding=\'UTF-8\'?><zyczs><msgbody><piece><sourcecode>51012730011459600004014011400000093</sourcecode><productioncompanies>广西玉林市华安堂中药饮片有限责任公司</productioncompanies><salescompanies>广西玉林市华安堂中药饮片有限责任公司</salescompanies><batchcode>1101273001145961401070059</batchcode><name>人参</name><spec>kg</spec><standard>中国药典</standard><processflow>净制,炮制</processflow><operator>342</operator><manager>432</manager><qa>432</qa><producedate>2014-01-07 11:47:30</producedate><remark>测试</remark><weight>200.0</weight><areacode>450902</areacode><materials><material><corpname>广西玉林市华安堂中药饮片有限责任公司</corpname><checkmethod>企业标准</checkmethod><checkgrade>一级</checkgrade><checkthickmethod></checkthickmethod><checkcondition>药典标准</checkcondition><checkuser>4324</checkuser><checktime>2014-01-07 00:00:00</checktime></material></materials></piece><medicine><medicinecode>1101273001215831401061217</medicinecode><salescompanies></salescompanies><medicinename>土党参</medicinename><medicinesource>溯源药材</medicinesource><harvesttime>2014-01-06 00:00:00</harvesttime><plant><plantcode>1101273001215831401061204</plantcode><corpname></corpname><plantname>党参</plantname><plantsource>自购</plantsource><plantarea>100.0</plantarea><plantcycle>0.0</plantcycle><planttime>2014-01-06 00:00:00</planttime><plantuser>张李</plantuser><fieldmanagements><fieldmanagement><name></name><type>除草</type><weight>0.0</weight><addtime>2014-01-06 00:00:00</addtime><remark></remark></fieldmanagement></fieldmanagements></plant><materials><material><corpname>广西健宝石斛有限责任公司</corpname><checkmethod>企业标准</checkmethod><checkgrade></checkgrade><checkthickmethod>清洗|烘干|</checkthickmethod><checkcondition>药典标准</checkcondition><checkuser>423</checkuser><checktime>2014-01-06 00:00:00</checktime></material><material><corpname>广西玉林市华安堂中药饮片有限责任公司</corpname><checkmethod>企业标准</checkmethod><checkgrade></checkgrade><checkthickmethod>清洗|</checkthickmethod><checkcondition>药典标准</checkcondition><checkuser>234</checkuser><checktime>2014-01-06 00:00:00</checktime></material><material><corpname>广西圣康新药特药销售有限责任公司中药饮片分公司</corpname><checkmethod>企业标准</checkmethod><checkgrade></checkgrade><checkthickmethod>去芦头|去瓤|</checkthickmethod><checkcondition>药典标准</checkcondition><checkuser>45</checkuser><checktime>2014-01-07 00:00:00</checktime><reports><report><type>1</type><url>http://ylcspt.zyczs.gov.cn/checkMatImage.shtml?matcontent=img/grow/2014-01/201401071022141369_lyskxyty.jpg</url></report></reports></material><material><corpname>广西玉林市华安堂中药饮片有限责任公司</corpname><checkmethod>企业标准</checkmethod><checkgrade></checkgrade><checkthickmethod>切块|</checkthickmethod><checkcondition>药典标准</checkcondition><checkuser>12</checkuser><checktime>2014-01-07 00:00:00</checktime></material></materials></medicine></msgbody></zyczs>";
//		System.out.println(result);
			if(result!=null&&!"".equals(result)){
				Document document = DocumentHelper.parseText(result);
//为空判断
				if(document.selectSingleNode("zyczs/msgbody")!=null){
					if(document.selectSingleNode("zyczs/msgbody").hasContent()==false||document.selectSingleNode("zyczs/msgbody").getStringValue().length()<1){
						return "error";
					}
				}
				
				if(document.selectSingleNode("zyczs/msgbody/body")!=null){
					if(document.selectSingleNode("zyczs/msgbody/body").getStringValue().length()>0){
						return "error";
					}
				}
				
//饮片			
				//饮片溯源码
				if(document.selectSingleNode("zyczs/msgbody/piece/sourcecode")!=null){
					form.setPiece_sourcecode(document.selectSingleNode("zyczs/msgbody/piece/sourcecode").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/sourcecode").getText().toString());
				}
				//饮片名称
				if(document.selectSingleNode("zyczs/msgbody/piece/name")!=null){
					form.setPiece_name(document.selectSingleNode("zyczs/msgbody/piece/name").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/name").getText().toString());
				}
				//生产企业
				if(document.selectSingleNode("zyczs/msgbody/piece/productioncompanies")!=null){
					form.setPiece_productioncompanies(document.selectSingleNode("zyczs/msgbody/piece/productioncompanies").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/productioncompanies").getText().toString());
				}
				//销售企业
				if(document.selectSingleNode("zyczs/msgbody/piece/salescompanies")!=null){
					form.setPiece_salescompanies(document.selectSingleNode("zyczs/msgbody/piece/salescompanies").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/salescompanies").getText().toString());
				}
				//饮片批次号
				if(document.selectSingleNode("zyczs/msgbody/piece/batchcode")!=null){
					form.setPiece_batchcode(document.selectSingleNode("zyczs/msgbody/piece/batchcode").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/batchcode").getText().toString());
				}
				//生产规格
				if(document.selectSingleNode("zyczs/msgbody/piece/spec")!=null){
					form.setPiece_spec(document.selectSingleNode("zyczs/msgbody/piece/spec").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/spec").getText().toString());
				}
				//执行标准
				if(document.selectSingleNode("zyczs/msgbody/piece/standard")!=null){
					form.setPiece_standard(document.selectSingleNode("zyczs/msgbody/piece/standard").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/standard").getText().toString());
				}
				//生产流程
				if(document.selectSingleNode("zyczs/msgbody/piece/processflow")!=null){
					form.setPiece_processflow(document.selectSingleNode("zyczs/msgbody/piece/processflow").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/processflow").getText().toString());
				}
				//工艺员
				if(document.selectSingleNode("zyczs/msgbody/piece/operator")!=null){
					form.setPiece_operator(document.selectSingleNode("zyczs/msgbody/piece/operator").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/operator").getText().toString());
				}
				//生产部经理
				if(document.selectSingleNode("zyczs/msgbody/piece/manager")!=null){
					form.setPiece_manager(document.selectSingleNode("zyczs/msgbody/piece/manager").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/manager").getText().toString());
				}
				//QA
				if(document.selectSingleNode("zyczs/msgbody/piece/qa")!=null){
					form.setPiece_qa(document.selectSingleNode("zyczs/msgbody/piece/qa").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/qa").getText().toString());
				}
				//生产日期
				if(document.selectSingleNode("zyczs/msgbody/piece/producedate")!=null){
					form.setPiece_producedate(document.selectSingleNode("zyczs/msgbody/piece/producedate").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/producedate").getText());
				}
				//备注
				if(document.selectSingleNode("zyczs/msgbody/piece/remark")!=null){
					form.setPiece_remark(document.selectSingleNode("zyczs/msgbody/piece/remark").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/remark").getText().toString());
				}
				//待包装重量(单位:g)
				if(document.selectSingleNode("zyczs/msgbody/piece/weight")!=null){
					form.setPiece_weight(document.selectSingleNode("zyczs/msgbody/piece/weight").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/weight").getText().toString());
				}
				//地区编码,按国标处理
				if(document.selectSingleNode("zyczs/msgbody/piece/areacode")!=null){
					try{
						form.setPiece_areacode(document.selectSingleNode("zyczs/msgbody/piece/areacode").getText().equals("null")?"无":codeAreaDao.findShortName(document.selectSingleNode("zyczs/msgbody/piece/areacode").getText().toString()));
					}catch(Exception e){
						return "error";
					}
				}
				//企业代码(14位)，流通节点编号
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/corpcode")!=null){
					form.setPiece_material_corpcode(document.selectSingleNode("zyczs/msgbody/piece/materials/material/corpcode").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/corpcode").getText().toString());
				}
				
				
				
				
				//检验方法
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkmethod")!=null){
					form.setPiece_material_checkmethod(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkmethod").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkmethod").getText().toString());
				}
				//质量级别
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkgrade")!=null){
					form.setPiece_material_checkgrade(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkgrade").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkgrade").getText().toString());
				}
				//粗加工方法
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkthickmethod")!=null){
					form.setPiece_material_checkthickmethod(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkthickmethod").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkthickmethod").getText().toString());
				}
				//贮藏条件
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkcondition")!=null){
					form.setPiece_material_checkcondition(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkcondition").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkcondition").getText().toString());
				}
				//检验人员
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkuser")!=null){
					form.setPiece_material_checkuser(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkuser").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checkuser").getText().toString());
				}
				//检验时间
				if(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checktime")!=null){
					form.setPiece_material_checktime(document.selectSingleNode("zyczs/msgbody/piece/materials/material/checktime").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/piece/materials/material/checktime").getText().toString());
				}
				
				
				List<Search> searchlist_reporttablet = new ArrayList<Search>();
				//检验报告
				if(document.selectNodes("zyczs/msgbody/piece/materials/material/reports")!=null&&document.selectNodes("zyczs/msgbody/piece/materials/material/reports/report")!=null&&document.selectNodes("zyczs/msgbody/piece/materials/material/reports/report/type")!=null&&document.selectNodes("zyczs/msgbody/piece/materials/material/reports/report/url")!=null){
					List<Element> list  = document.selectNodes("zyczs/msgbody/piece/materials/material/reports/report");
					for (int j = 0; j < list.size(); j++) {
						Search search = new Search();
		                Element node = (Element) list.get(j);
		                if(node.selectSingleNode("type").getText().equals("1")){
		                	search.setPiece_report_type("检验报告");
		                }else if(node.selectSingleNode("type").getText().equals("2")){
		                	search.setPiece_report_type("产地报告");
		                }
		                search.setPiece_report_url(node.selectSingleNode("url").getText());
		                searchlist_reporttablet.add(search);
		            }
				}
				form.setSearchlist_reporttablet(searchlist_reporttablet);
				
				
				
		
//药材				
				//药材批次号
				if(document.selectSingleNode("zyczs/msgbody/medicine/medicinecode")!=null){
					form.setMedicine_medicinecode(document.selectSingleNode("zyczs/msgbody/medicine/medicinecode").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/medicinecode").getText().toString());
				}
				//药材名称
				if(document.selectSingleNode("zyczs/msgbody/medicine/medicinename")!=null){
					form.setMedicine_medicinename(document.selectSingleNode("zyczs/msgbody/medicine/medicinename").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/medicinename").getText().toString());
				}
				//药材来源
				if(document.selectSingleNode("zyczs/msgbody/medicine/medicinesource")!=null){
					form.setMedicine_medicinesource(document.selectSingleNode("zyczs/msgbody/medicine/medicinesource").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/medicinesource").getText().toString());
				}
				//收获时间
				if(document.selectSingleNode("zyczs/msgbody/medicine/harvesttime")!=null){
					form.setMedicine_harvesttime(document.selectSingleNode("zyczs/msgbody/medicine/harvesttime").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/harvesttime").getText().toString());
				}
				//销售企业
				if(document.selectSingleNode("zyczs/msgbody/medicine/salescompanies")!=null){
					form.setMedicine_salescompanies(document.selectSingleNode("zyczs/msgbody/medicine/salescompanies").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/salescompanies").getText().toString());
				}
				
				
				
				
				
				//植物批次码
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcode")!=null){
					form.setPlant_plantcode(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcode").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcode").getText().toString());
				}
				//植物名称
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantname")!=null){
					form.setPlant_plantname(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantname").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantname").getText().toString());
				}
				//种子来源:自购|栽培|野生
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantsource")!=null){
					form.setPlant_plantsource(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantsource").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantsource").getText().toString());
				}
				//种植区域(单位:亩)
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantarea")!=null){
					form.setPlant_plantarea(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantarea").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantarea").getText().toString());
				}
				//种植周期(单位：月）
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcycle")!=null){
					form.setPlant_plantcycle(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcycle").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantcycle").getText().toString());
				}
				//种植时间
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/planttime")!=null){
					form.setPlant_planttime(document.selectSingleNode("zyczs/msgbody/medicine/plant/planttime").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/planttime").getText().toString());
				}
				//负责人
				if(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantuser")!=null){
					form.setPlant_plantuser(document.selectSingleNode("zyczs/msgbody/medicine/plant/plantuser").getText().equals("null")?"无":document.selectSingleNode("zyczs/msgbody/medicine/plant/plantuser").getText().toString());
				}
				
				//田间管理
				if(document.selectNodes("zyczs/msgbody/medicine/plant/fieldmanagements")!=null&&document.selectNodes("zyczs/msgbody/medicine/plant/fieldmanagements/fieldmanagement")!=null){
//					List<Element> list  = document.selectNodes("zyczs/msgbody/medicine/plant/fieldmanagements/fieldmanagement");
//					for (int j = 0; j < list.size(); j++) {
//		                Element node = (Element) list.get(j);
//		                System.out.println(node.selectSingleNode("name").getText());
//		            }
					form.setFieldmanagement_name("有");
				}else{
					form.setFieldmanagement_name("无");
				}
				
				
				//药材检验
				List<Search> searchlist_materialmed = new ArrayList<Search>();
				if(document.selectNodes("zyczs/msgbody/medicine/materials")!=null&&document.selectNodes("zyczs/msgbody/medicine/materials/material")!=null){
					List<Element> list  = document.selectNodes("zyczs/msgbody/medicine/materials/material");
					for (int j = 0; j < list.size(); j++) {
						Search search = new Search();
		                Element node = (Element) list.get(j);
		                
		                if(node==null){
		                	continue;
		                }
		                
		                //企业代码(14位)，流通节点编号
						if(node.selectSingleNode("corpname")!=null){
							search.setMedicine_material_corpname(node.selectSingleNode("corpname").getText().equals("null")?"无":node.selectSingleNode("corpname").getText().toString());
						}
						
						//检验方法
						if(node.selectSingleNode("checkmethod")!=null){
							search.setMedicine_material_checkmethod(node.selectSingleNode("checkmethod").getText().equals("null")?"无":node.selectSingleNode("checkmethod").getText().toString());
						}
						
						//质量级别
						if(node.selectSingleNode("checkgrade")!=null){
							search.setMedicine_material_checkgrade(node.selectSingleNode("checkgrade").getText().equals("null")?"无":node.selectSingleNode("checkgrade").getText().toString());
						}
						
						//粗加工方法
						if(node.selectSingleNode("checkthickmethod")!=null){
							search.setMedicine_material_checkthickmethod(node.selectSingleNode("checkthickmethod").getText().equals("null")?"无":node.selectSingleNode("checkthickmethod").getText().toString());
						}
						
						//贮藏条件
						if(node.selectSingleNode("checkcondition")!=null){
							search.setMedicine_material_checkcondition(node.selectSingleNode("checkcondition").getText().equals("null")?"无":node.selectSingleNode("checkcondition").getText().toString());
						}
						
						//检验人员
						if(node.selectSingleNode("checkuser")!=null){
							search.setMedicine_material_checkuser(node.selectSingleNode("checkuser").getText().equals("null")?"无":node.selectSingleNode("checkuser").getText().toString());
						}
						
						//检验时间
						if(node.selectSingleNode("checktime")!=null){
							search.setMedicine_material_checktime(node.selectSingleNode("checktime").getText().equals("null")?"无":node.selectSingleNode("checktime").getText().toString());
						}
						searchlist_materialmed.add(search);
					}
				}
				form.setSearchlist_materialmed(searchlist_materialmed);
				
				
				//检验报告
				List<Search> searchlist_reportmed = new ArrayList<Search>();
				
				if(document.selectNodes("zyczs/msgbody/medicine/materials/material/reports")!=null&&document.selectNodes("zyczs/msgbody/medicine/materials/material/reports/report")!=null&&document.selectNodes("zyczs/msgbody/medicine/materials/material/reports/report/type")!=null&&document.selectNodes("zyczs/msgbody/medicine/materials/material/reports/report/url")!=null){
					List<Element> list  = document.selectNodes("zyczs/msgbody/medicine/materials/material/reports/report");
					for (int j = 0; j < list.size(); j++) {
						Search search = new Search();
		                Element node = (Element) list.get(j);
		                if(node.selectSingleNode("type").getText().equals("1")){
		                	search.setMedicine_report_type("检验报告");
		                }else if(node.selectSingleNode("type").getText().equals("2")){
		                	search.setMedicine_report_type("产地报告");
		                }
		                search.setMedicine_report_url(node.selectSingleNode("url").getText());
		                searchlist_reportmed.add(search);
		            }
				}
				form.setSearchlist_reportmed(searchlist_reportmed);
			
			//System.out.println(document.selectSingleNode("zyczs/msgbody/piece/name").getText());
			//System.out.println(document.selectSingleNode("zyczs/msgbody/piece").getName());
			
		}
		return SUCCESS;
	}
	
	/**
	 * 查询各自区域下的企业信息
	 * @return
	 */
	public String findByList(){
		form.setList(searchDao.findByList(form));
		return "searchOrg";
	}
	
	/**
	 * 查询机饮片品名查询
	 * @return String
	 */
    public String findByList_Kiosks(){
		form.setTabletbaselist(tabletBaseDao.findByList_Kiosks());
		return "searchOrgname";
	}
    
    /**
	 * 查询企业最近6个月某个饮片的入库信息
	 * @return String
	 */
    public String findByList_Search(){
    	InOutStor inOut = new InOutStor();
    	inOut.setCpccorp(form.getCpc());
    	inOut.setProdname(form.getProdname());
		form.setInoutstorlist(inOutStorDao.findByList_Search(inOut));
		return "searchOrgInOut";
	}
}

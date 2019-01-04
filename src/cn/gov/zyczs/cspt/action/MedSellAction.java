package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.ICheckDao;
import cn.gov.zyczs.cspt.dao.ICheckMatDao;
import cn.gov.zyczs.cspt.dao.IChengSqlDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.IGoodsCodeDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.dao.impl.InOutStorBoxDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.ChengSql;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.GoodsCode;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.Med;
import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title MedMarketAction.java
 * @version 1.0 药材经销商
 */
public class MedSellAction extends BaseAction implements ModelDriven<MedStorage> {
	private static final long serialVersionUID = 1L;

	MedStorage form = new MedStorage();

	@Override
	public MedStorage getModel() {
		return form;
	}

	private IMedStorageDao medStorageDao;// 药材库存dao实现类

	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}

	private IBoxDao boxDao;// 出入库详情dao实现类

	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}

	private IRegionDao regionDao;

	public void setRegionDao(IRegionDao regionDao) {
		this.regionDao = regionDao;
	}

	private IMedBaseDao medBaseDao;// 药材基础dao实现类

	public void setMedBaseDao(IMedBaseDao medBaseDao) {
		this.medBaseDao = medBaseDao;
	}

	private IGoodsCodeDao goodsCodeDao;// 商品编码dao实现类

	public void setGoodsCodeDao(IGoodsCodeDao goodsCodeDao) {
		this.goodsCodeDao = goodsCodeDao;
	}

	private IMedDao medDao;// 药材dao实现类

	public void setMedDao(IMedDao medDao) {
		this.medDao = medDao;
	}

	private IInOutStorDao inOutStorDao;// 出入库dao实现类

	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}

	private InOutStorBoxDao inOutStorBoxDao;// 出入库详情dao实现类

	public void setInOutStorBoxDao(InOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}

	private ICodeRegionDao codeRegionDao;

	public void setCodeRegionDao(ICodeRegionDao codeRegionDao) {
		this.codeRegionDao = codeRegionDao;
	}

	private IZyczsXmlDao zyczsXmlDao;

	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	private ICheckDao checkDao;

	public void setCheckDao(ICheckDao checkDao) {
		this.checkDao = checkDao;
	}

	private ICheckMatDao checkMatDao;

	public void setCheckMatDao(ICheckMatDao checkMatDao) {
		this.checkMatDao = checkMatDao;
	}
	
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	
	private IChengSqlDao chengSqlDao;
	public void setChengSqlDao(IChengSqlDao chengSqlDao) {
		this.chengSqlDao = chengSqlDao;
	}
	
	/**
	 * 库存查询--批次合并
	 * 
	 * @return
	 */
	public String findMedGroupStorage() {
		User user = (User) getSession().getAttribute("User");
		form.setState(0);// 有库存
		
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		
		List<MedStorage> list=medStorageDao.findGroupByList(form);
		for(MedStorage stor:list){
			stor.setOrgid(user.getOrgid());
			stor.setState(0);
			//该批次溯源称销售重量
			stor.setTotalweight(medStorageDao.findChengWeightCount(stor.getCpcmed(), user.getOrgid())+"");
		}
		
		form.setPager_count(medStorageDao.findGroupByCount(form));
		form.setList(list);
		
		return "findMedGroupStorage";
	}
	
	/**
	 * 库存查询
	 * 
	 * @return
	 */
	public String findMedStorage() {
		User user = (User) getSession().getAttribute("User");
		form.setState(0);// 有库存
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));
		
		//该批次溯源称销售重量
		form.setTotalweight(medStorageDao.findChengWeightCount(form.getBatchcpc(), user.getOrgid())+"");
		
		return "findMedStorage";
	}

	/**
	 * 查询药材库存未分包药材信息
	 * 
	 * @return
	 */
	public String findNotPackList() {
		User user = (User) getSession().getAttribute("User");

		form.setMedtype(0);// 未分包
		form.setState(0);// 有库存
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));

		return "findNotPackList";
	}

	/**
	 * 根据药材批次号查询具体药材进行分包
	 * 
	 * @return
	 */
	public String findPackByCpcMed() {
		User user = (User) getSession().getAttribute("User");

		form.setMedtype(0);// 未分包
		form.setState(0);// 有库存
		form.setOrgid(user.getOrgid());
		form.setVo(medStorageDao.findMedStorage(form));

		return "findPackByCpcMed";
	}

	/**
	 * 药材分包
	 * 
	 * @return
	 */
	public String updateMedPack() {
		User _user = (User) getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setMedtype(0);// 未分包
		MedStorage medStorage = medStorageDao.findMedStorage(form);

		// 如果该药材已检验, 那么就把该药材的检验信息查询出来; 有检验报告也查询出来.
		Check check = null;
		List<CheckMat> checkMatList = null;
		if (medStorage.getCheckstate() == 1) {
			Check c = new Check();
			c.setMedstorid(medStorage.getMedstorid());
			c.setType(0);
			c.setOrgid(medStorage.getOrgid());
			check = checkDao.findCheckDetail(c);

			checkMatList = checkMatDao.findById(c);
		}

		/** ************1判断传回的当前的使用重量是否大于库存量******************* */
		Double weighttemp = Tools.subtr(medStorage.getMedweight().toString(), form.getUsetotal());
		if (weighttemp == null) {
			form.setReturninfo("当前分包使用量小于库存量！");
			findPackByCpcMed();
		} else {
			List<MedStorage> list = Tools.createMedStoragePack(form.getPackstr(), medStorage);

			if (list != null && list.size() > 0) {
				for (MedStorage vo : list) {
					Integer medstorid = medStorageDao.save(vo);

					if (check != null) {
						check.setProdid(medstorid);
						checkDao.save(check);

						if (checkMatList != null) {
							for (CheckMat checkMat : checkMatList) {
								checkMat.setProdid(medstorid);
								checkMatDao.save(checkMat);
							}
						}
					}

					if (medstorid == null) {
						form.setReturninfo("分包出错!");
						findPackByCpcMed();
					}

					/** ********2写入溯源码************************* */
					Map boxMedMap = new HashMap();
					boxMedMap.put("storageid", medstorid);
					boxMedMap.put("weight", vo.getMednumweight());
					boxMedMap.put("totalnum", vo.getMednum());
					boxMedMap.put("cpccorp", _user.getCpccorp());
					boxMedMap.put("orgid", _user.getOrgid());

					boxMedMap.put("cpcmed", vo.getCpcmed());
					boxMedMap.put("loginname", _user.getLoginname());
					boxMedMap.put("medname", vo.getMedname());
					boxMedMap.put("prodcode", vo.getProdcode());
					boxMedMap.put("areacode", vo.getAreacode());
					boxDao.saveBoxMed(boxMedMap);

				}

				if (weighttemp == 0 || weighttemp == 0.0 || weighttemp == 0.0f) {
					medStorage.setState(1);// 无库存
				}

				/** ******3更新未分包库存********* */
				medStorage.setMedweight(Double.parseDouble(weighttemp.toString()));
				//medStorage.setChangemedweight(medStorage.getMedweight());
				medStorageDao.update(medStorage);
				form.setReturninfo("药材分包成功!");

			}
		}
		return "updateMedPackFinish";
	}

	/**
	 * 查询已分包未打印的药材进行打码
	 * 
	 * @return
	 */
	public String findPrintCode() {
		User user = (User) getSession().getAttribute("User");

		form.setFlag("1");
		form.setState(0);
		form.setMedtype(1);// 已分包
		form.setPrintstate(3);
		form.setDownstate(2);
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));

		return "findPrintCode";
	}

	/**
	 * 非溯源药材入库
	 * 
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	@SuppressWarnings("unchecked")
	public String notSourceMedSave() throws IOException, DocumentException {
		String addNotSourceMed = "addNotSourceMed";
		String addNotSourceMedFinish = "addNotSourceMedFinish";

		User _user = (User) getSession().getAttribute("User");
		Map map = new HashMap();
		map.put("typeid", "1");// 批次号类型都为1
		map.put("companycodein", _user.getCpccorp());
		regionDao.findByCode(map);
		String cpcmed = map.get("zycid").toString() + Tools.getCheckCode(map.get("zycid").toString());

		Med med = new Med();
		// 药材批次码系统自动生成
		med.setCpcmed(cpcmed);
		// 药材类型
		med.setSource(form.getSource());
		// 预计产量和实际产量进入数据库*10000保留到g以下一位
		med.setMedweight(form.getMedweight() * 10000);
		// 收获时间
		med.setHarvesttime(form.getHarvesttime());
		// 化肥状况
		med.setFertilizer(form.getFertilizer());
		// 农药状况
		med.setPesticide(form.getPesticide());
		// 药材名
		med.setMedname(form.getMedname());
		// 企业内部批次号
		med.setMednumber(form.getMednumber());
		// 非溯源
		med.setMedtype(1);

		/** ********1:获取商品编码************** */
		MedBase medBase = new MedBase();
		medBase.setName(form.getMedname());
		MedBase mb = medBaseDao.findByName(medBase);
		if (mb == null) {
			form.setReturninfo("非溯源药材入库失败！");
			return addNotSourceMed;
		}
		String basecode = mb.getSourceid();
		if (basecode == null || "".equals(basecode)) {
			form.setReturninfo("非溯源药材入库失败！");
			return addNotSourceMed;
		}

		/** ****************2:请求商品编码,如果存在则直接用,不存在则请求接口将数据写入本地数据库后再用********************** */
		GoodsCode goodsCode = new GoodsCode();
		goodsCode.setBasecode(basecode);// 药材基础表的合并编码
		goodsCode.setType("0");// 0药材 1饮片
		goodsCode.setCpccorp(_user.getOrg().getCpccorp());
		goodsCode = goodsCodeDao.findByList(goodsCode);
		if (goodsCode == null) {
//			String method = Tools.xmlCpcMed(_user.getCpccorp(), basecode);
//			String xmlstr = Tools.sendPost(method, "prodinfo");
//			if (xmlstr == null || xmlstr.equals("")) {
//				form.setReturninfo("非溯源药材入库失败！");
//				return addNotSourceMed;
//			}
//
//			String respcode = "";
//			String prodcpccode = "";
//			if (xmlstr != null && !xmlstr.equals("")) {
//				Document document = DocumentHelper.parseText(xmlstr);
//				respcode = document.selectSingleNode("cpc/respcode").getText();
//				prodcpccode = document.selectSingleNode("cpc/operadata/prodcpccode").getText();
//				if (respcode == null || prodcpccode == null || "".equals(prodcpccode) || prodcpccode.length() != 20) {
//					form.setReturninfo("非溯源药材入库失败！");
//					return addNotSourceMed;
//				}
//				GoodsCode goodsCode1 = new GoodsCode();
//				goodsCode1.setType("0");
//				goodsCode1.setBasecode(basecode);
//				goodsCode1.setProdcode(prodcpccode);
//				goodsCode1.setCpccorp(_user.getOrg().getCpccorp());
//				goodsCodeDao.save(goodsCode1);
//				med.setProdcode(prodcpccode);
//			} else {
//				form.setReturninfo("非溯源药材入库失败！");
//				return addNotSourceMed;
//			}
			
			String prodcpccode=Tools.xmlCpcMed_local(_user.getCpccorp(), basecode);
			if(prodcpccode != null && !prodcpccode.equals("") && prodcpccode.length()==20){
				GoodsCode goodsCode1= new GoodsCode();
				goodsCode1.setType("0");
				goodsCode1.setBasecode(basecode);
				goodsCode1.setProdcode(prodcpccode);
				goodsCode1.setCpccorp(_user.getOrg().getCpccorp());
				goodsCodeDao.save(goodsCode1);
				med.setProdcode(prodcpccode);	
			}else{
				form.setReturninfo("非溯源药材入库失败！");
				return addNotSourceMed;
			}
		} else {
			med.setProdcode(goodsCode.getProdcode());
		}

		int medId = medDao.save(med);

		if (medId != 0) {
			form.setProdcode(med.getProdcode());
			form.setCpcmed(cpcmed);
			form.setMedweight(form.getMedweight() * 10000);
			form.setOrimedweight(form.getMedweight());
			//form.setChangemedweight(form.getMedweight());
			//将省市区封装到codeArea进行查询返回区域码
			CodeArea codeArea = new CodeArea();
			codeArea.setProvince(form.getProvince());
			codeArea.setCity(form.getCity());
			codeArea.setArea(form.getArea());
			
			String areacode = codeAreaDao.findByName(codeArea);
			if (areacode == null || "".equals(areacode)) {
				form.setReturninfo("非溯源药材入库失败！");
				return addNotSourceMed;
			}
			form.setAreacode(areacode);
			form.setState(0); // 药材库存状态:0有库存,1无库存
			form.setMedtype(0); // 药材是否分包:0药材未分包,1药材已分包
			form.setPrintstate(0);// 打印状态:0未打印,1已打印
			form.setOrgid(_user.getOrgid());
			form.setCheckstate(0);// 检验状态:0未检,1已检
			form.setUserid(_user.getUserid());
			form.setAddtime(form.getIntime());
			form.setMedstorid(medStorageDao.save(form));
			form.setCpccorp(_user.getOrg().getCpccorp());
			/** *************3新增出入库记录****************** */
			InOutStor inOutStor = new InOutStor();
			inOutStor.setType(0);// 类型:药材0,饮片1
			inOutStor.setStortype(0);// 类型:入库0,出库1
			inOutStor.setSellcorpname(_user.getCompany().getCorpname());
			inOutStor.setBuycorpname(_user.getCompany().getCorpname());
			inOutStor.setOpertime(form.getIntime());
			inOutStor.setUserid(_user.getUserid());
			inOutStor.setTotalmoney(0d);
			inOutStor.setTotalweight(form.getMedweight());
			inOutStor.setZstype(1);// 销售去向类型:0表示溯源企业;表示1非溯源企业;
			inOutStor.setOperator(_user.getLoginname());
			inOutStor.setCpccorp(_user.getCpccorp());
			inOutStor.setMobile(_user.getCompany().getMobile());
			inOutStor.setAddress(_user.getCompany().getRegisteraddress());
			inOutStor.setOrgid(_user.getOrgid());
			Integer inoutstorid = inOutStorDao.save(inOutStor);
			/** *************4新增出入库详情记录****************** */
			InOutStorBox inOutStorBox = new InOutStorBox();
			inOutStorBox.setBatchcpc(cpcmed);
			inOutStorBox.setBoxnum(0);
			inOutStorBox.setBoxitemnum(0);
			inOutStorBox.setTotalweight(med.getMedweight());
			inOutStorBox.setRealtotalweight(med.getMedweight());
			inOutStorBox.setPrice(0d);
			inOutStorBox.setTotalmoney(0d);
			inOutStorBox.setProdname(form.getMedname());
			inOutStorBox.setInoutstorid(inoutstorid);
			inOutStorBox.setProdcode(form.getProdcode());
			inOutStorBox.setProdnumber(form.getMednumber());
			inOutStorBox.setBoxitemnum(0);
			inOutStorBoxDao.save(inOutStorBox);

			form.setReturninfo("非溯源药材入库完成！");

			zyczsXmlDao.saveOjbect(ToolsXml.create_Med_codeinfo(med, _user, form.getAreacode(), 2));
			
			
			//根据组织id,商品编码,药材批次号查询当前最新库存
			MedStorage medStorage = medStorageDao.findCurrentMedWeight(form);
			medStorage.setCpccorp(_user.getCpccorp());
			
			//更新中间件SQL
			ChengSql outSql = new ChengSql();
			outSql.setSql(ToolSql.updateMedStroage(medStorage));
			chengSqlDao.saveOutSql(outSql);
			
			
			return addNotSourceMedFinish;
		} else {
			form.setReturninfo("非溯源药材入库失败！");
			return addNotSourceMed;
		}
	}

	/**
	 * 查询该种植基地下主要的产出药材
	 
	public String findMainMeds() {
		User _user = (User) getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		List<MedStorage> list = medStorageDao.findMainMeds(form);
		form.setList(list);
		return "medPriceChart";
	}*/
	
	public String findMainMeds() {
		User _user = (User) getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		List<MedStorage> list = medStorageDao.findMainMeds(form);
		form.setList(list);
		return "findPriceChart";
	}
	
	
	/**
	 * 药材库存统计
	 * 
	 * @return
	 */
	public String findMedStorageStat() {
		User _user = (User) getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setState(0);
		form.setPager_openset(10);

		String medaddtime = getRequest().getParameter("medaddtime");
		if (!"".equals(medaddtime) && medaddtime != null) {
			if (medaddtime.length() == 10 || medaddtime.length() == 11) {
				form.setMedaddtime(medaddtime + " 00:00:00");
			}
		}
		String medendtime = getRequest().getParameter("medendtime");
		if (!"".equals(medendtime) && medendtime != null) {
			if (medendtime.length() == 10 || medendtime.length() == 11) {
				form.setMedendtime(medendtime + " 23:59:59");
			}
		}

		form.setPager_count(medStorageDao.findByMedsellStatCount(form));
		form.setList(medStorageDao.findByMedsellStatList(form));
		String totalweight = medStorageDao.findByMedsellStatTotalweight(form);
		if (totalweight != null && !"".equals(totalweight)) {
			form.setTotalweight(totalweight);
		}
		return "findMedStorageStat";
	}

	/**
	 * 查询已分包已打印的药材出库
	 * 
	 * @return
	 */
	public String findMedOutStorage() {
		User user = (User) getSession().getAttribute("User");

		form.setFlag("2");
		form.setState(0);
		form.setMedtype(1);// 已分包
		form.setPrintstate(3);
		form.setDownstate(2);

		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));

		return "findMedOutStorage";
	}

}

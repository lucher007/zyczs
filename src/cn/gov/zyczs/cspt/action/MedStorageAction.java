package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.IBoxItemDao;
import cn.gov.zyczs.cspt.dao.ICheckDao;
import cn.gov.zyczs.cspt.dao.ICheckMatDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.dao.impl.BoxItemDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.BoxItem;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title PlantAction.java
 * @version 1.0 药材库存action类
 */
public class MedStorageAction extends BaseAction implements ModelDriven<MedStorage> {
	private static final long serialVersionUID = 1L;

	MedStorage form = new MedStorage();
	@Override
	public MedStorage getModel() {
		return form;
	}
	private IMedStorageDao medStorageDao;
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	private ICheckMatDao checkMatDao;
	public void setCheckMatDao(ICheckMatDao checkMatDao) {
		this.checkMatDao = checkMatDao;
	}
	
	private IBoxDao boxDao;
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	
	private IBoxItemDao boxItemDao;
	
	private ICheckDao checkDao;
	public void setCheckDao(ICheckDao checkDao) {
		this.checkDao = checkDao;
	}
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	
	public String medStorageChoice() {
		User _user = (User) getSession().getAttribute("User");
		form.setPager_openset(5);// 一页显示10行
		form.setOrgid(_user.getOrgid());
		form.setCheckstate(1);
		form.setState(0);//有库存
		form.setPager_count(medStorageDao.findTabletMedStorageCount(form));
		form.setList(medStorageDao.findTabletMedStorage(form));
		return "medStorageChoice";
	}
	
	/**
	 * 显示药材内部批次号
	 * @return
	 */
	public String medStorageChoice2() {
		User _user = (User) getSession().getAttribute("User");
		form.setPager_openset(5);// 一页显示10行
		form.setOrgid(_user.getOrgid());
		form.setCheckstate(1);
		form.setState(0);//有库存
		form.setPager_count(medStorageDao.findTabletMedStorageCount2(form));
		form.setList(medStorageDao.findTabletMedStorage2(form));
		return "medStorageChoice";
	}

	
	
	/**
	 * 药材检验管理列表
	 */
	public String findCheckList() {
		// 当flag为med时,是种植平台的药材检验;当为tablet时,是生产平台的药材检验
		// flag为medsell时是药材经销商的药材检验, flag为medmarket时是市场的药材检验
		String flag = getRequest().getParameter("flag");
		String resultPage = "";

		if (!"medmarket".equals(flag)) {
			User user = (User) getSession().getAttribute("User");
			form.setOrgid(user.getOrgid());
		} else {
			User user = (User) getSession().getAttribute("comuser");
			if(user != null){
				form.setOrgid(user.getOrgid());
			}
		}

		form.setState(0);// 0-有库存,1-无库存
		form.setCheckstate(0);// 0-未检验, 1-已检验
		form.setPager_openset(10);

		if ("med".equals(flag)) {
			resultPage = "findMedCheckList";
			form.setPager_count(medStorageDao.findByCheckCount(form));
			form.setList(medStorageDao.findByCheckList(form));
		} else if ("tablet".equals(flag)) {
			resultPage = "findTabletCheckList";
			form.setPager_count(medStorageDao.findByProductionMedCheckCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckList(form);
			for(MedStorage stor:list){
				MedStorage formtmp = new MedStorage();
				formtmp.setOrgid(form.getOrgid());
				formtmp.setState(form.getState());
				formtmp.setCheckstate(form.getCheckstate());
				formtmp.setMedname(form.getMedname());
				formtmp.setMedstorid(stor.getMedstorid());
				formtmp.setPager_offset(0);
				formtmp.setPager_openset(10);
				List<MedStorage> checklist = medStorageDao.findByList(formtmp);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getMedstorid());
				}
			}
			form.setList(list);
		} else if ("medsell".equals(flag)) {
			resultPage = "findMedsellCheckList";
			form.setPager_count(medStorageDao.findByProductionMedCheckCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckList(form);
			for(MedStorage stor:list){
				MedStorage formtmp = new MedStorage();
				formtmp.setOrgid(form.getOrgid());
				formtmp.setState(form.getState());
				formtmp.setCheckstate(form.getCheckstate());
				formtmp.setMedname(form.getMedname());
				formtmp.setMedstorid(stor.getMedstorid());
				formtmp.setPager_offset(0);
				formtmp.setPager_openset(10);
				List<MedStorage> checklist = medStorageDao.findByList(formtmp);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getMedstorid());
				}
			}
			form.setList(list);
		} else if ("medmarket".equals(flag)) {
			resultPage = "findMedmarketCheckList";
			form.setPager_count(medStorageDao.findByProductionMedCheckCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckList(form);
			for(MedStorage stor:list){
				MedStorage formtmp = new MedStorage();
				formtmp.setOrgid(form.getOrgid());
				formtmp.setState(form.getState());
				formtmp.setCheckstate(form.getCheckstate());
				formtmp.setMedname(form.getMedname());
				formtmp.setMedstorid(stor.getMedstorid());
				formtmp.setPager_offset(0);
				formtmp.setPager_openset(10);
				List<MedStorage> checklist = medStorageDao.findByList(formtmp);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getMedstorid());
				}
			}
			form.setList(list);
		}

		return resultPage;
	}

	/**
	 * 已检药材列表
	 * 
	 * @return
	 */
	public String findCheckedList() {
		// 当flag为med时,是种植平台的药材检验;当为tablet时,是生产平台的药材检验
		String flag = getRequest().getParameter("flag");
		String resultPage = "";
		User user = null;
		if (!"medmarket".equals(flag)) {
			user = (User) getSession().getAttribute("User");
		} else {
			user = (User) getSession().getAttribute("comuser");
		}
		form.setOrgid(user.getOrgid());
		form.setType(0);// 0-药材, 1-饮片
		form.setPager_openset(10);

		if ("med".equals(flag)) {
			form.setPager_count(medStorageDao.findByCheckedCount(form));
			List<MedStorage> list = medStorageDao.findByCheckedList(form);
			for(MedStorage stor:list){
				Check check = new Check();
				check.setOrgid(form.getOrgid());
				check.setType(form.getType());
				check.setCpcmed(stor.getCpcmed());
				check.setPager_offset(0);
				check.setPager_openset(10);
				List<Check> checklist = checkDao.findByList(check);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getProdid());
					stor.setChecktime(checklist.get(0).getAddtime());
				}
			}
			form.setList(list);
			resultPage = "findMedCheckedList";
		} else if ("tablet".equals(flag)) {
			form.setPager_count(medStorageDao.findByProductionMedCheckedCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckedList(form);
			for(MedStorage stor:list){
				Check check = new Check();
				check.setOrgid(form.getOrgid());
				check.setType(form.getType());
				check.setCpcmed(stor.getCpcmed());
				check.setPager_offset(0);
				check.setPager_openset(10);
				List<Check> checklist = checkDao.findByList(check);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getProdid());
					stor.setChecktime(checklist.get(0).getAddtime());
				}
			}
			form.setList(list);
			resultPage = "findTabletCheckedList";
		} else if ("medsell".equals(flag)) {
			form.setPager_count(medStorageDao.findByProductionMedCheckedCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckedList(form);
			for(MedStorage stor:list){
				Check check = new Check();
				check.setOrgid(form.getOrgid());
				check.setType(form.getType());
				check.setCpcmed(stor.getCpcmed());
				check.setPager_offset(0);
				check.setPager_openset(10);
				List<Check> checklist = checkDao.findByList(check);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getProdid());
					stor.setChecktime(checklist.get(0).getAddtime());
				}
			}
			form.setList(list);
			resultPage = "findMedsellCheckedList";
		} else if ("medmarket".equals(flag)) {
			form.setPager_count(medStorageDao.findByProductionMedCheckedCount(form));
			List<MedStorage> list = medStorageDao.findByProductionMedCheckedList(form);
			for(MedStorage stor:list){
				Check check = new Check();
				check.setOrgid(form.getOrgid());
				check.setType(form.getType());
				check.setCpcmed(stor.getCpcmed());
				check.setPager_offset(0);
				check.setPager_openset(10);
				List<Check> checklist = checkDao.findByList(check);
				if(checklist!=null && checklist.size()>0){
					stor.setMedstorid(checklist.get(0).getProdid());
					stor.setChecktime(checklist.get(0).getAddtime());
				}
			}
			form.setList(list);
			resultPage = "findMedmarketCheckedList";
		}
		return resultPage;
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
	 * 批次对应库存查询
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
		form.setPager_openset(10);
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
					vo.setAddtime(Tools.getCurrentTime());
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
		System.out.println("===========================================");
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
	 * 查询药材库存已分包,有库存的药材信息
	 * 
	 * @return
	 */
	public String findPackedList() {
		User user = (User) getSession().getAttribute("User");

		form.setMedtype(1);
		form.setState(0);
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));

		return "findPackedList";
	}

	/**
	 * 根据药材批次号和药材库存id查询具体已分包药材进行拆包
	 * 
	 * @return
	 */
	public String findPackedByCpcMed() {
		User user = (User) getSession().getAttribute("User");

		form.setMedtype(1);// 已分包
		form.setState(0);// 有库存
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setVo(medStorageDao.findMedStorage(form));

		return "findPackedByCpcMed";
	}

	/**
	 * 药材拆包
	 * 
	 * @return
	 */
	public String updateMedPacked() {
		User _user = (User) getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setMedtype(1);// 已分包
		MedStorage medStorage = medStorageDao.findMedStorage(form);

		/** ************1判断传回的当前的使用重量是否大于库存量******************* */
		Double weighttemp = Tools.subtr(medStorage.getMedweight().toString(), form.getUsetotal());
		if (weighttemp == null) {
			form.setReturninfo("当前分包使用量小于库存量！");
			findPackedByCpcMed();
		} else {
			List<MedStorage> list = Tools.createMedStoragePack(form.getPackstr(), medStorage);

			/** **************2新增分包记录*************************** */
			if (list != null && list.size() > 0) {
				for (MedStorage vo : list) {
					Integer medstorid = medStorageDao.save(vo);
					if (medstorid == null) {
						form.setReturninfo("分包出错!");
						findPackedByCpcMed();
					}

					/** *************** */
					Map storageitemMap = new HashMap();

				}

				/** *************3新增一条重新分包后的剩余重量记录***************** */
				if (weighttemp > 0) {
					medStorage.setMedweight(weighttemp);
					medStorageDao.save(medStorage);
				}
				/** ******4更新用来拆包的记录为无库存状态****** */
				medStorage.setState(1);
				medStorageDao.update(medStorage);

				form.setReturninfo("药材拆包成功!");
			}
		}
		return "updateMedPackFinish";
	}

	/**
	 * 药材出库查询
	 * 
	 * @return
	 */
	/*
	public String findOutStorage() {
			
		User user = (User)getSession().getAttribute("User");
		if (form.getBoxcodes() == null || form.getBoxcodes().length() < 3) {
			form.setReturninfo("填写溯源码错误");
			return "findOutStorage";
		}

		Map<String, List<MedStorage>> map = new HashMap<String, List<MedStorage>>();
		// 记录失败溯源码
		List<InStorFailCode> failList = new ArrayList<InStorFailCode>();
		
		//溯源码锁定状态查询
		List<Freeze> freezeList=boxDao.findByFreezeList(form.getBoxcodes(), user.getOrgid(), 0);
		//设置锁定溯源码
		if(freezeList!=null&&freezeList.size()>0){
			for(Freeze freeze:freezeList){
				
				InStorFailCode instor = new InStorFailCode();				
				instor.setCode(freeze.getCpccode());
				instor.setReason(freeze.getCpclevel()+freeze.getReason());			
				failList.add(instor);
				//删除锁定溯源码
				if(form.getBoxcodes().indexOf(freeze.getCpccode()+"BR")!=-1){					
					form.setBoxcodes(form.getBoxcodes().replaceAll(freeze.getCpccode()+"BR", ""));				
				}		
			}
		}
		//去掉最后一个BR符号
		int index=form.getBoxcodes().lastIndexOf("BR");
		if(index!=-1&&index==form.getBoxcodes().length()-2){
			form.setBoxcodes(form.getBoxcodes().substring(0,form.getBoxcodes().length()-2));
		}
		
		if(!"".equals(form.getBoxcodes())){
			
			String[] boxcodesarray = form.getBoxcodes().split("BR");
			List<String> liststr = Arrays.asList(boxcodesarray);
			
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes().replaceAll("BR", "','")+"'");
			boxmap.put("orgid", user.getOrgid());
			List<MedStorage> medstorage = medStorageDao.findByBox(boxmap);
			
			if (medstorage != null && medstorage.size() > 0) {
				for (String codes : liststr) {
					int i = 0;
					for (MedStorage ms : medstorage) {
						if (codes.equals(ms.getBoxcode())) {
							i = 1;
							break;
						}
					}
					if (i == 0) {
						InStorFailCode instor = new InStorFailCode();
						instor.setReason("0");
						instor.setCode(codes);
						failList.add(instor);
					}
				}
				for (MedStorage ms : medstorage) {
					String cpc = ms.getCpcmed() + ms.getBoxweight();
					List<MedStorage> mslist = map.get(cpc);
					if (mslist != null && mslist.size() > 0) {
						mslist.add(ms);
						map.put(cpc, mslist);
					} else {
						List<MedStorage> mslistnew = new ArrayList<MedStorage>();
						mslistnew.add(ms);
						map.put(cpc, mslistnew);
					}
				}
			} else {
				//封装全部错误溯源码
				Tools.setFailCodes(liststr, failList);
			}
			
			
		}
		
		getSession().setAttribute("medOutStoragemap", map);
		getRequest().setAttribute("failList", failList);
		return "addOutStorage";
	}
*/
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
	
	/**
	 * 查询可以修改库存的数据
	 * @return
	 */
	public String findChangeMedStorage() {
		User user = (User) getSession().getAttribute("comuser");
		if(user == null){
			user = (User) getSession().getAttribute("User");
		}
		
		form.setState(0);
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(medStorageDao.findByCount(form));
		form.setList(medStorageDao.findByList(form));

		return "findChangeMedStorage";
	}
	
	/**
	 * 修改库存量
	 * @return
	 */
	public String updateChangeMedWeight(){
		User user = (User) getSession().getAttribute("User");
		if(form.getMedtype() == 0){
			form.setMedweight(form.getChange() * 10000);
			form.setMednum(null);
		}else{
			form.setMednumweight(form.getChange() * 10000);
			form.setMedweight(form.getMednumweight() * form.getMednum());
			
		}
		
		Integer result = medStorageDao.update(form);
		if(result != 0){
			form.setReturncode(1);
			//xml
			List<Box> boxs = new ArrayList<Box>();
			if(form.getMedtype() == 1){
				//已分包的继续修改box,boxitem中的药材每包规格
				Box box = new Box();
				box.setStortype(0);//药材
				box.setStorid(form.getMedstorid());
				box.setState(0);//有库存
				box.setBoxweight(form.getMednumweight());
				boxDao.updateWeight(box);
				
				boxs = boxDao.findByAll(box);
				
				if(boxs != null && boxs.size() > 0 ){
					BoxItem boxItem = new BoxItem();
					boxItem.setWeight(form.getMednumweight());
					
					for(int i = 0 ; i < boxs.size() ; i++){
						
						boxItem.setBoxcode(boxs.get(i).getBoxcode());
						boxItemDao.update(boxItem);
					}
				}
				
			}
			zyczsXmlDao.saveOjbect(ToolsXml.create_Med_chanagestorage(form,boxs,user,form.getMedtype()));
		}else{
			form.setReturncode(0);
		}
		return SUCCESS;
	}


	public void setBoxItemDao(IBoxItemDao boxItemDao) {
		this.boxItemDao = boxItemDao;
	}
}

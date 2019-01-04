package cn.gov.zyczs.cspt.action;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.dao.IScaleConfDao;
import cn.gov.zyczs.cspt.dao.IScaleDao;
import cn.gov.zyczs.cspt.dao.IScaleKeyConfDao;
import cn.gov.zyczs.cspt.dao.IScalefckDao;
import cn.gov.zyczs.cspt.dao.IScalepluDao;
import cn.gov.zyczs.cspt.dao.IScalestatDao;
import cn.gov.zyczs.cspt.po.Scale;
import cn.gov.zyczs.cspt.po.ScaleConf;
import cn.gov.zyczs.cspt.po.ScaleKeyConf;
import cn.gov.zyczs.cspt.po.Scalefck;
import cn.gov.zyczs.cspt.po.Scaleplu;
import cn.gov.zyczs.cspt.po.Scalestat;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author user
 *
 */
public class ScaleAction extends BaseAction implements ModelDriven<Scale> {
	private static final long serialVersionUID = 1L;
	
	Scale form = new Scale();
	public Scale getModel() {
		return form;
	}
	private IScaleDao scaleDao;
	private IScaleConfDao scaleConfDao;
	private IScaleKeyConfDao scaleKeyConfDao;
	private IScalefckDao scalefckDao;
	private IMedBaseDao medBaseDao;
	private IScalestatDao scalestatDao;
	private IScalepluDao scalepluDao;
	public IScaleDao getScaleDao() {
		return scaleDao;
	}
	public void setScaleDao(IScaleDao scaleDao) {
		this.scaleDao = scaleDao;
	}
	public IScaleConfDao getScaleConfDao() {
		return scaleConfDao;
	}

	public void setScaleConfDao(IScaleConfDao scaleConfDao) {
		this.scaleConfDao = scaleConfDao;
	}
	public IScaleKeyConfDao getScaleKeyConfDao() {
		return scaleKeyConfDao;
	}
	public void setScaleKeyConfDao(IScaleKeyConfDao scaleKeyConfDao) {
		this.scaleKeyConfDao = scaleKeyConfDao;
	}
	public IScalefckDao getScalefckDao() {
		return scalefckDao;
	}
	public void setScalefckDao(IScalefckDao scalefckDao) {
		this.scalefckDao = scalefckDao;
	}
	public IMedBaseDao getMedBaseDao() {
		return medBaseDao;
	}
	public void setMedBaseDao(IMedBaseDao medBaseDao) {
		this.medBaseDao = medBaseDao;
	}
	public IScalestatDao getScalestatDao() {
		return scalestatDao;
	}
	public void setScalestatDao(IScalestatDao scalestatDao) {
		this.scalestatDao = scalestatDao;
	}
	public IScalepluDao getScalepluDao() {
		return scalepluDao;
	}
	public void setScalepluDao(IScalepluDao scalepluDao) {
		this.scalepluDao = scalepluDao;
	}
	/**
	 * 查询溯源秤信息
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(scaleDao.findByCount(form));
		List<Scale> ScaleList = scaleDao.findByList(form);
		form.setScaleList(ScaleList);
		return "findByList";
	}
	/**
	 * 查询经营户下面所属企业的溯源秤信息
	 */
	public String findScalesCPC(){
		form.setPager_openset(10);
//		form.setPager_count(scaleDao.findScalesCPCCount(form));
		List<Scale> ScaleList = scaleDao.findScalesCPC(form);
		form.setScaleList(ScaleList);
		return "findScalesCPC";
	}
	
	/**
	 * 查询经营户下面所属企业的溯源秤信息
	 */
	public String findScalesListByCPC(){
		form.setPager_openset(10);
		form.setPager_count(scaleDao.findScalesListByCount(form));
		List<Scale> ScaleList = scaleDao.findScalesListByCPC(form);
		form.setScaleList(ScaleList);
		return "findScalesListByCPC";
	}
	/**
	 * 添加溯源秤信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addScaleInit(){
		//构建溯源秤规格Map对象
		List<ScaleConf> list = scaleConfDao.queryByList(new ScaleConf());
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ScaleConf scaleConf = (ScaleConf) iterator.next();
			map.put(scaleConf.getScaleid(),scaleConf.getCompanyname() 
					+ "-" + scaleConf.getModelnumber() + "-" + scaleConf.getKeynum() + "键");
			
		}
		form.setScale(form);
		form.setScaleConfMap(map);
		return "addScaleInit";
	}
	
	/**
	 * 保存溯源秤信息
	 */
	@SuppressWarnings("unchecked")
	public String saveScale(){
		List<Scale> scale = form.getScaleList();
		String currentTime = Tools.getCurrentTime();
		for (Iterator iterator = scale.iterator(); iterator.hasNext();) {
			Scale scale2 = (Scale) iterator.next();
			String[] str = scale2.getScalenorm().split(",");
			if(str.length>=2){
				scale2.setScalenorm(str[1].trim());
				scale2.setScaleconfid(Integer.valueOf(str[0].trim()));
			}
			scale2.setUsercode(form.getUsercode());
			scale2.setUserName(form.getUserName());
			scale2.setScalecode(scale2.getScalecode());
			scale2.setScalestate(0);
			scale2.setAddtime(currentTime);
			scaleDao.save(scale2);
			
			//程序自动insert改成的当前数据到S_SCALESTAT表。
			//默认情况为不锁定溯源秤，同时自动要求溯源秤更新为最新版本。并且要求更新快捷键。
			Scalestat scalestat = new Scalestat();
			
			//初始时，溯源秤快捷键默认应该发送KeyVer=0，
			//同时程序入库时候，程序将comKeyVer自动写入1，以要求快捷键更新
			scalestat.setComkeyver(0);
			
			//初始时，溯源秤PLU版本数据默认应该发送PLUVer=0。程序自动在SCALEPLU中
			//获取select max(pluver) from S_SCALEPLU最大的PLU版本，要求溯源秤进行更新到最新版本
			Integer maxPluver = scalepluDao.findMaxPluver(new Scaleplu());
			if(maxPluver == null || maxPluver < 1){
				maxPluver = 0;
			}
			scalestat.setCompluver(Long.valueOf(maxPluver));
			
			scalestat.setComlocked(0);
			
			scalestat.setKeyver(0);
			scalestat.setPluver(0L);
			scalestat.setLocked(0);
			
			//设置键数
			ScaleConf confTemp = new ScaleConf();
			confTemp.setScaleid(scale2.getScaleconfid());
			ScaleConf conf = scaleConfDao.findById(confTemp);
			if(conf.getKeynum() != null){
				scalestat.setPlucnt(Integer.valueOf(conf.getKeynum()));
			}
			scalestat.setHearttime(currentTime);
			scalestat.setUsercode(form.getUsercode());
			scalestat.setScalecode(scale2.getScalecode());
			if(!"".equals(scale2.getUsercode()) && scale2.getUsercode() != null){
				scalestat.setCpccorp(scale2.getUsercode().substring(3,13));
			}
			scalestatDao.save(scalestat);
		}
		form.setReturninfo("添加溯源秤成功！");
		if(!"".equals(form.getUsercode())){
			return "saveFinsh";
		}
		return "saveScale";
	}
	
	
	/**
	 * 更新溯源秤信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateScaleInit(){
		Scale scale = scaleDao.findObjById(form);
		
		ScaleConf resScaleConf = new ScaleConf();
		resScaleConf.setScaleid(scale.getScaleconfid());
		ScaleConf scaleConf = scaleConfDao.findById(resScaleConf);
		ScaleKeyConf scaleKeyConf = new ScaleKeyConf();
		scaleKeyConf.setScaleid(scaleConf.getScaleid());
		List<ScaleKeyConf> scaleKeyConfList = scaleKeyConfDao.queryByList(scaleKeyConf);
		List<ScaleKeyConf> keyConfList = scaleKeyConfDao.queryListByValueNull(scaleKeyConf);
		String keyString = "";
		String keyMap = "";
		//构建对应数据字符串
		//可以使用的所有按钮  按钮上数字值，x,y
		//var keyArray=new Array("1,1,1","2,1,2","2,2,3","2,3,4","2,5,5","3,5,6");
		//  - x,y  - x,y 
		//var keyString = "-1,1,1-2,1,2-2,2,3-2,3,4-2,5,4-3,5,6";
		for (Iterator iterator = keyConfList.iterator(); iterator.hasNext();) {
			ScaleKeyConf keyConf = (ScaleKeyConf) iterator.next();
			keyString += "-" + keyConf.getRowsname() + "," + keyConf.getColumnname() + "," + keyConf.getConfvale();
			keyMap += "|-" + keyConf.getRowsname() + "," + keyConf.getColumnname()+ "@" + keyConf.getConfvale();
		}
		
		Scalefck scalefck = new Scalefck();
		scalefck.setScaleid(scale.getScaleconfid());
		scalefck.setScalecode(scale.getScalecode());
		//获取对应快捷键表中对应横纵坐标位置值
		List<Scalefck> scalefckList = new ArrayList<Scalefck>();
		scalefckList = scalefckDao.quryListByScaleid(scalefck); 
		
		//获取称键配置表中配置值不为空的数据
		List<ScaleKeyConf> tempList = scaleKeyConfDao.queryKeyconfList(scaleKeyConf);
		//如果对应快捷键表中无数据，根据溯源秤编码取得溯源秤键配置表数据，构建在快捷键集合中
		if(scalefckList.size() == 0 || scalefckList == null){
			for (Iterator iterator = tempList.iterator(); iterator.hasNext();) {
				ScaleKeyConf keyConf = (ScaleKeyConf) iterator.next();
				Scalefck tempScalefck = new Scalefck();
				//纵坐标
				tempScalefck.setColumnname(keyConf.getColumnname());
				//横坐标
				tempScalefck.setRowsname(keyConf.getRowsname());
				//对应值
				tempScalefck.setConfvale(keyConf.getConfvale());
				scalefckList.add(tempScalefck);
			}
		}
		
		form.setScalefck(scalefck);
		form.setScale(scale);
		form.setScaleConf(scaleConf);
		form.setKeyConfList(scaleKeyConfList);
		form.setScalefckList(scalefckList);
		form.setKeyString(keyString);
		form.setKeyMap(keyMap);
		return "updateScaleInit";
	}
	
	/**
	 * 更新溯源秤信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateScalefck(){
		List<String> strList = form.getStrList();
		Scalefck scalefck = new Scalefck();
		scalefck.setScalecode(form.getScalecode());
		scalefckDao.deleteObj(scalefck);
		for (int i = 1; i < strList.size(); i++) {
			Scalefck conf = new Scalefck();
			String[] str = strList.get(i).trim().split("@");
			if(str.length > 1 && !"".equals(str[1]) && !"undefined".equals(str[1]) && !"".equals(str[2]) && !"undefined".equals(str[2])){
				conf.setScalecode(form.getScalecode());
				if(Integer.parseInt(str[0].trim())< 10){
					conf.setFckcode("0" + str[0].trim());
				}else{
					conf.setFckcode(str[0].trim());
				}
				conf.setPlucodes(str[1].trim());
				conf.setMedname(str[2].trim());
				scalefckDao.save(conf);
			}
		}
		return "updateScalefck";
	}
	
	/**
	 * 检验溯源秤号是否存在
	 * @throws IOException 
	 */
	@SuppressWarnings("unchecked")
	public void checkScaleCode(){
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
//			form.setScalecode(form.getScalecode().trim());
			Scale scale = scaleDao.findObjById(form);
			if(scale != null && !"".equals(form.getScalecode().trim())){
				out.print("对不起溯源码已存在！");
			}else{
				out.print("");
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

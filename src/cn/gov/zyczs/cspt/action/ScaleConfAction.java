package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.dao.IScaleConfDao;
import cn.gov.zyczs.cspt.dao.IScaleKeyConfDao;
import cn.gov.zyczs.cspt.po.ScaleConf;
import cn.gov.zyczs.cspt.po.ScaleKeyConf;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author user
 *
 */
public class ScaleConfAction extends BaseAction implements ModelDriven<ScaleConf> {
	private static final long serialVersionUID = 1L;
	
	ScaleConf form = new ScaleConf();
	public ScaleConf getModel() {
		return form;
	}
	private IScaleConfDao scaleConfDao;
	
	private IScaleKeyConfDao scaleKeyConfDao;
	
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

	/**
	 * 查询溯源秤信息
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(scaleConfDao.findByCount(form));
		List<ScaleConf> scaleConfList = scaleConfDao.findByList(form);
		form.setScaleList(scaleConfList);
		return "findByList";
	}
	
	/**
	 * 更新溯源秤信息初始化
	 */
	public String updateInit(){
		form.setCompanyname("");
		form.setKeynum("");
		ScaleConf conf = new ScaleConf();
		conf = scaleConfDao.findById(form);
		form.setScale(scaleConfDao.findById(conf));
		ScaleKeyConf keyConf = new ScaleKeyConf();
		keyConf.setScaleid(form.getScaleid());
		List<ScaleKeyConf> keyConfList = scaleKeyConfDao.queryByList(keyConf);
		form.setKeyConfList(keyConfList);
		return "updateInit";
	}
	
	
	/**
	 * 更新溯源秤信息
	 */
	public String update(){
		Integer scaleId = scaleConfDao.updateByObj(form);
		if(scaleId != 0){
			List<String> strList = form.getStrList();
			ScaleKeyConf confs = new ScaleKeyConf();
			confs.setScaleid(form.getScaleid());
			scaleKeyConfDao.delete(confs);
			for (int i = 1; i < strList.size(); i++) {
				ScaleKeyConf conf = new ScaleKeyConf();
				conf.setRowsname(strList.get(i).split(",")[0]);
				conf.setColumnname(strList.get(i).split(",")[1]);
				if(strList.get(i).split(",").length >= 3){
					conf.setConfvale(strList.get(i).split(",")[2]);
				}else{
					conf.setConfvale("");
				}
				conf.setScaleid(form.getScaleid());
				scaleKeyConfDao.save(conf);
			}
		}else{
//			form.setReturninfo("更新溯源秤失败!");
		}
		return "update";
	}
	
	/**
	 * 新增溯源秤信息
	 */
	public String save(){
		Integer scaleId = scaleConfDao.save(form);
		ScaleConf resConf = new ScaleConf();
		resConf.setScaleid(scaleId);
		resConf = scaleConfDao.findById(resConf);
		
		if(scaleId != 0){
			List<String> strList = form.getStrList();
			for (int i = 1; i < strList.size(); i++) {
				ScaleKeyConf conf = new ScaleKeyConf();
				conf.setRowsname(strList.get(i).split(",")[0]);
				conf.setColumnname(strList.get(i).split(",")[1]);
				if(strList.get(i).split(",").length >= 3){
					conf.setConfvale(strList.get(i).split(",")[2]);
				}else{
					conf.setConfvale("");
				}
				conf.setScaleid(resConf.getScaleid());
				scaleKeyConfDao.save(conf);
			}
		}else{
//			form.setReturninfo("更新溯源秤失败!");
		}
		return "save";
	}
}

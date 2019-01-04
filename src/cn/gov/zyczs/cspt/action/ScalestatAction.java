package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IScalepluDao;
import cn.gov.zyczs.cspt.dao.IScalestatDao;
import cn.gov.zyczs.cspt.po.Scaleplu;
import cn.gov.zyczs.cspt.po.Scalestat;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author user
 *
 */
public class ScalestatAction extends BaseAction implements ModelDriven<Scalestat> {
	private static final long serialVersionUID = 1L;
	
	Scalestat form = new Scalestat();
	public Scalestat getModel() {
		return form;
	}
	private IScalestatDao scalestatDao;
	private IScalepluDao scalepluDao;
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
		form.setPager_count(scalestatDao.findByCount(form));
		List<Scalestat> ScalestatList = scalestatDao.findByList(form);
		form.setScalestatList(ScalestatList);
		return "findByList";
	}
	
	/**
	 * 更新溯源秤信息
	 */
	public String update(){
		if(scalestatDao.updateByObj(form)!=0){
			form.setReturninfo("更新溯源秤成功!");
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "update";
	}
	
	/**
	 * 更新溯源秤信息
	 */
	public String updateScale(){
		if(scalestatDao.updateByObj(form)!=0){
			form.setReturninfo("更新溯源秤成功!");
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "updateScale";
	}
	
	/**
	 * 更新溯源秤信息
	 */
	public String updateKeyver(){
		Scalestat scale = scalestatDao.findById(form);
		Integer comkeyver = 0;
		if(scale.getComkeyver() + 1 > 9){
			comkeyver = 1;
		}else{
			comkeyver = scale.getComkeyver() + 1;
		}
		System.out.print(scale.getHearttime().length());
		if(scale.getHearttime().length() == 21){
			scale.setHearttime(scale.getHearttime().substring(0, scale.getHearttime().length()-2));
		}else{
			scale.setHearttime(Tools.getCurrentTime());
		}
		
		scale.setComkeyver(comkeyver);
		if(scalestatDao.updateByObj(scale)!=0){
			form.setReturninfo("更新溯源秤成功!");
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "updateKeyver";
	}

	/**
	 * 更新溯源秤Plu版本信息
	 */
	public String updatePluver(){
		Integer maxPluver = scalepluDao.findMaxPluver(new Scaleplu());
		if(maxPluver == null || maxPluver < 1){
			maxPluver = 0;
		}
		Scalestat tempScale = new Scalestat();
		tempScale.setScalecode(form.getScalecode());
		Scalestat scale = scalestatDao.findById(tempScale);
		//设置plu值
		if(scale.getHearttime().length() == 21){
			scale.setHearttime(scale.getHearttime().substring(0, scale.getHearttime().length()-2));
		}else{
			scale.setHearttime(Tools.getCurrentTime());
		}
		scale.setCompluver(Long.valueOf(maxPluver));
		if(scalestatDao.updateByObj(scale)!=0){
			form.setReturninfo("更新溯源秤成功!");
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "updatePluver";
	}
	
	/**
	 * 同步PLU数据
	 */
	public String synchronousPlu(){
		try{
			scalepluDao.synchronousPlu(new Scaleplu());
			form.setReturninfo("同步PLU数据成功!");
		} catch (Exception e) {
			form.setReturninfo("同步PLU数据失败!");
		}
		return "synchronousPlu";
	}
}

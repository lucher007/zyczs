package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.dao.IDeviceConfDao;
import cn.gov.zyczs.cspt.po.DeviceConf;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 设备规格管理
 * @author lucher
 *
 */
public class DeviceConfAction extends BaseAction implements ModelDriven<DeviceConf> {
	private static final long serialVersionUID = 1L;
	
	DeviceConf form = new DeviceConf();
	public DeviceConf getModel() {
		return form;
	}
	private IDeviceConfDao deviceConfDao;
	
	public IDeviceConfDao getDeviceConfDao() {
		return deviceConfDao;
	}

	public void setDeviceConfDao(IDeviceConfDao deviceConfDao) {
		this.deviceConfDao = deviceConfDao;
	}

	/**
	 * 查询设备规格配置信息
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(deviceConfDao.findByCount(form));
		List<DeviceConf> chengConfList = deviceConfDao.findByList(form);
		form.setDeviceconflist(chengConfList);
		return "findByList";
	}
	
	/**
	 * 更新设备规格信息初始化
	 */
	public String updateInit(){
		DeviceConf conf = new DeviceConf();
		conf = deviceConfDao.findById(form);
		form.setDeviceconf(conf);
		return "updateInit";
	}
	
	/**
	 * 更新设备配置信息
	 */
	public String update(){
		Integer confId = deviceConfDao.update(form);
		if(confId != 0){
			form.setReturninfo("更新设备成功!");
		}else{
			form.setReturninfo("更新设备失败!");
		}
		return "update";
	}
	
	/**
	 * 新增设备信息
	 */
	public String save(){
		Integer confId = deviceConfDao.save(form);
		if(confId != 0){
			form.setReturninfo("保存设备成功!");
		}else{
			form.setReturninfo("保存设备失败!");
		}
		return "save";
	}
}

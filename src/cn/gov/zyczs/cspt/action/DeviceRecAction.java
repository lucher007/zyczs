package cn.gov.zyczs.cspt.action;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.dao.IChengConfDao;
import cn.gov.zyczs.cspt.dao.IDeviceConfDao;
import cn.gov.zyczs.cspt.dao.IDeviceRecDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.po.ChengConf;
import cn.gov.zyczs.cspt.po.DeviceConf;
import cn.gov.zyczs.cspt.po.DeviceRec;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 设备回收信息
 * @author lucher
 *
 */
@SuppressWarnings("serial")
public class DeviceRecAction extends BaseAction implements ModelDriven<DeviceRec> {
	
	DeviceRec form = new DeviceRec();
	public DeviceRec getModel() {
		return form;
	}
	private IDeviceRecDao deviceRecDao;
	private IDeviceConfDao deviceConfDao;
	private IChengConfDao chengConfDao;
	private IOrgDao orgDao;

	/**
	 * 查询回收信息
	 */
	public String findByList(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(form.getDevicetype());
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
		}
		form.setDeviceconfmap(map);
		
		form.setPager_openset(10);
		form.setPager_count(deviceRecDao.findByCount(form));
		List<DeviceRec> DeviceRecList = deviceRecDao.findByList(form);
		for (DeviceRec deviceRec : DeviceRecList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(deviceRec.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf!=null){
				deviceRec.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceRecList(DeviceRecList);
		return "findByList";
	}
	
	/**
	 * 查询溯源秤回收信息
	 */
	public String findByList_cheng(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		ChengConf chengconf = new ChengConf();
		List<ChengConf> list = chengConfDao.queryByList(chengconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ChengConf chengConf = (ChengConf) iterator.next();
			map.put(chengConf.getConfid(),ToolSql.getCompanyNameByKey(chengConf.getCompanyname()) + "-" + chengConf.getNormname());
		}
		form.setDeviceconfmap(map);
		
		form.setPager_openset(10);
		form.setDevicetype(0);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描器；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
		form.setPager_count(deviceRecDao.findByCount_cheng(form));
		List<DeviceRec> DeviceRecList = deviceRecDao.findByList_cheng(form);
		for (DeviceRec deviceRec : DeviceRecList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(deviceRec.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				deviceRec.setNormname(ToolSql.getCompanyNameByKey(chengConf.getCompanyname())+"-"+chengConf.getNormname());
			}
		}
		form.setDeviceRecList(DeviceRecList);
		return "findByList_cheng";
	}

	//选择设备列表
	public void deviceConfQuery(){
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			DeviceConf deviceconf = new DeviceConf();
			deviceconf.setConftype(form.getDevicetype());
			List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
			Map<Integer,String> map = new HashMap<Integer,String>();
			JSONArray jsonArray = new JSONArray();
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				JSONObject jsonObject = new JSONObject();
				DeviceConf deviceConf = (DeviceConf) iterator.next();
				jsonObject.put("confid", deviceConf.getConfid());
				jsonObject.put("normname", deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
				jsonArray.add(jsonObject);
			}
			
			out.println(jsonArray.toString());
			
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public IDeviceRecDao getDeviceRecDao() {
		return deviceRecDao;
	}

	public void setDeviceRecDao(IDeviceRecDao deviceRecDao) {
		this.deviceRecDao = deviceRecDao;
	}

	public IDeviceConfDao getDeviceConfDao() {
		return deviceConfDao;
	}

	public void setDeviceConfDao(IDeviceConfDao deviceConfDao) {
		this.deviceConfDao = deviceConfDao;
	}

	public IOrgDao getOrgDao() {
		return orgDao;
	}

	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}

	public IChengConfDao getChengConfDao() {
		return chengConfDao;
	}

	public void setChengConfDao(IChengConfDao chengConfDao) {
		this.chengConfDao = chengConfDao;
	}

	
	
}

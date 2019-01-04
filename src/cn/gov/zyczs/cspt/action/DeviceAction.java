package cn.gov.zyczs.cspt.action;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IDeviceConfDao;
import cn.gov.zyczs.cspt.dao.IDeviceDao;
import cn.gov.zyczs.cspt.dao.IDeviceRecDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.Device;
import cn.gov.zyczs.cspt.po.DeviceConf;
import cn.gov.zyczs.cspt.po.DeviceRec;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author lucher
 *
 */
@SuppressWarnings("serial")
public class DeviceAction extends BaseAction implements ModelDriven<Device> {
	
	Device form = new Device();
	public Device getModel() {
		return form;
	}
	private IDeviceDao deviceDao;
	private IDeviceRecDao deviceRecDao;
	private IDeviceConfDao deviceConfDao;
	private IOrgDao orgDao;
	
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	/**
	 * 查询打印机信息
	 */
	public String findByList_printer(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_printer";
	}
	
	/**
	 * 添加打印机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_printer(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_printer";
	}
	
	/**
	 * 保存打印机信息
	 */
	public String saveDevice_printer(){
		form.setDevicetype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("打印机编码不能为空！");
			return addDeviceInit_printer();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("打印机编码已经存在！");
				return addDeviceInit_printer();
			}
		}
		form.setIp("");
		//打印机保存
		Integer deviceid = deviceDao.save(form);
		if(deviceid != null){
			form.setReturninfo("添加打印机成功！");
		}else{
			form.setReturninfo("添加打印机失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		return addDeviceInit_printer();
	}
	
	/**
	 * 修改打印机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateDeviceInit_printer(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		form.setDevice(device);
		return "updateDeviceInit_printer";
	}
	
	/**
	 * 保存打印机信息
	 */
	public String updateDevice_printer(){
		form.setDevicetype(1);//设备类型(1-打印机；2-扫描设备；3-移动终端；
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("打印机编码不能为空！");
			return updateDeviceInit_printer();
		}
		form.setIp("");
		//打印机保存
		Integer deviceid = deviceDao.update(form);
		if(deviceid != null){
			form.setReturninfo("修改打印机成功！");
		}else{
			form.setReturninfo("修改打印机失败！");
		}
		
		return updateDeviceInit_printer();
	}
	
	/**
	 * 回收打印机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_printer(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_printer";
	}
	
	/**
	 * 回收打印机
	 */
	public String recoverDevice_printer(){
		User user = (User) getSession().getAttribute("User");
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			
			//操作日志记录
			saveOpLog(user,"回收打印机","打印机编号:"+device.getDevicecode());
			
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_printer();
	}
	
	/**
	 * 查询扫描设备信息
	 */
	public String findByList_scanner(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_scanner";
	}
	
	/**
	 * 添加扫描设备信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_scanner(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_scanner";
	}

	/**
	 * 保存扫描设备信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_scanner(){
		form.setDevicetype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("扫描设备编码不能为空！");
			return addDeviceInit_scanner();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("扫描设备编码已经存在！");
				return addDeviceInit_scanner();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加扫描设备成功！");
		}else{
			form.setReturninfo("添加扫描设备失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_scanner();
	}
	
	/**
	 * 修改扫描设备信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateDeviceInit_scanner(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		form.setDevice(device);
		return "updateDeviceInit_scanner";
	}
	
	/**
	 * 保存扫描设备修改信息
	 */
	public String updateDevice_scanner(){
		form.setDevicetype(2);//设备类型(1-打印机；2-扫描设备；3-移动终端；
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("扫描设备编码不能为空！");
			return updateDeviceInit_scanner();
		}
		form.setIp("");
		//打印机保存
		Integer deviceid = deviceDao.update(form);
		if(deviceid != null){
			form.setReturninfo("修改扫描设备成功！");
		}else{
			form.setReturninfo("修改扫描设备失败！");
		}
		
		return updateDeviceInit_scanner();
	}
	
	/**
	 * 修改扫描设备信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_scanner(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_scanner";
	}
	
	/**
	 * 保存扫描抢回收信息
	 */
	public String recoverDevice_scanner(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_scanner();
	}
	
	
	/**
	 * 查询移动终端信息
	 */
	public String findByList_mobile(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(3);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(3);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_mobile";
	}
	
	/**
	 * 添加移动终端信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_mobile(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(3);//设备类型(1-打印机；2-扫描设备；3-移动终端；)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_mobile";
	}

	/**
	 * 保存移动终端信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_mobile(){
		form.setDevicetype(3);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("移动终端编码不能为空！");
			return addDeviceInit_mobile();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("移动终端编码已经存在！");
				return addDeviceInit_mobile();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加移动终端成功！");
		}else{
			form.setReturninfo("添加移动终端失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_mobile();
	}
	
	/**
	 * 回收移动终端信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_mobile(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_mobile";
	}
	
	/**
	 * 保存移动终端回收信息
	 */
	public String recoverDevice_mobile(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_mobile();
	}
	
	/**
	 * 查询IC卡信息
	 */
	public String findByList_card(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_card";
	}
	
	/**
	 * 添加IC卡信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_card(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_card";
	}

	/**
	 * 保存IC卡信息
	 */
	public String saveDevice_card() {
		try{
			User user = (User) getSession().getAttribute("User");
			form.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
			form.setIp("");
			//扫描设备保存
			Integer deviceid = deviceDao.save(form);
			
			//判断页面是否需要回收设备
			if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
				//查询出要回收的设备
				Device oldDevice = new Device();
				oldDevice.setDeviceid(form.getRecdeviceid());
				oldDevice = deviceDao.findById(oldDevice);
				if(oldDevice != null){
					DeviceRec deviceRec = new DeviceRec();
					Tools.setVOToVO(oldDevice, deviceRec);
					deviceRec.setReason(form.getRecreason());//页面填写的回收原因
					deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
					//删除发放信息
					deviceDao.delete(oldDevice);
					
					//添加回收信息
					deviceRecDao.save(deviceRec);
				}
			}
			
			//将设备表中该企业下的所有IC卡编号查询出来组织XML发给中央平台
			Device device = new Device();
			device.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
			device.setCpccorp(form.getCpccorp());
	        List<Device> deviceList = deviceDao.queryByList(device);
	        
	        String sendCard = "";
	        for(int i =0; deviceList!=null && i<deviceList.size();i++){
	        	if(i==0){//不是list的最后一个
	        		sendCard = deviceList.get(i).getDevicecode();
	        	}else{
	        		sendCard = sendCard + "," + deviceList.get(i).getDevicecode();
	        	}
	        }
			
			Org org = new Org();
			org.setOrgid(form.getOrgid());
			org = orgDao.findById(org);
			if(org != null){
				org.setSendcard(sendCard);
				org.setCardtype(form.getCardtype());
				//组装发送IC卡XML
				String method = ToolSql.getSendCardXml(org);
				
				String xmlstr;
				try{
					xmlstr = Tools.sendPost(method,"corpinfo");
				}catch(Exception ex){
					form.setReturninfo("发送IC卡XML文件失败,请求中央接口超时!");
					return addDeviceInit_card();
				}
				
	
				if(xmlstr==null||xmlstr.equals("")){
					form.setReturninfo("发送IC卡XML文件失败!");
					return addDeviceInit_card();
				}
				String respcode ="";
				String cpccorptemp ="";	
				if(xmlstr!=null&&!xmlstr.equals("")){
					Document document = DocumentHelper.parseText(xmlstr); 
					respcode =document.selectSingleNode("cpc/respcode").getText();
					cpccorptemp =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
					if(respcode==null||!respcode.equals("0000")||cpccorptemp==null||"".equals(cpccorptemp)||cpccorptemp.length()!=14){
						form.setReturninfo("发送XML文件失败!");
						return addDeviceInit_card();
					}	
				}
				
//				//更新org表的sendcard字段信息
//				Map< String, Object> map = new ConcurrentHashMap<String, Object>();
//				map.put("sendcard", sendCard);
//				map.put("orgid", org.getOrgid());
//				Integer resultOrgid = orgDao.updateByMap(map);
			}
			form.setReturninfo("发送IC卡成功！");
			
			//操作日志记录
			saveOpLog(user,"发送IC卡","IC卡编号:"+form.getDevicecode());
			
		} catch(Exception e){
			form.setReturninfo("发送IC卡失败！");
		}
		return addDeviceInit_card();
	}
	
	/**
	 * 回收IC卡信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_card(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_card";
	}
	
	/**
	 * 保存IC卡回收信息
	 */
	public String recoverDevice_card(){
		try{
			User user = (User) getSession().getAttribute("User");
			Device device = deviceDao.findById(form);
			if(device!=null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(device, deviceRec);
				deviceRec.setReason(form.getReason());//页面填写的回收原因
				deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(device);
				//添加回收信息
				deviceRecDao.save(deviceRec);
				
				//将设备表中该企业下的所有IC卡编号查询出来组织XML发给中央平台
				Device deviceDmp = new Device();
				deviceDmp.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
				deviceDmp.setCpccorp(form.getCpccorp());
		        List<Device> deviceList = deviceDao.queryByList(deviceDmp);
		        
		        String sendCard = "";//组织IC卡号
		        for(int i =0; deviceList!=null && i<deviceList.size();i++){
		        	if(i==0){//不是list的最后一个
		        		sendCard = deviceList.get(i).getDevicecode();
		        	}else{
		        		sendCard = sendCard + "," + deviceList.get(i).getDevicecode();
		        	}
		        }
				
				Org org = new Org();
				org.setCpccorp(form.getCpccorp());
				List<Org> orgList = orgDao.findByCpccorp(org);
				if(orgList != null && orgList.size()>0){
					org = orgList.get(0);
					org.setSendcard(sendCard);
					org.setCardtype(device.getCardtype());
					//组装发送IC卡XML
					String method = ToolSql.getSendCardXml(org);
					
					String xmlstr;
					try{
						xmlstr = Tools.sendPost(method,"corpinfo");
					}catch(Exception ex){
						form.setReturninfo("发送IC卡XML文件失败,请求中央接口超时!");
						return recoverDeviceInit_card();
					}
		
					if(xmlstr==null||xmlstr.equals("")){
						form.setReturninfo("发送IC卡XML文件失败!");
						return recoverDeviceInit_card();
					}
					String respcode ="";
					String cpccorptemp ="";	
					if(xmlstr!=null&&!xmlstr.equals("")){
						Document document = DocumentHelper.parseText(xmlstr); 
						respcode =document.selectSingleNode("cpc/respcode").getText();
						cpccorptemp =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
						if(respcode==null||!respcode.equals("0000")||cpccorptemp==null||"".equals(cpccorptemp)||cpccorptemp.length()!=14){
							form.setReturninfo("发送XML文件失败!");
							return recoverDeviceInit_card();
						}	
					}
					
//					//更新org表的sendcard字段信息
//					Map< String, Object> map = new ConcurrentHashMap<String, Object>();
//					map.put("sendcard", sendCard);
//					map.put("orgid", org.getOrgid());
//					Integer resultOrgid = orgDao.updateByMap(map);
				}
				
				//操作日志记录
				saveOpLog(user,"回收IC卡","IC卡编号:"+device.getDevicecode());
				
				form.setReturninfo("回收IC卡成功！");
			}
		} catch(Exception e){
			form.setReturninfo("回收IC卡失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_card();
	}
	
	/**
	 * 重置IC卡信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateDeviceInit_card(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(4);//设备类型(1-打印机；2-扫描设备；3-移动终端；4-IC卡)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		Org org = new Org();
		org.setCpccorp(device.getCpccorp());
		List<Org> orgList = orgDao.findByCpccorp(org);
		if(orgList!=null && orgList.size() >0){
			org = orgList.get(0);
			String marketcode = org.getMarketcode();
			if( marketcode!= null && !"".equals(marketcode)){//表示该企业是市场经商户
				Org orgPar = new Org();
				orgPar.setCpccorp(marketcode);
				List<Org> marketList = orgDao.findByCpccorp(orgPar);//查询此经商户的市场
				if(marketList != null && marketList.size() > 0){
					Org market = marketList.get(0);
					org.setMarketname(market.getOrgname());//将市场名称写入单位中
				}
			}
		}
		device.setOrg(org);
		form.setDevice(device);
		return "updateDeviceInit_card";
	}
	
	/**
	 * 保存IC卡重置信息
	 */
	public String updateDevice_card(){
		try{
			form.setDevicetype(4);//设备类型(1-打印机；2-扫描设备；3-移动终端；4-IC卡
			
			if("".equals(form.getDevicecode())){
				form.setReturninfo("扫描设备编码不能为空！");
				return updateDeviceInit_card();
			}
			
			//查询出重置之前的IC卡信息
			Device device = deviceDao.findById(form);
			String oldcpccorp = device.getCpccorp();
			String newcpccorp = form.getCpccorp();
			
			form.setIp("");
			//扫描设备保存
			Integer deviceid = deviceDao.update(form);
			
			if(!oldcpccorp.equals(newcpccorp)){ //表示修改了发放企业，需要重新发放IC卡XML给中央平台
				//给旧企业发送XML-----------------------
				Device deviceDmp = new Device();
				deviceDmp.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
				deviceDmp.setCpccorp(oldcpccorp);
		        List<Device> oldDeviceList = deviceDao.queryByList(deviceDmp);
		        String oldSendCard = "";
		        for(int i =0; oldDeviceList!=null && i<oldDeviceList.size();i++){
		        	if(i==0){//不是list的最后一个
		        		oldSendCard = oldDeviceList.get(i).getDevicecode();
		        	}else{
		        		oldSendCard = oldSendCard + "," + oldDeviceList.get(i).getDevicecode();
		        	}
		        }
				Org oldOrg = new Org();
				oldOrg.setCpccorp(oldcpccorp);
				List<Org> oldOrgList = orgDao.findByCpccorp(oldOrg);
				if(oldOrgList!=null && oldOrgList.size() >0){
					oldOrg = oldOrgList.get(0);
					oldOrg.setSendcard(oldSendCard);
					oldOrg.setCardtype(device.getCardtype());
					//组装发送IC卡XML
					String oldMethod = ToolSql.getSendCardXml(oldOrg);
					
					String xmlstr;
					try{
						xmlstr = Tools.sendPost(oldMethod,"corpinfo");
					}catch(Exception ex){
						form.setReturninfo("重置IC卡成功,请求中央接口超时!");
						return updateDeviceInit_card();
					}
		
					
	//				//更新org表的sendcard字段信息
	//				Map< String, Object> map = new ConcurrentHashMap<String, Object>();
	//				map.put("sendcard", sendCard);
	//				map.put("orgid", org.getOrgid());
	//				Integer resultOrgid = orgDao.updateByMap(map);
				}
				
				//给新企业发送XML-----------------------
				deviceDmp.setCpccorp(newcpccorp);
		        List<Device> newDeviceList = deviceDao.queryByList(deviceDmp);
		        String newSendCard = "";
		        for(int i =0; newDeviceList!=null && i<newDeviceList.size();i++){
		        	if(i==0){//不是list的最后一个
		        		newSendCard = newDeviceList.get(i).getDevicecode();
		        	}else{
		        		newSendCard = newSendCard + "," + newDeviceList.get(i).getDevicecode();
		        	}
		        }
				Org newOrg = new Org();
				newOrg.setCpccorp(newcpccorp);
				List<Org> newOrgList = orgDao.findByCpccorp(newOrg);
				if(newOrgList!=null && newOrgList.size() >0){
					newOrg = newOrgList.get(0);
					newOrg.setSendcard(newSendCard);
					newOrg.setCardtype(device.getCardtype());
					//组装发送IC卡XML
					String newMethod = ToolSql.getSendCardXml(newOrg);
					String xmlstr;
					try{
						xmlstr = Tools.sendPost(newMethod,"corpinfo");
					}catch(Exception ex){
						form.setReturninfo("重置IC卡成功,请求中央接口超时!");
						return updateDeviceInit_card();
					}
					
		
					
	//				//更新org表的sendcard字段信息
	//				Map< String, Object> map = new ConcurrentHashMap<String, Object>();
	//				map.put("sendcard", sendCard);
	//				map.put("orgid", org.getOrgid());
	//				Integer resultOrgid = orgDao.updateByMap(map);
				}
				
				
			}
			form.setReturninfo("重置IC卡成功！");
		}catch(Exception e){
			form.setReturninfo("重置IC卡失败！");
		}
		return updateDeviceInit_card();
	}
	
	
	
	/**
	 * 查询查询机信息
	 */
	public String findByList_querymachine(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(5);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(5);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_querymachine";
	}
	
	/**
	 * 添加查询机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_querymachine(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(5);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_querymachine";
	}

	/**
	 * 保存查询机信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_querymachine(){
		form.setDevicetype(5);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("查询机编码不能为空！");
			return addDeviceInit_querymachine();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("查询机编码已经存在！");
				return addDeviceInit_querymachine();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加查询机成功！");
		}else{
			form.setReturninfo("添加查询机失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_querymachine();
	}
	
	/**
	 * 回收查询机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_querymachine(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_querymachine";
	}
	
	/**
	 * 保存查询机回收信息
	 */
	public String recoverDevice_querymachine(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_querymachine();
	}
	
	/**
	 * 查询耗材信息
	 */
	public String findByList_material(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(6);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(6);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_material";
	}
	
	/**
	 * 添加耗材信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_material(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(6);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机 6-耗材)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_material";
	}

	/**
	 * 保存耗材信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_material(){
		form.setDevicetype(6);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("耗材编码不能为空！");
			return addDeviceInit_material();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("耗材编码已经存在！");
				return addDeviceInit_material();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加耗材成功！");
		}else{
			form.setReturninfo("添加耗材失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_material();
	}
	
	/**
	 * 回收耗材信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_material(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_material";
	}
	
	/**
	 * 保存耗材回收信息
	 */
	public String recoverDevice_material(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_material();
	}
	
	/**
	 * 查询计算机信息
	 */
	public String findByList_computer(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(7);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(7);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_computer";
	}
	
	/**
	 * 添加计算机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_computer(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(7);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机 6-耗材；7-计算机)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_computer";
	}

	/**
	 * 保存计算机信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_computer(){
		form.setDevicetype(7);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机）
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("计算机编码不能为空！");
			return addDeviceInit_computer();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("计算机编码已经存在！");
				return addDeviceInit_computer();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加计算机成功！");
		}else{
			form.setReturninfo("添加计算机失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_computer();
	}
	
	/**
	 * 回收计算机信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_computer(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_computer";
	}
	
	/**
	 * 保存计算机回收信息
	 */
	public String recoverDevice_computer(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_computer();
	}
	
	/**
	 * 查询读写卡器信息
	 */
	public String findByList_reader(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(8);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(8);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_reader";
	}
	
	/**
	 * 添加读写卡器信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_reader(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(8);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机 6-耗材；7-计算机；8-读写卡器)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_reader";
	}

	/**
	 * 保存读写卡器信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_reader(){
		form.setDevicetype(8);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器）
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("读写卡器编码不能为空！");
			return addDeviceInit_reader();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("读写卡器编码已经存在！");
				return addDeviceInit_reader();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加读写卡器成功！");
		}else{
			form.setReturninfo("添加读写卡器失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_reader();
	}
	
	/**
	 * 回收读写卡器信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_reader(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_reader";
	}
	
	/**
	 * 保存读写卡器回收信息
	 */
	public String recoverDevice_reader(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_reader();
	}
	
	
	/**
	 * 查询其他设备信息
	 */
	public String findByList_others(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(9);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		
		form.setDevicetype(9);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器)
		form.setPager_openset(10);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
		}
		form.setDeviceList(DeviceList);
		return "findByList_others";
	}
	
	/**
	 * 添加其他设备信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addDeviceInit_others(){
		//构建溯源秤规格Map对象
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConftype(9);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机 6-耗材；7-计算机；8-读写卡器)
		List<DeviceConf> list = deviceConfDao.queryByList(deviceconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			DeviceConf deviceConf = (DeviceConf) iterator.next();
			map.put(deviceConf.getConfid(),deviceConf.getCompanyname() + "-" + deviceConf.getNormname());
			
		}
		form.setDeviceconfmap(map);
		return "addDeviceInit_others";
	}

	/**
	 * 保存其他设备信息
	 */
	@SuppressWarnings("unchecked")
	public String saveDevice_others(){
		form.setDevicetype(9);//设备类型(1-打印机；2-扫描设备；3-移动数据终端；5-查询机；6-耗材；7-计算机；8-读写卡器）
		
		if("".equals(form.getDevicecode())){
			form.setReturninfo("其他设备编码不能为空！");
			return addDeviceInit_others();
		}else{
			Device OldDevice = deviceDao.findByCode(form);
			if(OldDevice != null){
				form.setReturninfo("其他设备编码已经存在！");
				return addDeviceInit_others();
			}
		}
		form.setIp("");
		//扫描设备保存
		Integer deviceid = deviceDao.save(form);
		
		if(deviceid != null){
			form.setReturninfo("添加其他设备成功！");
		}else{
			form.setReturninfo("添加其他设备失败！");
		}
		
		//判断页面是否需要回收设备
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的设备
			Device oldDevice = new Device();
			oldDevice.setDeviceid(form.getRecdeviceid());
			oldDevice = deviceDao.findById(oldDevice);
			if(oldDevice != null){
				DeviceRec deviceRec = new DeviceRec();
				Tools.setVOToVO(oldDevice, deviceRec);
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除发放信息
				deviceDao.delete(oldDevice);
				//添加回收信息
				deviceRecDao.save(deviceRec);
			}
		}
		
		
		return addDeviceInit_others();
	}
	
	/**
	 * 回收其他设备信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String recoverDeviceInit_others(){
		//查询出将要修改的设备
		Device device = deviceDao.findById(form);
		DeviceConf deviceconf = new DeviceConf();
		deviceconf.setConfid(device.getConfid());
		deviceconf = deviceConfDao.findById(deviceconf);
		if(deviceconf != null){
			device.setNormname(deviceconf.getCompanyname() + "-" + deviceconf.getNormname());
		}
		form.setDevice(device);
		return "recoverDeviceInit_others";
	}
	
	/**
	 * 保存其他设备回收信息
	 */
	public String recoverDevice_others(){
		Device device = deviceDao.findById(form);
		if(device!=null){
			DeviceRec deviceRec = new DeviceRec();
			Tools.setVOToVO(device, deviceRec);
			deviceRec.setReason(form.getReason());//页面填写的回收原因
			deviceRec.setRemark(form.getRemark());//页面填写的回收备注信息
			//删除发放信息
			deviceDao.delete(device);
			//添加回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setDevicecode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList_others();
	}
	
	/**
	 * 检验设备编码是否存在
	 * @throws IOException 
	 */
	public void checkDeviceCode(){
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			Device device = deviceDao.findByCode(form);
			if(form.getDevicecode() == null || "".equals(form.getDevicecode())){
				out.print("编码不能为空！");
			} else if(device != null && !"".equals(form.getDevicecode().trim())){
				out.print("编码已经存在！");
			}else{
				out.print("");
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//选择企业列表
	public String companyChoice(){
		User user = (User) getSession().getAttribute("User");
		
		Org tepOrg = new Org();//查询所有单位的参数model
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				tepOrg.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		tepOrg.setState(1);//企业必须为审核企业
		tepOrg.setCardtype(form.getCardtype());
		tepOrg.setOrgname(form.getCorpname());
		tepOrg.setPager_openset(5);//一页显示5行
		tepOrg.setPager_offset(form.getPager_offset());
		form.setPager_count(orgDao.findByCount_companystate(tepOrg));
		List<Org> allOrgList = orgDao.findByList_companystate(tepOrg);
		if(allOrgList != null){
			for (Org orgTmp : allOrgList) {
				String marketcode = orgTmp.getMarketcode();
				if( marketcode!= null && !"".equals(marketcode)){
					Org orgPar = new Org();
					orgPar.setCpccorp(marketcode);
					List<Org> marketList = orgDao.findByCpccorp(orgPar);//查询此经商户的市场
					if(marketList != null && marketList.size() > 0){
						Org market = marketList.get(0);
						orgTmp.setMarketname(market.getOrgname());//将市场名称写入单位中
					}
				}
			}
		}
		
		form.setOrgList(allOrgList);
		return "companyChoice";
	}
	
	//选择秤企业列表
	public String chengCompanyChoice(){
		User user = (User) getSession().getAttribute("User");
		
		Org tepOrg = new Org();//查询所有单位的参数model
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				tepOrg.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		tepOrg.setState(1);//企业必须为审核企业
		tepOrg.setCardtype(form.getCardtype());
		tepOrg.setOrgname(form.getCorpname());
		tepOrg.setPager_openset(5);//一页显示5行
		tepOrg.setPager_offset(form.getPager_offset());
		form.setPager_count(orgDao.findByCount_companystate(tepOrg));
		List<Org> allOrgList = orgDao.findByList_companystate(tepOrg);
		if(allOrgList != null){
			for (Org orgTmp : allOrgList) {
				String marketcode = orgTmp.getMarketcode();
				if( marketcode!= null && !"".equals(marketcode)){
					Org orgPar = new Org();
					orgPar.setCpccorp(marketcode);
					List<Org> marketList = orgDao.findByCpccorp(orgPar);//查询此经商户的市场
					if(marketList != null && marketList.size() > 0){
						Org market = marketList.get(0);
						orgTmp.setMarketname(market.getOrgname());//将市场名称写入单位中
					}
				}
			}
		}
		
		form.setOrgList(allOrgList);
		return "chengCompanyChoice";
	}
	
	
	//选择设备列表
	public String deviceChoice(){
		form.setPager_openset(5);
		form.setPager_count(deviceDao.findByCount(form));
		List<Device> DeviceList = deviceDao.findByList(form);
		for (Device device : DeviceList) {
			DeviceConf deviceConf = new DeviceConf();
			deviceConf.setConfid(device.getConfid());
			deviceConf = deviceConfDao.findById(deviceConf);
			if(deviceConf != null){
				device.setNormname(deviceConf.getCompanyname()+"-"+deviceConf.getNormname());
			}
			
		}
		form.setDeviceList(DeviceList);
		return "deviceChoice";
	}
	
	public void saveOpLog(User user ,String method,String content){
		//记录操作日志
		OpLog opLog=new OpLog();
		if(user.getOrg()==null||user.getOrg().getZyctype().equals("00000010")){
			opLog.setSysid(7);
		}
		else if(user.getOrg().getZyctype().equals("10000000")){
			opLog.setSysid(1);
		}else if(user.getOrg().getZyctype().equals("01000000")){
			opLog.setSysid(2);
		}else if(user.getOrg().getZyctype().equals("00100000")){
			opLog.setSysid(4);
		}else if(user.getOrg().getZyctype().equals("00010000")){
			opLog.setSysid(5);
		}else if(user.getOrg().getZyctype().equals("00001000")){
			opLog.setSysid(3);
		}else if(user.getOrg().getZyctype().equals("00000100")){
			opLog.setSysid(6);
		}
		opLog.setMethod(method);
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent(content);
		opLogDao.saveOjbect(opLog);
	}
	
	public IDeviceDao getDeviceDao() {
		return deviceDao;
	}

	public void setDeviceDao(IDeviceDao deviceDao) {
		this.deviceDao = deviceDao;
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

	public IDeviceRecDao getDeviceRecDao() {
		return deviceRecDao;
	}

	public void setDeviceRecDao(IDeviceRecDao deviceRecDao) {
		this.deviceRecDao = deviceRecDao;
	}
	
}

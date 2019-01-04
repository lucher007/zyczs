package cn.gov.zyczs.cspt.action;

import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;



import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IMarketMapDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.MarketMap;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 市场区域图action
 * @author Administrator
 *
 */
public class MarketMapAction extends BaseAction implements ModelDriven<MarketMap> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private MarketMap form = new MarketMap();
	@Override
	public MarketMap getModel() {
		return form;
	}
	
	private IMarketMapDao  marketMapDao;//市场区域图dao
	public void setMarketMapDao(IMarketMapDao marketMapDao) {
		this.marketMapDao = marketMapDao;
	}
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	/**
	 * 查询市场区域楼
	 * @return
	 */
	public String findByList(){
		
		form.setPager_openset(10);
		form.setPager_count(marketMapDao.findByCount(form));
		List<MarketMap> list = marketMapDao.findByList(form);
		form.setList(list);
		return "findByList";
	}
	
	/**
	 * 保存市场的区和楼层
	 * @return
	 */
	public String save(){
		MarketMap temp = new MarketMap();
		temp.setCpccorp(form.getCpccorp());
		temp.setArea(form.getArea());
		List<MarketMap> list = marketMapDao.findExist(temp);
		Integer maxAreaNum;
		if(list != null && list.size() > 0){
			maxAreaNum = ((MarketMap)list.get(0)).getAreanum();
		}else{
			//查询该市场的当前最大区编号
			maxAreaNum = marketMapDao.findMaxareanum(form.getCpccorp());
		}
		MarketMap marketMap;
		/*for(int i = 0 ; i < form.getLayers() ; i++){
			marketMap = new MarketMap();
			marketMap.setArea(form.getArea());
			marketMap.setAreanum(maxAreaNum);
			marketMap.setFloor(String.valueOf(i+1));
			marketMap.setCpccorp(form.getCpccorp());
			marketMap.setFloornum(i+1);
			marketMapDao.save(marketMap);
		}*/
		marketMap = new MarketMap();
		marketMap.setArea(form.getArea().trim());
		marketMap.setAreanum(maxAreaNum);
		marketMap.setFloor(form.getFloor());
		marketMap.setCpccorp(form.getCpccorp());
		marketMap.setFloornum(Integer.parseInt(form.getFloor()));
		marketMapDao.save(marketMap);
		form.setArea(null);
		return findByList();
	}
	
	/**
	 * 保存上传文件
	 * 
	 * @return
	 * @throws IOException 
	 */
	public String saveObjectFile() throws IOException {
		int width=0;//图片的宽度
		int height=0;//图片的高度
		File importFile = null;
		importFile = form.getUploadify();
		User user = (User) getSession().getAttribute("User");
		
		if (importFile == null) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件为空!"));
			return SUCCESS;
		}
		if (form.getUploadifyFileName() == null || "".equals(form.getUploadifyFileName())) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件名为空!"));
			return SUCCESS;
		}
		String file_marketmap_path = ServletActionContext.getServletContext().getInitParameter("file_marketmap_path");
		if (file_marketmap_path == null || "".equals(file_marketmap_path)) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,存储路径为空!"));
			return SUCCESS;
		}
		if (((float) (Math.round(importFile.length() / 1024 * 100)) / 100) > 2000) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件最大为2M!"));
			return SUCCESS;
		}
		Image imgsrc = ImageIO.read(importFile);
		width = imgsrc.getWidth(null);
		height = imgsrc.getHeight(null);
		if(width < 712 || height < 405){
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,最佳分辨率为 712x405 像素!"));
			return SUCCESS;
		}
		String type = getStrend(form.getUploadifyFileName());
		StringBuffer filename = new StringBuffer(getNow()).append("_") ;
		
		//如果user为空,则代表为前台注册而来
		if(user == null){
			filename.append("register");
		}else{
			filename.append(user.getLoginname());
		}
		filename.append(".").append(type);
		
		//市场区域平面图上传附件信息
		MarketMap marketMap = new MarketMap();
		marketMap.setMapname(form.getUploadifyFileName());// .substring(0,form.getUploadifyFileName().indexOf(".")));
		marketMap.setMapcontent(file_marketmap_path + "/" + getDateMonthStr() + "/" + filename);
		marketMap.setImage(Tools.getBytesFromFile(form.getUploadify()));
		marketMap.setId(form.getId());
		
		Integer resultId =  marketMapDao.updateById(marketMap);
		if (resultId != null && resultId > 0) {
			MarketMap obj = marketMapDao.findByCondtion(marketMap).get(0);
			zyczsXmlDao.saveOjbect(ToolsXml.create_marketMap(obj,user));
			form.setMapname(marketMap.getMapname());
			form.setMapcontent(marketMap.getMapcontent());
			form.setReturninfo(upSuccessStr(marketMap.getMapname()));
		} else {
			form.setReturninfo("更新失败!");
		}
		return SUCCESS;
	}
	
	
	public String upErrorStr(String filename, String errorInfo) {
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;color:red;\">文件错误</div><div style=\"width:100px;height:80px;text-align:center;\">"
				+ filename + "<br style=\"clear:both;\" />" + errorInfo + "</div></div>";
	}

	public String upSuccessStr(String matname) {
		matname = matname.replaceAll(" ", "_");
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;\">上传文件</div><div style=\"width:100px;height:80px;text-align:center;overflow:hidden;\">"
				+ matname + "</div></div>";
	}

	public static String getDateMonthStr() {
		return (new SimpleDateFormat("yyyy-MM")).format(new Date());
	}

	public static String getStrend(String str) {
		String[] strVale = str.split("[.]");
		int Maxs = (strVale.length) - 1;

		str = strVale[Maxs];

		return str;
	}

	public static String getNow() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date());
	}
	
	/**
	 * 根据id查询平面图信息
	 * @return
	 */
	public String findByMaterial() {
		form.setList(marketMapDao.findByCondtion(form));
		return SUCCESS;
	}
	
	/**
	 * 根据id删除上传的图片信息实则是更新为空
	 * @return
	 */
	public String deleteMaterial() {
		form.setImage(null);
		form.setMapname(null);
		form.setMapcontent(null);
		marketMapDao.updateImage(form);
		return SUCCESS;
	}
	
	/**
	 * 根据cpc查询该市场有几区
	 * @return
	 */
	public String findMarketAreaByCpc(){
		form.setArealist(marketMapDao.findMarketAreaByCpc(form));
		return "findMarketAreaByCpc";
	}
	
	/**
	 * 根据cpc和所选区查询该市场有几层楼
	 * @return
	 */
	public String findMarketFloorByCpc(){
		form.setFloorlist(marketMapDao.findMarketFloorByCpc(form));
		return SUCCESS;
	}
	
	/**
	 * 根据cpc查询该市场有几区
	 * @return
	 */
	public String findMarketMapByCpc(){
		form.setArealist(marketMapDao.findMarketAreaByCpc(form));
		return "findMarketMapByCpc";
	}
	
	/**
	 * ajax判断区域名称是否注册
	 * @return
	 */
	public String findExist(){
		List<MarketMap> list = new ArrayList<MarketMap>();
		list = marketMapDao.findExist(form);
		if(list.size() > 0){
			form.setReturninfo("1");
		}else{
			form.setReturninfo("0");
		}
		return SUCCESS;
	}
	/**
	 * 修改区域楼层名称
	 * @return
	 */
	public String updateAreaFloor(){
		marketMapDao.updateAreaFloor(form);
		form.setArea(null);
		form.setId(null);
		form.setFloor(null);
		return findByList();
	}
	/**
	 * 删除市场楼层区域信息
	 * @return
	 */
	public String delMarketMap(){
		marketMapDao.delMarketMap(form);
		form.setId(null);
		return findByList();
	}
	
	/**
	 * 根据市场cpccorp查询该市场所有floor
	 * @return
	 */
	public String findFloorByCpc(){
		form.setList(marketMapDao.findFloorByCpc(form));
		return "findFloorByCpc";
	}
}

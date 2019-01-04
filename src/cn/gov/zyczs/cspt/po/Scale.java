package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤表  
 */
public class Scale implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3394593862375251625L;
	private Integer scaleid;                //
	private String scalecode;               //溯源秤号
	private String scalenorm;               //溯源秤规格
	private Integer scaleconfid;            //溯源秤配置表id
	private Integer scalestate;             //溯源秤状态0表示可用，1表示不可用
	private String usercode;                //经营户id
	private String addtime;                 //添加时间
	private String picurl;                  //图片连接地址
	
	private String userName;                //商户名称
	
	private Integer locked;                 //是否锁定
	private Long keyver;                    //快捷键版本
	private Long pluver;                    //plu的版本
	private Integer comlocked;              //命令锁定溯源秤0，不锁定，1是锁定
	private Long compluver;                 //命令更新为指定版本
	private Integer comkeyver;              //命令更新快捷键
	private Long differtime;                //相差时间
    private String returninfo;
	//分页参数
	private int pager_count;                //总数目
	private int pager_offset;               //当页第一行的序号
	private int pager_openset;              //当页显示个数
	private List<Scale> scaleList;          //溯源秤集合
	private Scale scale;		            //溯源秤对象
	private Map<Integer,String> scaleConfMap; //溯源秤规格配置Map
	
	private List<ScaleKeyConf> keyConfList;  //溯源秤键对象集合
	private ScaleConf scaleConf;		     //溯源秤规格配置对象
	private Scalefck scalefck;		         //溯源秤 快捷键
	private List<Scalefck> scalefckList;     //溯源秤键对象集合
	private List<String> strList;
	private List<MedBase> medBaseList;       //植物集合
	private String keyString;                //溯源秤键配置 横纵坐标值拼接  -x(横坐标),y(纵坐标)
	private String keyMap;                   //溯源秤键配置 横纵坐标值拼接  -x(横坐标),y(纵坐标)@v(value)
	
	/**
	 * 
	 */
	public Scale() {
		super();
	}

	/**
	 * @param scaleid
	 * @param scalecode
	 * @param scalenorm
	 * @param scaleconfid
	 * @param scalestate
	 * @param usercode
	 * @param addtime
	 * @param picurl
	 * @param userName
	 * @param locked
	 * @param keyver
	 * @param comlocked
	 * @param compluver
	 * @param comkeyver
	 * @param differtime
	 * @param returninfo
	 * @param pager_count
	 * @param pager_offset
	 * @param pager_openset
	 * @param scaleList
	 * @param scale
	 * @param scaleConfMap
	 * @param keyConfList
	 * @param scaleConf
	 * @param scalefck
	 * @param scalefckList
	 * @param strList
	 * @param medBaseList
	 * @param keyString
	 * @param keyMap
	 */
	public Scale(Integer scaleid, String scalecode, String scalenorm,
			Integer scaleconfid, Integer scalestate, String usercode,
			String addtime, String picurl, String userName, Integer locked,
			Long keyver, Integer comlocked, Long compluver, Integer comkeyver,
			Long differtime, String returninfo, int pager_count,
			int pager_offset, int pager_openset, List<Scale> scaleList,
			Scale scale, Map<Integer, String> scaleConfMap,
			List<ScaleKeyConf> keyConfList, ScaleConf scaleConf,
			Scalefck scalefck, List<Scalefck> scalefckList,
			List<String> strList, List<MedBase> medBaseList, String keyString,
			String keyMap) {
		super();
		this.scaleid = scaleid;
		this.scalecode = scalecode;
		this.scalenorm = scalenorm;
		this.scaleconfid = scaleconfid;
		this.scalestate = scalestate;
		this.usercode = usercode;
		this.addtime = addtime;
		this.picurl = picurl;
		this.userName = userName;
		this.locked = locked;
		this.keyver = keyver;
		this.comlocked = comlocked;
		this.compluver = compluver;
		this.comkeyver = comkeyver;
		this.differtime = differtime;
		this.returninfo = returninfo;
		this.pager_count = pager_count;
		this.pager_offset = pager_offset;
		this.pager_openset = pager_openset;
		this.scaleList = scaleList;
		this.scale = scale;
		this.scaleConfMap = scaleConfMap;
		this.keyConfList = keyConfList;
		this.scaleConf = scaleConf;
		this.scalefck = scalefck;
		this.scalefckList = scalefckList;
		this.strList = strList;
		this.medBaseList = medBaseList;
		this.keyString = keyString;
		this.keyMap = keyMap;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAddtime() {
		if(addtime == null || addtime.length() < 10){
			return null;
		}else{
			addtime	= addtime.substring(0,10);
		}
		return addtime;
	}

	public List<Scalefck> getScalefckList() {
		return scalefckList;
	}

	public void setScalefckList(List<Scalefck> scalefckList) {
		this.scalefckList = scalefckList;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	public Scalefck getScalefck() {
		return scalefck;
	}

	public void setScalefck(Scalefck scalefck) {
		this.scalefck = scalefck;
	}

	public List<ScaleKeyConf> getKeyConfList() {
		return keyConfList;
	}

	public void setKeyConfList(List<ScaleKeyConf> keyConfList) {
		this.keyConfList = keyConfList;
	}

	public ScaleConf getScaleConf() {
		return scaleConf;
	}

	public void setScaleConf(ScaleConf scaleConf) {
		this.scaleConf = scaleConf;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Map<Integer, String> getScaleConfMap() {
		return scaleConfMap;
	}

	public void setScaleConfMap(Map<Integer, String> scaleConfMap) {
		this.scaleConfMap = scaleConfMap;
	}

	public Integer getScaleid() {
		return scaleid;
	}
	public void setScaleid(Integer scaleid) {
		this.scaleid = scaleid;
	}
	public String getScalecode() {
		return scalecode;
	}
	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}
	public String getScalenorm() {
		return scalenorm;
	}
	public void setScalenorm(String scalenorm) {
		this.scalenorm = scalenorm;
	}
	public Integer getScaleconfid() {
		return scaleconfid;
	}
	public void setScaleconfid(Integer scaleconfid) {
		this.scaleconfid = scaleconfid;
	}
	public Integer getScalestate() {
		return scalestate;
	}
	public void setScalestate(Integer scalestate) {
		this.scalestate = scalestate;
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pager_count) {
		this.pager_count = pager_count;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pager_offset) {
		this.pager_offset = pager_offset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pager_openset) {
		this.pager_openset = pager_openset;
	}
	public List<Scale> getScaleList() {
		return scaleList;
	}
	public void setScaleList(List<Scale> scaleList) {
		this.scaleList = scaleList;
	}
	public Scale getScale() {
		return scale;
	}
	public void setScale(Scale scale) {
		this.scale = scale;
	}

	public Integer getLocked() {
		return locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	public Long getKeyver() {
		return keyver;
	}

	public void setKeyver(Long keyver) {
		this.keyver = keyver;
	}

	public Integer getComlocked() {
		return comlocked;
	}

	public void setComlocked(Integer comlocked) {
		this.comlocked = comlocked;
	}

	public Long getCompluver() {
		return compluver;
	}

	public void setCompluver(Long compluver) {
		this.compluver = compluver;
	}

	public Integer getComkeyver() {
		return comkeyver;
	}

	public void setComkeyver(Integer comkeyver) {
		this.comkeyver = comkeyver;
	}

	public Long getDiffertime() {
		if (differtime == null) {
			return differtime = 2l;
		}
		if (differtime < 15 && differtime >= 0) {
			return differtime = 1l;
		} else {
			return differtime = 2l;
		}
	}

	public void setDiffertime(Long differtime) {
		this.differtime = differtime;
	}

	public List<String> getStrList() {
		return strList;
	}

	public void setStrList(List<String> strList) {
		this.strList = strList;
	}

	public List<MedBase> getMedBaseList() {
		return medBaseList;
	}

	public void setMedBaseList(List<MedBase> medBaseList) {
		this.medBaseList = medBaseList;
	}

	public String getKeyString() {
		return keyString;
	}

	public void setKeyString(String keyString) {
		this.keyString = keyString;
	}

	public String getKeyMap() {
		return keyMap;
	}

	public void setKeyMap(String keyMap) {
		this.keyMap = keyMap;
	}

	public String getReturninfo() {
		return returninfo;
	}

	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}

	public Long getPluver() {
		return pluver;
	}

	public void setPluver(Long pluver) {
		this.pluver = pluver;
	}
	
}

package cn.gov.zyczs.cspt.common;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengFck;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.Org;
public class ToolSql {
	
	/**
	 * 新增秤
	 */
	public static String addChengSql(Cheng cheng){
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into scalestat (SCALECODE,STAT,LOCKED,PLUVER,KEYVER,MODE,IP) values(");
		sql.append(" '").append(cheng.getChengcode()).append("',");
		sql.append(cheng.getState()).append(",");
		sql.append(cheng.getLocked()).append(",");
		sql.append(" NOW(), ");
		sql.append(" NOW(), ");
		sql.append(cheng.getChengmode()).append(",");
		sql.append(" '").append(cheng.getIp()).append("'");
		sql.append(" ) ");
		
		System.out.println("----秤中间件---addChengSql=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 删除秤
	 */
	public static String deleteChengSql(Cheng cheng){
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from scalestat where SCALECODE =");
		sql.append(" '").append(cheng.getChengcode()).append("'");
		
		System.out.println("----秤中间件---deleteChengSql=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 新增秤快捷键
	 */
	public static String addChengFckSql(ChengFck chengFck){
		StringBuffer sql = new StringBuffer();
		sql.append(" insert into scalefck (SCALECODE,FCKCODE,PLUCODES,FCKVER) values(");
		sql.append(" '").append(chengFck.getChengcode()).append("',");
		sql.append(" '").append(chengFck.getKeyvalue()).append("',");
		sql.append(" '").append(chengFck.getPlucodes()).append("',");
		sql.append(" NOW()");
		sql.append(" ) ");
		
		System.out.println("----秤中间件---addChengFckSql=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 删除秤快捷键
	 */
	public static String deleteChengFckSql(ChengFck chengFck){
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from scalefck where SCALECODE =");
		sql.append(" '").append(chengFck.getChengcode()).append("'");
		sql.append(" and FCKCODE =");
		sql.append(" '").append(chengFck.getKeyvalue()).append("'");
		System.out.println("----秤中间件---deleteChengFckSql=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 删除秤所有的快捷键
	 */
	public static String deleteChengAllFckSql(ChengFck chengFck){
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from scalefck where SCALECODE =");
		sql.append(" '").append(chengFck.getChengcode()).append("'");
		System.out.println("----秤中间件---deleteChengAllFckSql=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 发送锁秤/解锁指令操作
	 */
	public static String updateChengLocked(Cheng cheng){
		StringBuffer sql = new StringBuffer();
		sql.append(" update scalestat set LOCKED = ");
		sql.append(cheng.getLocked());
		sql.append(" where SCALECODE = ");
		sql.append(" '").append(cheng.getChengcode()).append("'");
		
		System.out.println("----秤中间件---updateChengLocked=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 发送工作模式变更指令
	 */
	public static String updateChengMode(Cheng cheng){
		StringBuffer sql = new StringBuffer();
		sql.append(" update scalestat set MODE = ");
		sql.append(cheng.getChengmode());
		sql.append(" where SCALECODE = ");
		sql.append(" '").append(cheng.getChengcode()).append("'");
		
		System.out.println("----秤中间件---updateChengMode=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 修改秤快捷键版本时间
	 */
	public static String updateChengKeyVer(Cheng cheng){
		StringBuffer sql = new StringBuffer();
		sql.append(" update scalestat set KEYVER = NOW()");
		sql.append(" where SCALECODE = ");
		sql.append(" '").append(cheng.getChengcode()).append("'");
		
		System.out.println("----秤中间件---updateChengKeyVer=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 变更溯源秤的库存量
	 */
	public static String updateMedStroage(MedStorage storage){
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT storage (CPCCODE, COMMODITYCODE, MEDCPC, STORAGE) values (");
		sql.append(" '").append(storage.getCpccorp()).append("',");
		sql.append(" '").append(storage.getProdcode().substring(10, 19)).append("',");
		sql.append(" '").append(storage.getCpcmed()).append("',");
		sql.append(storage.getMedweight()/10000);
		sql.append(" ) ON DUPLICATE KEY UPDATE STORAGE =");
		sql.append(storage.getMedweight()/10000);
		
		System.out.println("----秤中间件---updateMedStroage=\n"+sql.toString());
		return sql.toString();
	}
	
	/**
	 * 根据溯源秤厂商数值取名称
	 */
	public static String getCompanyNameByKey(String companyKey){
		String companyName = "";
		String companys = ServletActionContext.getServletContext().getInitParameter("cheng_company");
		if(companys != null){
			String[] companyArr = companys.split(",");
			if(companyArr!=null){
				for(int i=0;i<companyArr.length;i++){
					String company = companyArr[i];
					String[] valueArr = company.split("-");
					if(valueArr != null && valueArr.length==2){
						if(companyKey.equals(valueArr[0])){
							companyName = valueArr[1];
							break;
						}
					}
				}
			}
		}
		return companyName;
	}
	
	/**
	 * 获取秤当前平台的工作模式(从web.xml中获取)
	 */
	public static Integer getChengModeFromXml(){
		Integer chengmode = 1;//默认为1(松管理模式)
		String chengmodes = ServletActionContext.getServletContext().getInitParameter("cheng_mode");
		//判断web.xml中是否配置了该工作模式，如果配置了，就取出来当做当前系统秤的工作模式
		if(chengmodes != null && !"".equals(chengmodes)){
			chengmode = Integer.valueOf(chengmodes);
		}
		return chengmode;
	}
	
	/**
	 * 获取XML中配置的信息(从web.xml中获取)
	 */
	public static String getXmlValueFromKey(String xml_key){
		String xml_value = ServletActionContext.getServletContext().getInitParameter(xml_key);
		//判断web.xml中是否配置了该KEY值，如果没配置，就默认为""
		if(xml_value == null){
			xml_value = "";
		}
		return xml_value;
	}
	
	/**
	 * 组装IC卡XML信息
	 */
	public static String getSendCardXml(Org org){
		String method="";
    	method+="<?xml version=\"1.0\" encoding=\"utf-8\"?>"; 
		method += "<cpc>";
		method += "<operatetype>corpinfo</operatetype>";
		method += "<operatecode>update</operatecode>";
		method += "<operatename>"+ServletActionContext.getServletContext().getInitParameter("operatename")+"</operatename>";
		method += "<operatepwd>"+ServletActionContext.getServletContext().getInitParameter("operatepwd")+"</operatepwd>";
		method += "<operadata>";
		
		method += "<corpcpccode>"+org.getCpccorp()+"</corpcpccode>";
		method += "<zyctype>"+org.getZyctype()+"</zyctype>";
		
		method += "<corpname>"+org.getOrgname()+"</corpname>";
		method += "<corpshortname>"+org.getOrgshortname()+"</corpshortname>";
		
		method += "<linkman>"+org.getLinkman()+"</linkman>";
		method += "<master>"+org.getMasterman()+"</master>";
		method += "<identitycard>"+org.getIdentitycard()+"</identitycard>";
		
		method += "<orgcode>"+org.getOrgcode()+"</orgcode>";
		method += "<businesscode>"+org.getBusinesscode()+"</businesscode>";		
		method += "<mobile>"+org.getMobile()+"</mobile>";
		method += "<telephone>"+org.getTelephone()+"</telephone>";
		method += "<officephone>"+org.getOfficephone()+"</officephone>";
		method += "<email>"+org.getEmail()+"</email>";
		method += "<postcode>"+org.getPostcode()+"</postcode>";
		
		method += "<gapcode>"+org.getGapcode()+"</gapcode>";
		method += "<gmpcode>"+org.getGmpcode()+"</gmpcode>";
		method += "<gspcode>"+org.getGspcode()+"</gspcode>";
		method += "<sendcard>"+org.getSendcard()+"</sendcard>";
		method += "<marketcode>"+org.getMarketcode()+"</marketcode>";
		method += "<businessnumber>"+org.getBusinessnumber()+"</businessnumber>";
		method += "<zscnumber></zscnumber>";
		method += "<area>"+org.getAreacode()+"</area>";
		method += "<registeraddress>"+org.getRegisteraddress()+"</registeraddress>";	
		method += "</operadata>";
		method += "</cpc>";
		System.out.println("---------------组装IC卡XML信息=---------------\n"+method);
		return method;
	}
	
	/**
	 * 根据位数，自动填充
	 * length 总位数
	 * str 字符串
	 * val 需要填充的值
	 * 
	 */
	public static String getString(int length, String str, String val){
		
		if(str == null){//如果字符串为空，那就默认为""
			str = "";
		}
		
		if(val == null){//如果需要填充的值为空，那就自动填充0
			val = "0";
		}
		
		String tempStr = str;
		
		for(int i = 0;i<length-str.length();i++){
			tempStr = val + tempStr;
		}
		
		return tempStr;
		
	}
}

package cn.gov.zyczs.cspt.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ToolsValid {

	public static void main(String[] args){
		String str="~324";
		System.out.println(ToolsValid.checkquotmarks(str));
	}
	/**
	 * 判断是否为null
	 * @param obj
	 */
	public static boolean checkNull(Object o){
		if(o==null){
			return false;
		}else{
			return true;
		}
	}
	
	public static String checkString(String str){
		String fString = str;
		fString = fString.replaceAll("<", "&lt;");
		fString = fString.replaceAll(">", "&gt;");
		fString = fString.replaceAll("'", "&#39;");
		fString = fString.replaceAll("\"", "&#34;");
		fString = fString.replaceAll("-", "&#45;");
		fString = fString.replaceAll("%", "&#37;");
		fString = fString.replaceAll(";", "&#59;");
		fString = fString.replaceAll("(", "&#40;");
		fString = fString.replaceAll("(", "&#41;");
		fString = fString.replaceAll("&", "&amp;");
		fString = fString.replaceAll("+", "&#43;");
		return fString;
	}
	
	public static String checkStringSpace(String str){
		System.out.println(str);
		String fString = java.net.URLDecoder.decode(str);
		System.out.println(str);
		fString = fString.replaceAll("<", " ");
		fString = fString.replaceAll(">", " ");
		fString = fString.replaceAll("\'", " ");
		fString = fString.replaceAll("\"", " ");
		fString = fString.replaceAll("\\-", " ");
		fString = fString.replaceAll("\\%", " ");
		fString = fString.replaceAll("\\;", " ");
		fString = fString.replaceAll("\\(", " ");
		fString = fString.replaceAll("\\)", " ");
		fString = fString.replaceAll("\\&", " ");
		fString = fString.replaceAll("\\+", " ");
		fString = fString.replaceAll("\\/", " ");
		fString = fString.replaceAll("\\.", " ");
		fString = fString.replaceAll("\\#", " ");
		return fString;
	}
	
	/**
	 * 只能输入长度为length的整数
	 * @param length
	 */
	public static boolean checkInteger(int length,Object obj){
		  boolean flag = true;
		  if(obj != null){
			  Pattern pt = Pattern.compile("^\\d{"+length+"}?$");
			  Matcher mt = pt.matcher(obj.toString());
			  flag = mt.matches();
		  }
		  return flag;
	}
	
	/**
	 * 只能输入小数,范围在start到end之间
	 * @param start
	 * @param end
	 * @param obj
	 */
	public static boolean checkDecimals(Object obj,int start,int end){
		  boolean flag = true;
		  if(obj != null){
			  Pattern pt = Pattern.compile("^\\d*\\.\\d{"+start+","+end+"}?$");
			  Matcher mt = pt.matcher(obj.toString());
			  flag = mt.matches();
		  }
		  return flag;
	}
	
	/**
	 * 判断输入字符合法性
	 * @param obj
	 */
	public static boolean checkquotmarks(Object obj){
		 boolean flag = true;
		 if(obj != null){
			 String[] names = (String[])obj;
			 System.out.println(names[0].toString());
			 Pattern pt = Pattern.compile("[\\·\\'\\\"\\~\\`\\@\\#\\$\\%\\^\\&\\*\\|\\(\\)\\{\\}\\[\\]\\+\\=\\;\\?\\<\\>\\,\\/\\\\]");
			 Matcher mt = pt.matcher(names[0].toString());
			 flag = mt.find();
		  }
		  return flag;
	}

	
	/**
	 * 检验时间是否合法
	 * @param obj
	 */
	public static boolean checkDate(Object obj){
		    boolean flag = true;
			if(obj != null){
				String date = obj.toString();
				if(date.length() == 10){
					 Pattern pt = Pattern.compile("^((\\d{2}(([02468][048])|([13579][26]))[\\-\\-\\s]?((((0?" +"[13578])|(1[02]))[\\-\\-\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))" +"|(((0?[469])|(11))[\\-\\-\\s]?((0?[1-9])|([1-2][0-9])|(30)))|" +"(0?2[\\-\\-\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][12" +"35679])|([13579][01345789]))[\\-\\-\\s]?((((0?[13578])|(1[02]))" +"[\\-\\-\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))" +"[\\-\\-\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\-\\s]?((0?[" +"1-9])|(1[0-9])|(2[0-8]))))))");
					 Matcher mt = pt.matcher(obj.toString());
					 flag = mt.matches();
				}else if(date.length() == 19){
					Pattern pt = Pattern.compile("^(\\d{1,4})(-|\\/)(\\d{1,2})\\2(\\d{1,2}) (\\d{1,2}):(\\d{1,2}):(\\d{1,2})$");
					 Matcher mt = pt.matcher(obj.toString());
					 flag = mt.matches();
				}
			}
			return flag;
	}
}

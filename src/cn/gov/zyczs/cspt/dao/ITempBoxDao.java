package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.TempBox;

public interface ITempBoxDao {
	
	Integer saveTempBoxBatch(final List<InStorSuccessCode> succList);
	
	public Integer updateTempBoxBatch(final List<InStorSuccessCode> succList);
	
	TempBox findTempBoxByCode(String boxcode);
	
	boolean checkExsit(List<InStorSuccessCode> succList);
	
	boolean checkStateExsit(List<InStorSuccessCode> succList);
	

}

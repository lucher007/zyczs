package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.TabletBase;
import cn.gov.zyczs.cspt.po.ZyczsXml;

public interface IZyczsXmlDao {
	public void saveOjbect(ZyczsXml zyczsXml);
	
//	public Integer deleteById(String guid);
	
	public List<ZyczsXml> findByList();
}

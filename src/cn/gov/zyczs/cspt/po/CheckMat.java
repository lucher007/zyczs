package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

/**
 * 检验报告实体类
 *
 */
public class CheckMat implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer matid;// 主键 自增列
	private String matname;// 用户上传本地文件名
	private String matcontent;// 上传文件服务器端文件名
	private Integer mattype;// 1药材检验报告 2饮片检验报告 3药材产地证明
	private String mataddtime;// 上传时间
	private Integer orgid;    //组织ID
	private Integer prodid;//药材检验保存medstorage表的id；饮片检验保存tablet表的id
    private Integer type;  //检验类型:0药材;1饮片
    private byte[] matimage; //上传文件流
    
	public Integer getMatid() {
		return matid;
	}

	public void setMatid(Integer matid) {
		this.matid = matid;
	}

	public String getMatname() {
		return matname;
	}

	public void setMatname(String matname) {
		this.matname = matname;
	}

	public String getMatcontent() {
		return matcontent;
	}

	public void setMatcontent(String matcontent) {
		this.matcontent = matcontent;
	}

	public Integer getMattype() {
		return mattype;
	}

	public void setMattype(Integer mattype) {
		this.mattype = mattype;
	}

	public String getMataddtime() {
		return mataddtime;
	}

	public void setMataddtime(String mataddtime) {
		this.mataddtime = mataddtime;
	}

	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}

	public Integer getProdid() {
		return prodid;
	}

	public void setProdid(Integer prodid) {
		this.prodid = prodid;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public byte[] getMatimage() {
		return matimage;
	}

	public void setMatimage(byte[] matimage) {
		this.matimage = matimage;
	}
	
}

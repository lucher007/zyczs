package cn.gov.zyczs.cspt.dao;
import java.util.List;

import cn.gov.zyczs.cspt.po.OrgUpload;

/**
 * 企业组织注册上传附件接口
 * @author Administrator
 *
 */
public interface IOrgUploadDao {
	
	/**
	 * 企业组织注册上传附件
	 * @param OrgUpload
	 * 企业组织注册上传实体类
	 * @return 返回当前信息的ID
	 */
	public Integer save(OrgUpload orgupload);
	
	/**
	 * 查询企业组织上传的附件
	 * @param orgupload
	 * @return
	 */
	public List<OrgUpload> findByCondtion(OrgUpload orgupload);
	
	
	/**
	 * 查询企业组织上传的附件
	 * @param orgupload
	 * @return
	 */
	public Integer deleteObj(OrgUpload orgUpload);
	
	/**
	 * 根据id查询图片刘
	 * @param uploadcontent
	 * @return
	 */
	public OrgUpload findByIdUploadImage(String uploadcontent);
	
	/**
	 * 根据id更新
	 * @param ids
	 * @return
	 */
	public Integer updateByIds(OrgUpload orgUpload);
	/**
	 * 查询服务器端文件名
	 * @param orgUpload
	 * @return
	 */
	public List<OrgUpload> findUploadContent(OrgUpload orgUpload);
	/**
	 * 查询服务器端文件名
	 * @param orgUpload
	 * @return
	 */
	public List<OrgUpload> findByUploadids(OrgUpload orgUpload);
	
	/**
	 * 根据页面tokenid值和附件类型(0企业 1组织)
	 * @param orgUpload
	 * @return
	 */
	public Integer updateByTokenIdAndType(OrgUpload orgUpload);
	
	/**
	 * 根据tokenid和附件类型(0企业 1组织)
	 * @param orgUpload
	 * @return
	 */
	public List<OrgUpload> findByTokenIdAndType(OrgUpload orgUpload);
	
	/**
	 * 根据uploadid修改手持机pic信息
	 * @param orgUpload
	 * @return
	 */
	public Integer updateByUploadId(OrgUpload orgUpload);
	
}

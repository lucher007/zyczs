package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.ITempBoxDao;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.TempBox;
import cn.gov.zyczs.cspt.po.User;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class TempBoxDao extends SqlMapClientDaoSupport implements ITempBoxDao{

	
	public Integer saveTempBoxBatch(final List<InStorSuccessCode> succList) {
		SqlMapClientCallback callback = new SqlMapClientCallback() {          
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
            	User user = (User)ServletActionContext.getRequest().getSession().getAttribute("User");
            	Integer flag = 0; 
                executor.startBatch();
                for (int i = 0 ;i<succList.size();i++) {
                	InStorSuccessCode vo=succList.get(i);  
                	vo.setOrgid(user.getOrgid());
                	
                    executor.insert("TempBox.saveTempBox",vo);
                    if((i+1)%10==0){
                    	executor.executeBatch(); 
                    	executor.startBatch();
                    }
                    flag++;
                }
                executor.executeBatch();                 
                return flag;          
            }
        }; 
        return (Integer)this.getSqlMapClientTemplate().execute(callback);			
	}
	
	
	
	@Override
	public TempBox findTempBoxByCode(String boxcode) {
		User user = (User)ServletActionContext.getRequest().getSession().getAttribute("User");
		
		Map map=new HashMap();
		map.put("boxcode", boxcode);
		map.put("orgid", user.getOrgid());
		
		return (TempBox)getSqlMapClientTemplate().queryForObject("TempBox.findTempBoxByCode",map);
	}
	
	public Integer updateTempBoxBatch(final List<InStorSuccessCode> succList) {
		SqlMapClientCallback callback = new SqlMapClientCallback() {          
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
            	User user = (User)ServletActionContext.getRequest().getSession().getAttribute("User");
            	Integer flag = 0; 
                executor.startBatch();
                String currTime=Tools.getCurrentTime();                             
                for (int i = 0 ;i<succList.size();i++) {
                	InStorSuccessCode vo=succList.get(i);  
                	vo.setLasttime(currTime);
                	vo.setOrgid(user.getOrgid());
                    executor.update("TempBox.updateByCode",vo);
                    if((i+1)%10==0){
                    	executor.executeBatch(); 
                    	executor.startBatch();
                    }
                    flag++;
                }
                executor.executeBatch();                 
                return flag;          
            }
        }; 
        return (Integer)this.getSqlMapClientTemplate().execute(callback);			
	}

	/*
	 * 
	 *判断溯源码是否存在
	 */
	@Override
	public boolean checkExsit(List<InStorSuccessCode> succList) {
		boolean flag=true;
		for(InStorSuccessCode code:succList)
		{
			TempBox cvo=this.findTempBoxByCode(code.getCode());
			if(cvo==null)
			{
				flag=false;
				break;
			}			
		}		
		return flag;
	}
	/*
	 * 
	 * 判断溯源码入库状态
	 */
	@Override
	public boolean checkStateExsit(List<InStorSuccessCode> succList) {
		boolean flag=true;
		for(InStorSuccessCode code:succList)
		{
			TempBox cvo=this.findTempBoxByCode(code.getCode());
			//时间戳是否相等
			if(cvo!=null&&!code.getLasttime().equals(cvo.getTimestamp()))
			{
				flag=false;
				break;
			}
		}
		
		return flag;
	}

}

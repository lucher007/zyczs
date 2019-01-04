package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.ITabletAssistDao;
import cn.gov.zyczs.cspt.po.TabletAssist;

import com.ibatis.sqlmap.client.SqlMapExecutor;

/**
 * @Title TabletAssistDao.java
 * @version 1.0 
 * 饮片生产-- 辅料表 dao实现类
 */
public class TabletAssistDao extends SqlMapClientDaoSupport implements ITabletAssistDao{
	
	public Integer saveTabletAssistBatch(final List<TabletAssist> phonelist,final Integer tabletid) {
		SqlMapClientCallback callback = new SqlMapClientCallback() {          
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
            	Integer flag = 0; 
                executor.startBatch();
                for (int i = 0 ;i<phonelist.size();i++) {
                	TabletAssist vo=phonelist.get(i);
                	if(vo!=null){
                		vo.setTabletid(tabletid);
                    	vo.setAssistweight(String.valueOf(Tools.multiply(vo.getAssistweight(), "10")));                	
                        executor.insert("TabletAssist.saveAssist",vo);
                        if((i+1)%10==0){
                        	executor.executeBatch(); 
                        	executor.startBatch();
                        }
                        flag++;
                	}
                	
                }
                executor.executeBatch();                 
                return flag;          
            }
        }; 
        return (Integer)this.getSqlMapClientTemplate().execute(callback);			
	}
	
	@SuppressWarnings("unchecked")
	public List<TabletAssist> findByTablet(Integer tabletid) {
		return (List<TabletAssist>)getSqlMapClientTemplate().queryForList("TabletAssist.findByTablet",tabletid);
	}

}

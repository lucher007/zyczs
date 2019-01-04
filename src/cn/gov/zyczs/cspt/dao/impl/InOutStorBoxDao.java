package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.BoxItem;
import cn.gov.zyczs.cspt.po.InOutStorBox;

import com.ibatis.sqlmap.client.SqlMapExecutor;
/**
 * @Title InOutStorageDao.java
 * @version 1.0 
 * 出入库记录dao实现类
 */
public class InOutStorBoxDao extends SqlMapClientDaoSupport implements IInOutStorBoxDao {

	@Override
	public Integer findBoxCount(InOutStorBox inOutStorbox) {
		return (Integer) getSqlMapClientTemplate().queryForObject("InOutStorBox.findBoxCount",inOutStorbox);
	}

	@Override
	public InOutStorBox findById(InOutStorBox inOutStorBox) {
		return (InOutStorBox)getSqlMapClientTemplate().queryForObject("InOutStorBox.findById",inOutStorBox);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InOutStorBox> findBoxList(InOutStorBox inOutStorBox) {
		return (List<InOutStorBox>) getSqlMapClientTemplate().queryForList("InOutStorBox.findBoxList",inOutStorBox);
	}

	@Override
	public Integer save(InOutStorBox inOutStorBox) {
		return (Integer) getSqlMapClientTemplate().insert("InOutStorBox.save",inOutStorBox);
	}
	
	@Override
	public Integer saveBatch(final List<InOutStorBox> storboxlist,final Integer inoutstorid) {
		SqlMapClientCallback callback = new SqlMapClientCallback() {          
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
            	Integer flag = 0; 
                executor.startBatch();
                for (int i = 0 ;i<storboxlist.size();i++) {
                	InOutStorBox vo=storboxlist.get(i);
                	vo.setInoutstorid(inoutstorid);              	
                    executor.insert("InOutStorBox.save",vo);
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
	public Integer findItemCount(InOutStorBox inOutStorBox) {
		return (Integer) getSqlMapClientTemplate().queryForObject("InOutStorBox.findItemCount",inOutStorBox);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Box> findItemList(InOutStorBox inOutStorBox) {
		return (List<Box>)getSqlMapClientTemplate().queryForList("InOutStorBox.findItemList",inOutStorBox);
	}
}

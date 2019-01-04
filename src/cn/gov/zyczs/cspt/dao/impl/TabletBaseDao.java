package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.ITabletBaseDao;
import cn.gov.zyczs.cspt.po.TabletBase;
import cn.gov.zyczs.cspt.po.TabletBaseOrg;

import com.ibatis.sqlmap.client.SqlMapExecutor;


/**
 * @Title PlantDao.java
 * @version 1.0 
 * 饮片基础表dao实现类
 */
public class TabletBaseDao extends SqlMapClientDaoSupport implements ITabletBaseDao{
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TabletBase> findByList(TabletBase tabletBase) {
		return (List<TabletBase>)getSqlMapClientTemplate().queryForList("TabletBase.findByList",tabletBase);
	}
	
	@Override
	public Integer findByCount(TabletBase tabletBase) {
		return (Integer)getSqlMapClientTemplate().queryForObject("TabletBase.findByCount",tabletBase);
	}

//	@Override
//	public TabletBase checkExsit(TabletBase tabletBase) {
//		return (TabletBase) getSqlMapClientTemplate().queryForObject("TabletBase.checkExsit", tabletBase);
//	}

	@Override
	public Integer deleteByBaseOrg(TabletBaseOrg baseorg) {
		return (Integer) getSqlMapClientTemplate().update("TabletBase.deleteByBaseOrg", baseorg);
	}

	@Override
	public TabletBase findById(Integer id) {
		return (TabletBase) getSqlMapClientTemplate().queryForObject("TabletBase.findById", id);
	}
	
	public Integer saveBaseOrgBatch(final String[] baseorg,final Integer orgid) {
		SqlMapClientCallback callback = new SqlMapClientCallback() {          
            public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
            	Integer flag = 0; 
                executor.startBatch();
                for (int i = 0 ;i<baseorg.length;i++) {
                	
                	if(Tools.dealNullInt(baseorg[i], -99)!=-99){
                		TabletBaseOrg vo=new TabletBaseOrg();                   	
                    	vo.setBaseid(Integer.parseInt(baseorg[i]));
                    	vo.setOrgid(orgid);
                    	 executor.insert("TabletBase.save",vo);
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
	@Override
	public List<TabletBase> findByList_Kiosks() {
		return (List<TabletBase>)getSqlMapClientTemplate().queryForList("TabletBase.findByList_Kiosks");
	}

//	@Override
//	public Integer save(TabletBase tabletBase) {
//		return (Integer) getSqlMapClientTemplate().insert("TabletBase.save", tabletBase);
//	}

//	@Override
//	public Integer updateObject(TabletBase tabletBase) {
//		return (Integer) getSqlMapClientTemplate().delete("TabletBase.updateById", tabletBase);
//	}

}

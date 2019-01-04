package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IIndexUserDao;
import cn.gov.zyczs.cspt.po.IndexUser;

import com.ibatis.sqlmap.client.SqlMapExecutor;

/**
 * @Title IndexUserDao.java
 * @Package com.dao.impl
 * @version 1.0 
 */
public class IndexUserDao extends SqlMapClientDaoSupport  implements IIndexUserDao {

	public int saveIndexUser(final List<IndexUser> indexUsers) {
		//执行回调
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback(){
			//实现回调接口
			public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException{
				//获取数据库中该xml是第几次插入
				int insertTime = getInsertTime();
				insertTime++;
				//开始批处理
				executor.startBatch();
				for(IndexUser indexUser : indexUsers){
					indexUser.setInserttime(insertTime);
					//插入操作
					executor.insert("IndexUser.saveIndexUser", indexUser);
				}
				return executor.executeBatch();
			}
		});
		return 0;
	}

	public int saveIndexUser(IndexUser indexUser) {
		return 0;
	}

	/**
	 * 获取xml是第几次插入
	 * @return
	 */
	public int getInsertTime(){
		int insertTime = (Integer)getSqlMapClientTemplate().queryForObject("IndexUser.getInsertTime");
		return insertTime;
	}

/*	public List<IndexUser> getPriceChartByPlantName(IndexUser indexUser) {
		if(indexUser.getPilltype() == 0){
			indexUser.setStartindexweekdate("");
			indexUser.setEndindexweekdate("");
		}
		if("week".equalsIgnoreCase(indexUser.getIndexweekperiod())){
			indexUser.setIndexweekname("week");
		}else if("month".equalsIgnoreCase(indexUser.getIndexweekperiod())){
			indexUser.setIndexweekname("month");
		}
		if(indexUser.getStartindexweekdate() != null && indexUser.getStartindexweekdate().trim().length() > 0){
			indexUser.setStartindexweekdate(indexUser.getStartindexweekdate().replaceAll("-", "/")+" 00:00:00");
		}
		if(indexUser.getEndindexweekdate() != null && indexUser.getEndindexweekdate().trim().length() > 0){
			indexUser.setEndindexweekdate(indexUser.getEndindexweekdate().replaceAll("-", "/")+" 23:59:59");
		}
		List<IndexUser> list = getSqlMapClientTemplate().queryForList("IndexUser.getPriceChartByPlantName", indexUser);
		return list;
	}*/
	
	public List<IndexUser> findPriceChart(IndexUser indexUser) {
		return getSqlMapClientTemplate().queryForList("IndexUser.findPriceChart", indexUser);
	}
}


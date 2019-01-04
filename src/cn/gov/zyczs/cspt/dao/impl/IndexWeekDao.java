package cn.gov.zyczs.cspt.dao.impl;

import java.sql.SQLException;
import java.util.List;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IIndexWeekDao;
import cn.gov.zyczs.cspt.po.IndexWeek;

import com.ibatis.sqlmap.client.SqlMapExecutor;

/**
 * @Title IndexWeekDao.java
 * @Package com.dao.impl
 * @author 赖斌 QQ：283102852 E-mail：zeus163@163.com
 * @date Mar 31, 2012 1:35:51 PM
 * @version 1.0 
 */
public class IndexWeekDao extends SqlMapClientDaoSupport implements IIndexWeekDao{

	public int saveIndexWeek(final List<IndexWeek> indexWeeks) {
		//执行回调
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback(){
			//实现回调接口
			public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException{
				//获取数据库中该xml是第几次插入
				int insertTime = getInsertTime();
				insertTime++;
				//开始批处理
				executor.startBatch();
				for(IndexWeek indexWeek : indexWeeks){
					indexWeek.setInserttime(insertTime);
					//插入操作
					executor.insert("IndexWeek.saveIndexWeek", indexWeek);
				}
				return executor.executeBatch();
			}
		});
		System.out.println("over---------------------------");
		return 0;
	}
	
	/**
	 * 获取xml是第几次插入
	 * @return
	 */
	public int getInsertTime(){
		int insertTime = (Integer)getSqlMapClientTemplate().queryForObject("IndexWeek.getInsertTime");
		return insertTime;
	}
}


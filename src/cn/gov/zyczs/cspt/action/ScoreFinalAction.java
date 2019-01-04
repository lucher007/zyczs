package cn.gov.zyczs.cspt.action;

import java.util.List;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IScoreDeductDao;
import cn.gov.zyczs.cspt.dao.IScoreFinalDao;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.ScoreDeduct;
import cn.gov.zyczs.cspt.po.ScoreFinal;
import com.opensymphony.xwork2.ModelDriven;

public class ScoreFinalAction extends BaseAction implements ModelDriven<ScoreFinal> {
	private static final long serialVersionUID = 1L;
	ScoreFinal form = new ScoreFinal();
	public ScoreFinal getModel() {
		return form;
	}
	private IScoreFinalDao scoreFinalDao;
	public void setScoreFinalDao(IScoreFinalDao scoreFinalDao) {
		this.scoreFinalDao = scoreFinalDao;
	}
	private IScoreDeductDao scoreDeductDao;
	public void setScoreDeductDao(IScoreDeductDao scoreDeductDao) {
		this.scoreDeductDao = scoreDeductDao;
	}
	public String findByListInit(){
		form.setAddtime(scoreFinalDao.findByMaxAddTime());
		form.setAddtimelist(scoreFinalDao.findByAddTime());
		form.setPager_openset(10);
		form.setPager_count(scoreFinalDao.findByCount(form));
		List<ScoreFinal> scorefinallist = scoreFinalDao.findByList(form);
		if(scorefinallist!=null&&scorefinallist.size()>0){
			for(ScoreFinal sf :scorefinallist){
				ScoreDeduct scoreDeduct =new ScoreDeduct();
				scoreDeduct.setOrgid(sf.getOrgid());
				scoreDeduct.setAddtime(Tools.getDateYear()+"-01-01 00:00:00");
				sf.setDscore(scoreDeductDao.findByCurrentScore(scoreDeduct));
			}
		}
		form.setScorefinallist(scorefinallist);
		
		return SUCCESS;
	}


	public String findByList(){
		form.setAddtimelist(scoreFinalDao.findByAddTime());
		form.setPager_openset(10);
		form.setPager_count(scoreFinalDao.findByCount(form));
		List<ScoreFinal> scorefinallist = scoreFinalDao.findByList(form);
		
		if(form.getAddtime()!=null&&!form.getAddtime().equals("-1")){
			if(scorefinallist!=null&&scorefinallist.size()>0){
				for(ScoreFinal sf :scorefinallist){
					ScoreDeduct scoreDeduct =new ScoreDeduct();
					scoreDeduct.setOrgid(sf.getOrgid());
					scoreDeduct.setAddtime(Tools.getDateYear()+"-01-01 00:00:00");
					sf.setDscore(scoreDeductDao.findByCurrentScore(scoreDeduct));
				}
			}
		}
		
		form.setScorefinallist(scorefinallist);
		return SUCCESS;
	}
}

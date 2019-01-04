package cn.gov.zyczs.cspt.action;

import java.awt.Font;
import java.io.OutputStream;
import java.util.List;

import EDU.oswego.cs.dl.util.concurrent.Rendezvous.Rotator;
import cn.gov.zyczs.cspt.dao.IGovmentStatDao;
import cn.gov.zyczs.cspt.po.GovmentStat;

import com.opensymphony.xwork2.ModelDriven;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities; 
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.ui.RectangleInsets;
import org.jfree.util.Rotation;

/**
 * 监管平台 统计分析Action
 * 
 */
@SuppressWarnings("serial")
public class JFreeChartStatAction extends BaseAction implements ModelDriven<GovmentStat>{
	GovmentStat form = new GovmentStat();

	@Override
	public GovmentStat getModel() {
		return form;
	}
	
	private IGovmentStatDao govmentStatDao;

	public void setGovmentStatDao(IGovmentStatDao govmentStatDao) {
		this.govmentStatDao = govmentStatDao;
	}
	
	private JFreeChart chart;
	
	public JFreeChart getChart() {
		return chart;
	}

	public void setChart(JFreeChart chart) {
		this.chart = chart;
	}

	public String buildPieChart() throws Exception {
		
        // 设置数据
        DefaultPieDataset data = new DefaultPieDataset();
        data.setValue("Java", new Double(30));
        data.setValue("VB", new Double(10));
        data.setValue("C/C++", new Double(40));
        data.setValue("Delphi", new Double(20));
        
        // 生成JFreeChart对象
        chart = ChartFactory.createPieChart("饼图测试", data, true, true, true);
        PiePlot plot = (PiePlot) chart.getPlot();
        plot.setNoDataMessage("无数据");
        
        // 解决乱码，饼图分为3部分
        TextTitle textTitle = chart.getTitle();
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20)); //标题文字乱码
        
        plot.setLabelFont(new Font("宋体",Font.BOLD, 12));//饼上的文字乱码
        
        chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 12)); //图例文字乱码
        
        // 设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 400, 300);
        
        return SUCCESS;
    }

    // 柱状图
    public String buildBarChart() throws Exception {
    	
    	// 设置数据
    	DefaultCategoryDataset data = new DefaultCategoryDataset();
    	data.setValue(new Double(30), "", "Java");
        data.setValue(new Double(10), "", "VB");
        data.setValue(new Double(40), "", "C/C++");
        data.setValue(new Double(20), "", "Delphi");
    	
    	chart = ChartFactory.createBarChart("柱状图测试", 
    			"语言类型(X轴标签)", "数量(Y轴标签)", 
    			data, PlotOrientation.VERTICAL, 
    			true, true, true);
    	
    	
    	
    	// 解决乱码问题
    	TextTitle textTitle = chart.getTitle();
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20)); //标题文字乱码
        
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        plot.setNoDataMessage("无数据");
        plot.getRangeAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴字体
        plot.getRangeAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴刻度字体
        plot.getDomainAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置X轴字体
        plot.getDomainAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 12));//设置x轴刻度字体

        chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 12)); //图例文字乱码
    	
        // 设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 400, 300);
        
    	return SUCCESS;
    }
    
    // 折线图
    public String buildLineChart() throws Exception {
    	// 设置数据
    	DefaultCategoryDataset data = new DefaultCategoryDataset();
    	data.setValue(new Double(30), "", "Java");
        data.setValue(new Double(10), "", "VB");
        data.setValue(new Double(40), "", "C/C++");
        data.setValue(new Double(20), "", "Delphi");
    	
    	chart = ChartFactory.createLineChart("折线图测试", 
    			"语言类型(X轴标签)", "数量(Y轴标签)", 
    			data, PlotOrientation.VERTICAL, 
    			true, true, false);
    	
    	// 解决乱码问题
    	TextTitle textTitle = chart.getTitle();
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20)); //标题文字乱码
        
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        plot.setNoDataMessage("无数据");
        plot.getRangeAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴字体
        plot.getRangeAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴刻度字体
        plot.getDomainAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置X轴字体
        plot.getDomainAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 12));//设置x轴刻度字体

//        chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 12)); //图例文字乱码
    	
        // 设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 400, 300);
        
    	return SUCCESS;
    }
	
    /**
	 * 监管平台-交易数量统计-JFreeChart统计-折线
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getTotalWeightJFreeChartLineStat() throws Exception{
		if(form.getType() == null){
			form.setType(0); //默认为药材查询
		}
		form.setStortype(1);//出入库状态：0入库 1出库
		
		List<GovmentStat> list = govmentStatDao.getTotalWeightJFreeChartStat(form);
		
		// 设置数据
    	DefaultCategoryDataset data = new DefaultCategoryDataset();
    	
    	if(list != null && list.size() > 0){
    		for(int i=0;i<list.size();i++){
    			GovmentStat govmentStat = list.get(i);
    			if(govmentStat.getTotalweight() != null && govmentStat.getDatestattype() != null){
    				data.setValue(govmentStat.getTotalweight(), "", govmentStat.getDatestattype());
    			}
    			
    		}
    	}
    	
    	
    	//X轴显示时间统计方式名称
    	String StrXName = "时间";
    	if("yyyy-MM-dd".equals(form.getDatestattype())){
    		StrXName += "(天)";
    	}else if("yyyy-IW".equals(form.getDatestattype())){
    		StrXName += "(周)";
    	}else if("yyyy-MM".equals(form.getDatestattype())){
    		StrXName += "(月)";
    	}
    	
    	chart = ChartFactory.createLineChart("销售重量统计", 
    			StrXName, "重量(kg)", 
    			data, PlotOrientation.VERTICAL, 
    			true, false, false);
    	
    	// 解决乱码问题
    	TextTitle textTitle = chart.getTitle();
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20)); //标题文字乱码
        
        CategoryPlot plot = (CategoryPlot) chart.getPlot();
        plot.setNoDataMessage("无数据");
        plot.getRangeAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴字体
        plot.getRangeAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 12));//设置y轴刻度字体
        plot.getDomainAxis().setLabelFont(new Font("宋体", Font.BOLD, 12));//设置X轴字体
        plot.getDomainAxis().setTickLabelFont(new Font("宋体", Font.BOLD, 8));//设置x轴刻度字体

        
        //设置坐标点可见
        LineAndShapeRenderer localLineAndShapeRenderer = (LineAndShapeRenderer)plot.getRenderer();
        localLineAndShapeRenderer.setBaseShapesVisible(true);
        
        
        //不显示坐标点数值
        LineAndShapeRenderer lineandshaperenderer = (LineAndShapeRenderer) plot.getRenderer(); 
        lineandshaperenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator()); 
        lineandshaperenderer.setBaseItemLabelsVisible(false);
        
        chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 12)); //图例文字乱码
        chart.getLegend().visible = false;
        
        
        // 设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 700, 300);
		
		return SUCCESS;
	}
	
	/**
	 * 监管平台-交易数量统计-JFreeChart统计-饼形
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getAreaWeightJFreeChartPieStat() throws Exception{
		if(form.getType() == null){
			form.setType(0); //默认为药材查询
		}
		form.setStortype(1);//出入库状态：0入库 1出库
		
		List<GovmentStat> list = govmentStatDao.getAreaWeightJFreeChartStat(form);
		
		// 设置数据
		DefaultPieDataset data = new DefaultPieDataset();
    	
    	if(list != null && list.size() > 0){
    		for(int i=0;i<list.size();i++){
    			GovmentStat govmentStat = list.get(i);
    			if(govmentStat.getTotalweight() != null && govmentStat.getZyctype() != null){
    				String zsTypeName = "";
    				if("10000000".equals(govmentStat.getZyctype())){
    					zsTypeName = "药材种植";
    				} else if("01000000".equals(govmentStat.getZyctype())){
    					zsTypeName = "药材经销";
    				} else if("00100000".equals(govmentStat.getZyctype())){
    					zsTypeName = "饮片生产";
    				} else if("00010000".equals(govmentStat.getZyctype())){
    					zsTypeName = "饮片经销";
    				} else if("00001000".equals(govmentStat.getZyctype())){
    					zsTypeName = "药材市场";
    				} else if("00000100".equals(govmentStat.getZyctype())){
    					zsTypeName = "医院药店";
    				}
    				data.setValue(zsTypeName, govmentStat.getTotalweight());
    				
    			}
    			
    		}
    	}
    	
    	chart = ChartFactory.createPieChart3D("各环节销量统计", data, true, true, true);
    	PiePlot3D localPiePlot3D = (PiePlot3D)chart.getPlot();
    	localPiePlot3D.setDarkerSides(true);
        localPiePlot3D.setStartAngle(290.0D);
        localPiePlot3D.setDirection(Rotation.CLOCKWISE);
        localPiePlot3D.setForegroundAlpha(1F);
        localPiePlot3D.setNoDataMessage("无数据");
        localPiePlot3D.setLabelGenerator(new StandardPieSectionLabelGenerator("{0} ({2})"));
        
        //解决乱码，饼图分为3部分
        TextTitle textTitle = chart.getTitle();
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20)); //标题文字乱码
        
        localPiePlot3D.setLabelFont(new Font("宋体",Font.BOLD, 12));//饼上的文字乱码
        
        chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 12)); //图例文字乱码
	    
        //设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 500, 300);
		
		return SUCCESS;
	}
	
}

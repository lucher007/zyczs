package cn.gov.zyczs.cspt.action;


import java.io.OutputStream;

import cn.gov.zyczs.cspt.dao.IGovmentStatDao;
import cn.gov.zyczs.cspt.po.GovmentStat;

import com.opensymphony.xwork2.ModelDriven;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 * 监管平台 统计分析Action
 * 
 */
@SuppressWarnings("serial")
public class SellTotalWeightStatAction extends BaseAction implements ModelDriven<GovmentStat>{
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

	/**
	 * 监管平台-交易数量统计-JFreeChart统计-折现
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getTotalWeightJFreeChartLineStat() throws Exception{
		JFreeChart localJFreeChart = createChart(createDataset());
	    ChartPanel localChartPanel = new ChartPanel(localJFreeChart);
	    localChartPanel.setMouseWheelEnabled(true);
	    
	    //设置输出图片的宽度和高度，单位：px
        OutputStream out = getResponse().getOutputStream();
        ChartUtilities.writeChartAsPNG(out, chart, 700, 300);
		return SUCCESS;
	}
	
	private XYDataset createDataset()
	  {
	    XYSeries localXYSeries1 = new XYSeries("First");
	    localXYSeries1.add(1.0D, 1.0D);
	    localXYSeries1.add(2.0D, 4.0D);
	    localXYSeries1.add(3.0D, 3.0D);
	    localXYSeries1.add(4.0D, 5.0D);
	    localXYSeries1.add(5.0D, 5.0D);
	    localXYSeries1.add(6.0D, 7.0D);
	    localXYSeries1.add(7.0D, 7.0D);
	    localXYSeries1.add(8.0D, 8.0D);
	    XYSeries localXYSeries2 = new XYSeries("Second");
	    localXYSeries2.add(1.0D, 5.0D);
	    localXYSeries2.add(2.0D, 7.0D);
	    localXYSeries2.add(3.0D, 6.0D);
	    localXYSeries2.add(4.0D, 8.0D);
	    localXYSeries2.add(5.0D, 4.0D);
	    localXYSeries2.add(6.0D, 4.0D);
	    localXYSeries2.add(7.0D, 2.0D);
	    localXYSeries2.add(8.0D, 1.0D);
	    XYSeries localXYSeries3 = new XYSeries("Third");
	    localXYSeries3.add(3.0D, 4.0D);
	    localXYSeries3.add(4.0D, 3.0D);
	    localXYSeries3.add(5.0D, 2.0D);
	    localXYSeries3.add(6.0D, 3.0D);
	    localXYSeries3.add(7.0D, 6.0D);
	    localXYSeries3.add(8.0D, 3.0D);
	    localXYSeries3.add(9.0D, 4.0D);
	    localXYSeries3.add(10.0D, 3.0D);
	    XYSeriesCollection localXYSeriesCollection = new XYSeriesCollection();
	    localXYSeriesCollection.addSeries(localXYSeries1);
	    localXYSeriesCollection.addSeries(localXYSeries2);
	    localXYSeriesCollection.addSeries(localXYSeries3);
	    return localXYSeriesCollection;
	  }

	  private JFreeChart createChart(XYDataset paramXYDataset)
	  {
		chart = ChartFactory.createXYLineChart("Line Chart Demo 2", "X", "Y", paramXYDataset, PlotOrientation.VERTICAL, true, true, false);
	    XYPlot localXYPlot = (XYPlot)chart.getPlot();
	    localXYPlot.setDomainPannable(true);
	    localXYPlot.setRangePannable(true);
	    XYLineAndShapeRenderer localXYLineAndShapeRenderer = (XYLineAndShapeRenderer)localXYPlot.getRenderer();
	    localXYLineAndShapeRenderer.setBaseShapesVisible(true);
	    localXYLineAndShapeRenderer.setBaseShapesFilled(true);
	    NumberAxis localNumberAxis = (NumberAxis)localXYPlot.getRangeAxis();
	    localNumberAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	    return chart;
	  }
	
}

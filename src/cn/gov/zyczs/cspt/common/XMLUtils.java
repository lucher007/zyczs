package cn.gov.zyczs.cspt.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import cn.gov.zyczs.cspt.po.IndexUser;
import cn.gov.zyczs.cspt.po.IndexWeek;

public class XMLUtils {

	private static XMLUtils xmlUtil;

	private Element root = null;// 读取XML文件
	private Document document;

	public static XMLUtils instance() {
		if (xmlUtil == null) {
			xmlUtil = new XMLUtils();
			xmlUtil.createDocument();
		}
		return xmlUtil;
	}

	private void createDocument() {
		try {
			String seperator = System.getProperty("file.separator");
			StringBuilder sb = new StringBuilder();
			sb.append("D:").append(seperator).append("zycsy").append(seperator)
					.append("priceindexitemlisting.xml");

			SAXReader saxReader = new SAXReader();
			document = (Document) saxReader.read(sb.toString());

			root = document.getRootElement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public List<Node> getIndexUserList(String node) {
		List<Node> result = root.element("Category").selectNodes("Spell");
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<IndexUser> getIndexUser() {
		List<Node> categorys = root.elements("Category");
		List<IndexUser> configs = new ArrayList<IndexUser>();
		for (Node category : categorys) {
			List<Node> spells = category.selectNodes("Spell");
			for (Node spell : spells) {
				List<Node> subCategorys = spell.selectNodes("SubCategory");
				for (Node subCategory : subCategorys) {
					Element element = (Element) subCategory;
					IndexUser config = new IndexUser();
					config.setIndexusername((element.attributeValue("name")));
					config.setIndexusercode(element
							.attributeValue("SubCategoryCode"));
					configs.add(config);
				}
			}
		}
		System.out.println("xml size>>>>>"+configs.size());
		return configs;
	}

	@SuppressWarnings("unchecked")
	public List<IndexWeek> getIndexWeek() {
		List<Node> priceIndexs = root.elements("PriceIndex");
		List<IndexWeek> configs = new ArrayList<IndexWeek>();
		for (Node priceIndex : priceIndexs) {
			Element element = (Element)priceIndex;
			String date = element.attributeValue("Date").toString().replace("年", "/").replace("月","/");
			List<Node> items = priceIndex.selectNodes("Items");
			
			for (Node item : items) {
				Element element2 = (Element)item;
				String code = element2.attributeValue("Code").toString();
				List<Node> nodes = item.selectNodes("Item");
				
				for (Node node : nodes) {
					IndexWeek config = new IndexWeek();
					config.setIndexweekdate(date);
					config.setIndexweekcode(code);
					
					Element element3 = (Element) node;
					config.setIndexweekname((element3.attributeValue("Name").toString()));
					config.setIndexweekvalue((element3.attributeValue("Value").toString()));
					config.setIndexweekperiod((element3.attributeValue("Period").toString()));
					
					configs.add(config);
				}
			}
		}
		System.out.println("xml size>>>>>"+configs.size());
		return configs;
	}
	/**
	 * 根据名字得到xml值
	 * 
	 * @param Type
	 *            一级菜单名
	 * @param key
	 *            二级菜单名
	 * @return String 值
	 */
	public String getXmlValue(String Type, String key) {
		Element autoCreateWorkorder = root.element(Type);
		return autoCreateWorkorder.element(key).getTextTrim();
	}

	/**
	 * 根据名字得到xml值
	 * 
	 * @param key
	 *            菜单名
	 * @return String 值
	 */
	public String getXmlValue(String key) {
		return root.element(key).getTextTrim();
	}

	public static void main(String[] args) {
		XMLUtils.instance().getIndexWeek();
	}
}

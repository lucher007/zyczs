package cn.gov.zyczs.cspt.common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * 根据远程地址读取XML保存到本地
 * 
 * @author 赖斌
 * 
 */
public class HttpDownloader {
	private static  String dir;// 需要保存的目录
	private static  List<String> addresses = new ArrayList<String>();//远程xml地址
	
	static{
		dir = "D:\\zycsy\\";
		addresses.add("http://www.ysindex.com/portals/0/xml/productlisting.xml");
		addresses.add("http://www.ysindex.com/portals/0/xml/priceindexitemlisting.xml");
	}
	/**
	 * 根据address下载文本文件
	 * 
	 * @param address
	 * @return
	 */
	public static void download(String address) {
		BufferedReader reader = null;
		PrintWriter writer = null;
		StringBuffer sb = new StringBuffer();
		try {
			// 创建一个本地xml文件
			String fileName = address.substring(address.lastIndexOf("/") + 1);
			File director = new File(dir);
			// 如果目录不存在则自动创建目录
			if (!director.exists()) {
				director.mkdir();
			}
			File xml = new File(dir + fileName);
			if (!xml.exists()) {
				xml.createNewFile();
			}
			// 创建一个Url对象
			URL url = new URL(address);
			// 创建一个http连接
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// /创建输入流对象
			InputStream in = conn.getInputStream();
			// 创建reader对象,提高读取性能
			reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
			// 创建bufferWrite对象,提高写入性能
			writer = new PrintWriter(new FileWriter(xml));
			String line = "";
			while ((line = reader.readLine()) != null) {
				writer.println(line.substring(1));
			}
			writer.flush();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (writer != null) {
				try {
					writer.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * down 的简单方法 保存到本地自己指定
	 */
	public static void writeFile(String address) {
		//获取网络端的输入流
		InputStream is = null;
		//创建输出流
		OutputStream os = null;
		try {
			// 创建一个本地xml文件
			String fileName = address.substring(address.lastIndexOf("/") + 1);
			File director = new File(dir);
			// 如果目录不存在则自动创建目录
			if (!director.exists()) {
				director.mkdir();
			}
			File xmlFile = new File(dir + fileName);
			if (!xmlFile.exists()) {
				xmlFile.createNewFile();
			}
			// 创建一个Url对象
			URL url = new URL(address);
			is = url.openStream();
			os = new FileOutputStream(xmlFile);
			//创建单个字节存放变量
			int bytesRead = 0;
			//创建一个字节数组
			byte[] buffer = new byte[8192];
			//循环将远程数据写入文件
			while ((bytesRead = is.read(buffer, 0, 8192)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
		} catch (Exception e2) {
			e2.printStackTrace();
		}
	}
	/**
	 * 定时采集远程的xml到本地磁盘
	 */
	public static void regularDownloads(){
		for(String address : addresses){
			HttpDownloader.writeFile(address);
		}
	}
	
	/*public static void main(String[] args) {
		//String address = "http://www.ysindex.com/portals/0/xml/productlisting.xml";
		String address ="http://www.ysindex.com/portals/0/xml/priceindexitemlisting.xml";
		//HttpDownloader.download(address);
		HttpDownloader.writeFile(address);
	}*/
}

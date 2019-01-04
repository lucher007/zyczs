package cn.gov.zyczs.cspt.common;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Label;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;

import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.TabletAssist;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.swetake.util.Qrcode;

public class Tools {
	private Calendar c = Calendar.getInstance();

	//工具
	public static String getDateMonthStr() {
		return (new SimpleDateFormat("yyyy-MM")).format(new Date());
	}

	public static String getDateYear() {
		return (new SimpleDateFormat("yyyy")).format(new Date());
	}

	public static String getNowRandom() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date())
				+ random(16);
	}

	public static String getNowRandomTwo() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date())
				+ random(2);
	}

	public static String getNowRandomThree() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date());
	}

	public static String getCurrentTime() {
		return (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date());
	}

	public static String getDateMonthDayStr() {
		return (new SimpleDateFormat("yyyyMMdd")).format(new Date());
	}

	public static String getDateMonthDayStrTwo() {
		return (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
	}
	public static String getLastYear(){
		Calendar curr = Calendar.getInstance();
		curr.set(Calendar.YEAR,curr.get(Calendar.YEAR)-1);
		Date date=curr.getTime();
		return (new SimpleDateFormat("yyyy")).format(date);
	}
	public static String getDateUnix(){
		return String.valueOf(System.currentTimeMillis()).substring(0, 10);
	}
	public static void setVOToVO(Object objVO1, Object objVO2) {
		try {
			BeanUtils.copyProperties(objVO2, objVO1);
		} catch (Exception ex) {
			System.out.println("setVOToVO is Error!!!" + ex.getMessage());
		}
	}

	public static String random(int len) {
		long lng = new Random().nextLong();
		if (lng < 0) {
			lng = lng * (-1);
		}
		String lngStr = "" + lng;
		if (lngStr.length() < len) {
			lngStr += random(len - lngStr.length());
		} else {
			lngStr = lngStr.substring(0, len);
		}
		return lngStr;
	}

	public static String htmlCheck(String str) {
		if (str == null) {
			return null;
		} else {
			String fString = str;
			//fString = fString.replaceAll(";", "&#59;");
			fString = fString.replaceAll("<", "&lt;");
			fString = fString.replaceAll(">", "&gt;");
			fString = fString.replaceAll("\n", "");
			fString = fString.replaceAll("--", "&#45;&#45;");
			fString = fString.replaceAll("'", "&#39;");
			fString = fString.replaceAll("\"", "&#34;");
			//fString = fString.replaceAll("   ", "&nbsp;");
			fString = fString.replaceAll("%", "％");
			fString = fString.replaceAll("'", "‘");
			return fString;
		}
	}

	public static String decode(String str) {
		if (str == null) {
			return null;
		} else {
			String fString = str;
			//fString = fString.replaceAll("&nbsp;", "   ");
			fString = fString.replaceAll("&#34;", "\"");
			fString = fString.replaceAll("&#39;", "'");
			fString = fString.replaceAll("&#45;&#45;", "--");
			fString = fString.replaceAll("<br/>", "\n");
			fString = fString.replaceAll("&gt;", ">");
			fString = fString.replaceAll("&lt;", "<");
			//fString = fString.replaceAll("&#59;", ";");
			fString = fString.replaceAll("%", "％");
			fString = fString.replaceAll("'", "‘");
			return fString;
		}
	}

	public static String decodeSMS(String str) {
		if (str == null) {
			return null;
		} else {
			String fString = str;
			fString = fString.replaceAll("&#34;", "“");
			fString = fString.replaceAll("&#39;", "‘");
			fString = fString.replaceAll("&gt;", "＞");
			fString = fString.replaceAll("&lt;", "＜");
			fString = fString.replaceAll("<br/>", "\n");
			return fString;
		}
	}

	public static String decodeAll(String str) {
		if (str == null) {
			return null;
		} else {
			String fString = str;
			fString = fString.replaceAll("&nbsp;", "   ");
			fString = fString.replaceAll("&#34;", "”");
			fString = fString.replaceAll("&#39;", "‘");
			fString = fString.replaceAll("&#45;&#45;", "－－");
			fString = fString.replaceAll("<br/>", "\r\n");
			fString = fString.replaceAll("<BR>", "\r\n");
			fString = fString.replaceAll("<br>", "\r\n");
			fString = fString.replaceAll("&gt;", "＞");
			fString = fString.replaceAll("&lt;", "＜");
			fString = fString.replaceAll("&#59;", "；");
			fString = fString.replaceAll("%", "％");
			fString = fString.replaceAll("'", "‘");
			fString = fString.replaceAll("&#8226;", "\267");
			fString = fString.replaceAll("&#100000001;", "\267");
			fString = fString.replaceAll("&#100000002;", "，");
			fString = fString.replaceAll("&#100000003;", "？");
			fString = fString.replaceAll("&#100000004;", "!");
			fString = fString.replaceAll("&#100000005;", "。");
			fString = fString.replaceAll("&#100000006;", "《");
			fString = fString.replaceAll("&#100000007;", "》");
			fString = fString.replaceAll("&#100000008;", "【");
			fString = fString.replaceAll("&#100000009;", "】");
			fString = fString.replaceAll("&#1000000010;", "—");
			fString = fString.replaceAll("&#1000000011;", "%");
			fString = fString.replaceAll("&#1000000012;", "-");
			fString = fString.replaceAll("&#1000000013;", "…");
			fString = fString.replaceAll("&#1000000014;", "~");
			fString = fString.replaceAll("&#1000000015;", "“");
			fString = fString.replaceAll("&#1000000016;", "”");
			fString = fString.replaceAll("&#1000000017;", "；");
			fString = fString.replaceAll("&#1000000018;", "’");
			fString = fString.replaceAll("&#1000000019;", "‘");
			fString = fString.replaceAll("&#1000000020;", "、");
			fString = fString.replaceAll("&#1000000021;", "/");
			fString = fString.replaceAll("&#1000000022;", "@");
			fString = fString.replaceAll("&#1000000023;", "（");
			fString = fString.replaceAll("&#1000000024;", "）");
			fString = fString.replaceAll("&#1000000025;", "＝");
			fString = fString.replaceAll("&#1000000026;", "＋");
			return fString;
		}
	}

	public static String getStringBetween(String src, String beginStr,
			String endStr) {
		int beginIndex = src.indexOf(beginStr);
		if (beginIndex < 0) {
			return "";
		}
		String leftStr = src.substring(beginIndex + beginStr.length(), src
				.length());
		int endIndex = leftStr.indexOf(endStr);
		if (endIndex < 0) {
			return "";
		}
		return leftStr.substring(0, endIndex);
	}

	public static String getLastStrByLastStr(String src, String str) {
		int i = src.lastIndexOf(str);
		if (i < 0) {
			return "";
		}
		return src.substring(i + str.length());
	}

	public static String getLastStrByFirstStr(String src, String str) {
		int i = src.indexOf(str);
		if (i < 0) {
			return "";
		}
		return src.substring(i + str.length());
	}
	public static String getStrend(String str) {
		String[] strVale = str.split("[.]");
		int Maxs = (strVale.length) - 1;
		str = strVale[Maxs];
		return str;
	}
	public static String copyFile(String root, String folder, String src) {
		String srcFileName = getLastStrByLastStr(src, "resources");
		if (srcFileName.length() < 1) {
			return "";
		}
		srcFileName = "resources" + srcFileName;
		String srcFilePath = getLastStrByLastStr(src, "/");
		if (srcFilePath.length() < 1) {
			return "";
		}
		System.out.println(root + srcFileName);
		System.out.println(root + folder + srcFilePath);
		if (copyFiles(root + srcFileName, root + folder + srcFilePath)) {
			return srcFilePath;
		}
		return "";
	}

	public static boolean copyFiles(String oldPath, String newPath) {
		try {
			System.out.println("oldPath====" + oldPath);
			System.out.println("newPath====" + newPath);
			int bytesum = 0;
			int byteread = 0;
			File oldfile = new File(oldPath);
			if (oldfile.exists()) {
				InputStream inStream = new FileInputStream(oldPath);
				FileOutputStream fs = new FileOutputStream(newPath);
				byte[] buffer = new byte[2048];
				while ((byteread = inStream.read(buffer)) != -1) {
					bytesum += byteread;
					System.out.println(bytesum);
					fs.write(buffer, 0, byteread);
				}
				inStream.close();
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static String copyFilesString(String oldPath, String newPath) {
		String newName = "";
		try {
			int bytesum = 0;
			int byteread = 0;
			File oldfile = new File(oldPath);
			if (oldfile.exists()) {
				InputStream inStream = new FileInputStream(oldPath);
				FileOutputStream fs = new FileOutputStream(newPath);
				byte[] buffer = new byte[1444];
				while ((byteread = inStream.read(buffer)) != -1) {
					bytesum += byteread;
					fs.write(buffer, 0, byteread);
				}
				inStream.close();

				return newName = newPath;
			} else {
				return newName;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return newName;
		}
	}

	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath);
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			myFilePath.delete();

		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	public static void delAllFile(String path) {
		File file = new File(path);
		if (!file.exists()) {
			return;
		}
		if (!file.isDirectory()) {
			return;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);
				delFolder(path + "/" + tempList[i]);
			}
		}
	}

	public static boolean newFile(String filePathAndName, String fileContent) {
		try {
			String filePath = filePathAndName;
			filePath = filePath.toString();
			File myFilePath = new File(filePath);
			if (!myFilePath.exists()) {
				myFilePath.createNewFile();
			}
			FileWriter resultFile = new FileWriter(myFilePath);
			PrintWriter myFile = new PrintWriter(resultFile);
			String strContent = fileContent;
			myFile.println(strContent);
			resultFile.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public static float checkSize(String path) {
		float allsize = 0;
		File f = new File(path);
		if (!f.exists()) {
			return allsize;
		}
		File fa[] = f.listFiles();
		long allsizetemp = 0;
		for (int i = 0; i < fa.length; i++) {
			File fs = fa[i];
			if (fs.isDirectory()) {

			} else {
				allsizetemp += fs.length();
			}
		}
		allsize = (float) (Math.round(allsizetemp / 1024 * 100)) / 100;
		return allsize;
	}

	public static String createSmilStr(String src, String mmsconfigurl) {

		if ("".equals(src)) {
			return "";
		}
		if (src.length() < 10) {
			return "";
		}
		if ("".equals(mmsconfigurl)) {
			return "";
		}

		String folderroot = ServletActionContext.getRequest().getRealPath("/");
		folderroot = folderroot.replace("\\", "/");

		String folderpath = "smilfile/" + Tools.getDateMonthStr() + "/"
				+ Tools.getNowRandom() + "/";
		File folder = new File(folderroot + folderpath);
		if (!folder.exists()) {
			folder.mkdirs();
		}

		//String material_textpic_path = ServletActionContext.getServletContext().getInitParameter("material_textpic_path");
		String tempStr = "";
		String suffixStr = "";
		String filename = "";
		String tempone = "";
		String temponemore = "";
		String str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><smil><head><layout>";
		String[] mmswh = mmsconfigurl.split("x");
		String region = "";
		String body = "";
		int allheight = 0;
		int num = 1;
		String[] frames = src.split("≡");
		System.out.println("==========frames.length============="
				+ frames.length);
		for (int i = 0; i < frames.length; i++) {

			String frame = Tools.getStringBetween(frames[i], "<DIV", "</DIV>");
			String par = Tools.getStringBetween(frame, "<INPUT value=",
					" name=");
			body += "<par dur=\"" + par + "ms\">";

			if (frame.indexOf("url") != -1) {
				String bgpic = Tools.getStringBetween(frame, "url(", ")");
				String suffixStrbg = Tools.getLastStrByLastStr(bgpic, ".");
				String bgfilename = Tools.getNowRandom() + "." + suffixStrbg;
				String bgpicfinish = folderroot + folderpath + bgfilename;
				Tools.copyFilesString(folderroot + bgpic, bgpicfinish);

				String[] sources = frames[i].split("<DIV");
				List files = new ArrayList();
				for (int j = 2; j < sources.length; j++) {
					sources[j] = Tools.decodeAll(sources[j]);
					tempStr = Tools.getStringBetween(sources[j], ">", "</DIV>");
					if (tempStr.indexOf("<A") == 0) {
						tempStr = Tools.getStringBetween(tempStr, "href=\"",
								"\"");
						suffixStr = Tools.getLastStrByLastStr(tempStr, ".");
						filename = Tools.copyFile(folderroot, folderpath,
								tempStr);
						if ("".equals(filename)) {
							Tools.delFolder(folderroot + folderpath);
							return "";
						}
						//str += "<" + suffixStr + " src=\"" + filename + "\"/>";
						str += "<audio src=\"" + filename + "\"/>";
					} else if (tempStr.indexOf("<IMG") == 0) {
						tempStr = Tools.getStringBetween(tempStr, "\"", "\"");
						files.add(tempStr);
					} else if (tempStr.indexOf("<LABEL") == 0) {
						String[] matconcoltxtmore = tempStr.split("\r\n");
						for (int t = 0; t < matconcoltxtmore.length; t++) {
							String matconcoltxtone = matconcoltxtmore[t];
							String[] matcolarray = matconcoltxtone
									.split("</LABEL>");
							for (int m = 0; m < matcolarray.length; m++) {
								if (matcolarray[m].indexOf("textpic") != -1) {
									tempone = Tools.getStringBetween(
											matcolarray[m], "textpic/", "\"");
									files.add(tempone);
								} else {
									tempone = Tools.getStringBetween(
											matcolarray[m], ">", "</FONT>");
									tempone = Tools.getLastStrByLastStr(
											tempone, ">");
									files.add(tempone);
								}
							}
							files.add("\r\n");
						}
					} else {
						files.add(Tools.decode("≡" + tempStr));
					}
				}
				List giffilename = new ArrayList();

				String name = "";
				String finishname = "";

			} else {
				String[] sources = frames[i].split("<DIV");
				if (frames[i].indexOf("<LABEL") != -1) {
					List files = new ArrayList();
					for (int j = 2; j < sources.length; j++) {
						sources[j] = Tools.decodeAll(sources[j]);
						tempStr = Tools.getStringBetween(sources[j], ">",
								"</DIV>");
						if (tempStr.indexOf("<A") == 0) {
							tempStr = Tools.getStringBetween(tempStr,
									"href=\"", "\"");
							suffixStr = Tools.getLastStrByLastStr(tempStr, ".");
							filename = Tools.copyFile(folderroot, folderpath,
									tempStr);
							if ("".equals(filename)) {
								Tools.delFolder(folderroot + folderpath);
								return "";
							}
							//str += "<" + suffixStr + " src=\"" + filename + "\"/>";
							str += "<audio src=\"" + filename + "\"/>";
						} else if (tempStr.indexOf("<IMG") == 0) {
							tempStr = Tools.getStringBetween(tempStr, "\"",
									"\"");
							files.add(tempStr);
						} else if (tempStr.indexOf("<LABEL") == 0) {
							String[] matconcoltxtmore = tempStr.split("\r\n");
							for (int t = 0; t < matconcoltxtmore.length; t++) {
								String matconcoltxtone = matconcoltxtmore[t];
								String[] matcolarray = matconcoltxtone
										.split("</LABEL>");
								for (int m = 0; m < matcolarray.length; m++) {
									if (matcolarray[m].indexOf("textpic") != -1) {
										tempone = Tools.getStringBetween(
												matcolarray[m], "textpic/",
												"\"");
										files.add(tempone);
									} else {
										tempone = Tools.getStringBetween(
												matcolarray[m], ">", "</FONT>");
										tempone = Tools.getLastStrByLastStr(
												tempone, ">");
										files.add(tempone);
									}
								}
								files.add("\r\n");
							}
						} else {
							files.add(Tools.decode("≡" + tempStr));
						}
					}

				} else {
					for (int j = 2; j < sources.length; j++) {
						System.out
								.println("=======sources.length==================="
										+ sources.length);
						sources[j] = Tools.decodeAll(sources[j]);
						tempStr = Tools.getStringBetween(sources[j], ">",
								"</DIV>");
						if (tempStr.indexOf("<A") == 0) {
							tempStr = Tools.getStringBetween(tempStr,
									"href=\"", "\"");
							suffixStr = Tools.getLastStrByLastStr(tempStr, ".");
							filename = Tools.copyFile(folderroot, folderpath,
									tempStr);
							if ("".equals(filename)) {
								Tools.delFolder(folderroot + folderpath);
								return "";
							}
							body += "<audio src=\"" + filename + "\"/>";
						} else if (tempStr.indexOf("<IMG") == 0) {
							int wideth = 0;
							int height = 0;
							tempStr = Tools.getStringBetween(tempStr, "\"",
									"\"");
							filename = Tools.copyFile(folderroot, folderpath,
									tempStr);
							if ("".equals(filename)) {
								Tools.delFolder(folderroot + folderpath);
								return "";
							}
							try {
								File img = new File(folderroot + folderpath
										+ filename);
								Image imgsrc = ImageIO.read(img);
								wideth = imgsrc.getWidth(null);
								height = imgsrc.getHeight(null);
							} catch (Exception e) {
								e.printStackTrace();
							}
							if (i == 0 && j == 2) {
								region += "<region id=\"Image" + num
										+ "\" left=\"0\" top=\"0\" width=\""
										+ mmswh[1] + "\" height=\"" + height
										+ "\" />";
							} else {
								region += "<region id=\"Image" + num
										+ "\" left=\"0\" top=\"" + allheight
										+ "\" width=\"" + mmswh[1]
										+ "\" height=\"" + height + "\" />";
							}
							allheight += height;
							body += "<img src=\"" + filename
									+ "\" region=\"Image" + num + "\" />";
							num++;
						} else {
							int height = 0;
							filename = Tools.getNowRandom() + i + ".txt";
							System.out
									.println("=====filename===================="
											+ filename);
							System.out
									.println("=====filename length===================="
											+ tempStr.length());
							if (Tools.newFile(folderroot + folderpath
									+ filename, Tools.decode(tempStr)) == false) {
								Tools.delFolder(folderroot + folderpath);
								return "";
							}
							height = (Integer.parseInt(mmswh[1]) / 12) * 12;
							if (i == 0 && j == 2) {
								region += "<region id=\"Text" + num
										+ "\" left=\"0\" top=\"0\" width=\""
										+ mmswh[1] + "\" height=\"" + height
										+ "\" />";
							} else {
								region += "<region id=\"Text" + num
										+ "\" left=\"0\" top=\"" + allheight
										+ "\" width=\"" + mmswh[1]
										+ "\" height=\"" + height + "\" />";
							}
							allheight += height;
							body += "<text src=\"" + filename
									+ "\" region=\"Text" + num + "\" />";
							num++;
						}

					}
				}
			}
			body += "</par>";
		}

		String rootlayout = "<root-layout width=\"" + mmswh[1] + "\" height=\""
				+ allheight + "\" />";
		str += rootlayout + region + "</layout></head><body>" + body
				+ "</body></smil>";
		String finallStr = Tools.getStringBetween(str, "<body>", "</body>");
		if ("".equals(finallStr)) {
			return "";
		}
		filename = Tools.getNowRandom() + ".smil";
		if (Tools.newFile(folderroot + folderpath + filename, str) == false) {
			Tools.delFolder(folderroot + folderpath);
			return "";
		}
		return folderroot + folderpath + filename;

	}

	public static String getTwoCode(String str) {
		Qrcode qrcode = new Qrcode();
		qrcode.setQrcodeErrorCorrect('M');
		qrcode.setQrcodeEncodeMode('B');
		qrcode.setQrcodeVersion(7);
		String file_codeimg_path = "";
		String filename = "";
		String testString = str;
		try {
			byte[] d;

			d = testString.getBytes("GBK");

			BufferedImage bi = new BufferedImage(139, 139,
					BufferedImage.TYPE_INT_RGB);

			// createGraphics    
			Graphics2D g = bi.createGraphics();

			// set background    
			g.setBackground(Color.WHITE);
			g.clearRect(0, 0, 139, 139);

			g.setColor(Color.BLACK);

			if (d.length > 0 && d.length < 123) {
				boolean[][] b = qrcode.calQrcode(d);

				for (int i = 0; i < b.length; i++) {

					for (int j = 0; j < b.length; j++) {
						if (b[j][i]) {
							g.fillRect(j * 3 + 2, i * 3 + 2, 3, 3);
						}
					}

				}
			}

			g.dispose();
			bi.flush();
			file_codeimg_path = ServletActionContext.getServletContext()
					.getInitParameter("file_codeimg_path");
			String folderpath = ServletActionContext.getRequest().getRealPath(
					"/")
					+ file_codeimg_path + "/" + Tools.getDateMonthStr();
			File folder = new File(folderpath);
			if (!folder.exists()) {
				folder.mkdirs();
			}
			filename = Tools.getNowRandomTwo() + ".png";
			String FilePath = folderpath + "/" + filename;
			File f = new File(FilePath);
			ImageIO.write(bi, "png", f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file_codeimg_path + "/" + Tools.getDateMonthStr() + "/"
				+ filename;
	}

	public static String readfile() {
		StringBuffer content = new StringBuffer();
		try {
			BufferedReader br = new BufferedReader(
					new FileReader(
							"E:\\apache-tomcat-5.5.28\\webapps\\zyc\\resources\\xh_GPS_0517.txt"));

			String ch = null;
			while ((ch = br.readLine()) != null) {
				System.out.println("========");
				content.append(ch + "\n");
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return content.toString();
	}
	
	public static Integer addtract_Integer(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.add(b2).intValue();
	}
	
	public static Integer subtract_Integer(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.subtract(b2).intValue();
	}
	
	//加
	public static Double addtr(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.add(b2).doubleValue();
	}
	
	//减
	public static Double subtr(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.subtract(b2).doubleValue();
	}
	
	//乘
	public static Double multiply(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.multiply(b2).doubleValue();
	}
	
	//除  
	public static Double division(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.divide(b2).doubleValue();
	}

	public static Image bytesToImage(byte[] bytes) {
		Image image = Toolkit.getDefaultToolkit().createImage(bytes);
		try {
			MediaTracker mt = new MediaTracker(new Label());
			mt.addImage(image, 0);
			mt.waitForAll();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return image;
	}

	public static File getFileFromBytes(byte[] b, String outputFile) {
		BufferedOutputStream stream = null;
		File file = null;
		try {
			file = new File(outputFile);
			FileOutputStream fstream = new FileOutputStream(file);
			stream = new BufferedOutputStream(fstream);
			stream.write(b);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		return file;
	}

	public static float floatformat(float f) {
		DecimalFormat formater = new DecimalFormat("#0.###");
		return Float.valueOf(formater.format(f));
	}

	/*
	 * 转为UTF-8
	 */
	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("ISO-8859-1");
				} catch (Exception ex) {
					System.out.println(ex);
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}
	/**
	 * 获取每个月第一天
	 * @param sYear
	 * @param sMonth
	 * @return
	 */
	public String getFirstDayofMonth(int sYear, int sMonth) {
		String tStartdate = "";
		String month_str = "";
		String day_str = "";
		c.set(c.YEAR, sYear);
		c.set(c.MONTH, sMonth);
		
		if(sMonth < 10){
			month_str = "0"+String.valueOf(sMonth);
		}else{
			month_str = String.valueOf(sMonth);
		}
		
		if(c.getActualMinimum(c.DAY_OF_MONTH) < 10){
			day_str = "0"+c.getActualMinimum(c.DAY_OF_MONTH);
		}else{
			day_str = String.valueOf(c.getActualMinimum(c.DAY_OF_MONTH));
		}
		
		tStartdate = String.valueOf(sYear) + "-" + month_str + "-"
				+ day_str;

		return tStartdate;
	}
	/**
	 * 获取每个月最后一天
	 * @param sYear
	 * @param sMonth
	 * @return
	 */
	public String getEndDayofMonth(int sYear, int sMonth) {
		String tEnddate = "";
		String month_str = "";
		String day_str = "";
		c.set(c.YEAR, sYear);
		c.set(c.MONTH, sMonth);
		
		if(sMonth < 10){
			month_str = "0"+String.valueOf(sMonth);
		}else{
			month_str = String.valueOf(sMonth);
		}
		
		if(c.getActualMaximum(c.DAY_OF_MONTH) < 10){
			day_str = "0"+c.getActualMaximum(c.DAY_OF_MONTH);
		}else{
			day_str = String.valueOf(c.getActualMaximum(c.DAY_OF_MONTH)-1);
		}
		
		tEnddate = String.valueOf(sYear) + "-" + month_str + "-"
				+ day_str;
		return tEnddate;
	}
	
	public String getMonth(){
		return (new SimpleDateFormat("MM")).format(new Date());
	}
	private static int [] w = null ; 

    

	  

    // 生成校验码 ,code 为除了校验位的其他数据，企业 13 位，产品 19 位等 

    public static String getCheckCode(String code) { 
        String str = "" ; 
        int codelength=0; 
        if ( w == null ) { 
            w = new int [34]; 
            for ( int i = 0; i < 34; i++) { 
                w [i] = (( int ) Math.pow(3, i + 1)) % 10; 
            }
        } 
        codelength=code.length(); 
        if (codelength>34) return null ; 
        int [] f = new int [codelength]; 
        for ( int i = 0; i < codelength; i++) { 
            f[i] = Integer.parseInt(code.substring(codelength - i - 1, codelength - i)); 
        } 
        int s = 0;
        for ( int i = 0; i < codelength; i++) { 
            s = s + w [i] * f[i]; 
        } 
        str = String.valueOf(s % 10); 
        return str; 
    }


   /**
    * 将时间截取成11位
    * @param date
    * @return
    */
   public static String formatDate(String date){
	   return date != null ? date.substring(0, 11):"";
   }
   /**
    * 将float转变成String
    * @param value
    * @return
    */
   public static String stringToFloat(Float value){
	   return value != null ? String.valueOf(value):"";
   }
   
   public static String isCheck(String value){
	   return value.equals("0")?"否":"是";
   }
   
   /**
    * 将double转变成String
    * @param value
    * @return
    */
   public static String doubleToString(Double value){
	   return value != null ? String.valueOf(value):"";
   }
   
   //post方法
   public static String sendPost(String xmlstr,String type) throws IOException {
	   String urlstr="";
	   if(type.equals("corpinfo")){
		   urlstr=ServletActionContext.getServletContext().getInitParameter("corpinfo");
	   }else if(type.equals("prodinfo")){
		   urlstr=ServletActionContext.getServletContext().getInitParameter("prodinfo");
	   }else if(type.equals("chooseorg")){
		   urlstr=ServletActionContext.getServletContext().getInitParameter("outstorage_url");
	   }

   	   URL url = new URL(urlstr);   
       URLConnection connection = url.openConnection();     
       connection.setConnectTimeout(1000 * 10);//设置连接超时
       connection.setReadTimeout(1000 * 10);//设置读取超时
       connection.setDoOutput(true);
  
       OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");   
       if(type.equals("corpinfo")){
    	   out.write("xmlname="+xmlstr);
	   }else if(type.equals("prodinfo")){
		   out.write("xmlname="+xmlstr);
	   }else if(type.equals("chooseorg")){
		   out.write(xmlstr);
	   }
       out.flush();
       out.close();          
       String sCurrentLine= "";   
       String sTotalString = ""; 
       InputStream l_urlStream = connection.getInputStream();    
       BufferedReader l_reader = new BufferedReader(new InputStreamReader(l_urlStream,"UTF-8"));   
       while ((sCurrentLine = l_reader.readLine()) != null) {   
           sTotalString += sCurrentLine + "\r\n";   
       }
       return sTotalString;
   }
   
   public static int findNameExist(String name){
	   int flag = 0;
	   StringBuffer xml = new StringBuffer();
	   xml.append("<cpc>");
	   xml.append("<operatetype>corpinfo</operatetype>");
	   xml.append("<operatecode>query</operatecode>");
	   xml.append("<operatename>").append(ServletActionContext.getServletContext().getInitParameter("operatename")).append("</operatename>"); 
	   xml.append("<operatepwd>").append(ServletActionContext.getServletContext().getInitParameter("operatepwd")).append("</operatepwd>");
	   xml.append("<operadata>");
	   xml.append("<corpname>").append(name==null?"":name).append("</corpname>");
	   xml.append("</operadata>");
	   xml.append("</cpc>");
	   
	 	try {
	   		System.out.println(xml.toString());
	   		String xmlstr = sendPost(xml.toString(),"corpinfo");
	   		if(xmlstr==null||xmlstr.equals("")){
				return 1;
			}
	   		
	   		String respcode ="";
	   		if(xmlstr!=null&&!xmlstr.equals("")){
				Document document = DocumentHelper.parseText(xmlstr); 
				respcode =document.selectSingleNode("cpc/respcode").getText();
	   		}
	   		if(respcode!=null&&respcode.equals("0000")){
				return 1;
			}else{
				return 0;
			}
	   		
	 	} catch (IOException e) {
			flag=2;
			e.printStackTrace();
		} catch (DocumentException e) {
			flag=2;
			e.printStackTrace();
		}
	   return flag;
   }
   
   //1.cpc不正确 2.企业名称和cpc不匹配 3.卖出类型不正确
   public static int findCompany(String cpccorp,String corpname,User user){
	   int flag = 0;
	   StringBuffer xml = new StringBuffer();
	   xml.append("<cpc>");
	   xml.append("<operatetype>corpinfo</operatetype>");
	   xml.append("<operatecode>query</operatecode>");
	   xml.append("<operatename>").append(ServletActionContext.getServletContext().getInitParameter("operatename")).append("</operatename>"); 
	   xml.append("<operatepwd>").append(ServletActionContext.getServletContext().getInitParameter("operatepwd")).append("</operatepwd>");
	   xml.append("<operadata>");
	   xml.append("<corpcpccode>").append(cpccorp==null?"":cpccorp).append("</corpcpccode>");
	   xml.append("</operadata>");
	   xml.append("</cpc>");
	   
	   	try {
	   		System.out.println(xml.toString());
	   		String xmlstr = sendPost(xml.toString(),"corpinfo");
	   		if(xmlstr==null||xmlstr.equals("")){
				return 1;
			}
	   		String respcode ="";
			String cpccorptemp ="";
			String corpnametemp="";
			String zyctypetemp="";
	   		if(xmlstr!=null&&!xmlstr.equals("")){
				Document document = DocumentHelper.parseText(xmlstr); 
				respcode =document.selectSingleNode("cpc/respcode").getText();
				cpccorptemp =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
				corpnametemp =document.selectSingleNode("cpc/operadata/corpname").getText(); 
				zyctypetemp = document.selectSingleNode("cpc/operadata/zyctype").getText();
				if(respcode==null||!respcode.equals("0000")||cpccorptemp==null||"".equals(cpccorptemp)||cpccorptemp.length()!=14){
					return 1;
				}	
				if(!corpname.equals(corpnametemp)){
					return 2;
				}
				String zyctype = user.getOrg().getZyctype();
					//种植
				if(zyctype.substring(0,1).equals("1")){
					if(zyctypetemp.substring(3,4).equals("1")){//饮片经销商-00010000
						return 3;
					}
					else if(zyctypetemp.substring(4,5).equals("1")){//市场-00001000
						return 3;
					}
					else if(zyctypetemp.substring(5,6).equals("1")){//医院-00000100
						return 3;
					}
					else if(zyctypetemp.substring(6,7).equals("1")){//管理机构-00000010
						return 3;
					}
					else if(zyctypetemp.substring(7,8).equals("1")){//其他-00000001
						return 3;
					}
					//药材经销
				}else if(zyctype.substring(1,2).equals("1")){
					if(zyctypetemp.substring(3,4).equals("1")){//饮片经销商-00010000
						return 3;
					}
					else if(zyctypetemp.substring(4,5).equals("1")){//市场-00001000
						return 3;
					}
					else if(zyctypetemp.substring(5,6).equals("1")){//医院-00000100
						return 3;
					}
					else if(zyctypetemp.substring(6,7).equals("1")){//管理机构-00000010
						return 3;
					}
					else if(zyctypetemp.substring(7,8).equals("1")){//其他-00000001
						return 3;
					}
					//饮片生产
				}else if(zyctype.substring(2,3).equals("1")){
					if(zyctypetemp.substring(0,1).equals("1")){//药材种植平台-10000000
						return 3;
					}
					else if(zyctypetemp.substring(1,2).equals("1")){//药材经销商-01000000
						return 3;
					}
					else if(zyctypetemp.substring(4,5).equals("1")){//市场-00001000
						return 3;
					}
					else if(zyctypetemp.substring(6,7).equals("1")){//管理机构-00000010
						return 3;
					}
					else if(zyctypetemp.substring(7,8).equals("1")){//其他-00000001
						return 3;
					}
					//饮片经销
				}else if(zyctype.substring(3,4).equals("1")){
					if(zyctypetemp.substring(0,1).equals("1")){//药材种植平台-10000000
						return 3;
					}
					else if(zyctypetemp.substring(1,2).equals("1")){//药材经销商-01000000
						return 3;
					}
					else if(zyctypetemp.substring(4,5).equals("1")){//市场-00001000
						return 3;
					}
					else if(zyctypetemp.substring(6,7).equals("1")){//管理机构-00000010
						return 3;
					}
					else if(zyctypetemp.substring(7,8).equals("1")){//其他-00000001
						return 3;
					}
					//药材市场
				}else if(zyctype.substring(4,5).equals("1")){
					if(zyctypetemp.substring(3,4).equals("1")){//饮片经销商-00010000
						return 3;
					}
					else if(zyctypetemp.substring(4,5).equals("1")){//市场-00001000
						return 3;
					}
					else if(zyctypetemp.substring(5,6).equals("1")){//医院-00000100
						return 3;
					}
					else if(zyctypetemp.substring(6,7).equals("1")){//管理机构-00000010
						return 3;
					}
					else if(zyctypetemp.substring(7,8).equals("1")){//其他-00000001
						return 3;
					}
				}
			}
		} catch (IOException e) {
			flag=4;
			e.printStackTrace();
		} catch (DocumentException e) {
			flag=4;
			e.printStackTrace();
		}
	   return flag;
   }
   
   public static String removeNullString(Object input) {
       String inputStr="";
      
       inputStr=(String)input;
       
       if(input== null)
           inputStr="";
       else if(input.equals("null"))
           inputStr="";
       else{
           inputStr = (String)input;
           inputStr= inputStr.replaceAll(" ", "");
       }
       return inputStr; 
   }
   
   public static Double dealNullDouble(Object obj,double dValue){
   	double values=0;
        try{
//            values=(Double)obj;
        	values=Double.parseDouble(obj.toString());
        }catch(Exception ex)
        {
            System.out.println("dealNullDouble:"+ex.getMessage());
            values=dValue;
        }
        return values;
   }
   
   public static int dealNullInt(Object obj,int i)
   {
       int values=0;
       try{
       	if(obj!=null){
       		String tmp = obj.toString();
       		values=Integer.parseInt(tmp);
       	}else{
       		values=i;
       	}
       }catch(Exception ex)
       {
           ex.printStackTrace();
           values=i;
       }
       return values;
   }
   
   
   
   //创建分包列表数据
   public static List<TabletStorage> createStoragePack(String packStr,TabletStorage storage)
   {
	   List<TabletStorage> list=null;
	   if(!"".equals(removeNullString(packStr)))
	   {
		   String[] assArr=packStr.split("\\|");
		   if(assArr!=null&&assArr.length>0)
		   {
			   list=new ArrayList<TabletStorage>();
			   for(String m:assArr)
			   {
					String[] ass=m.split("\\~");
					TabletStorage vo=new TabletStorage();					
					Tools.setVOToVO(storage, vo);
					vo.setUserid(null);
					vo.setTablettype(1);//已分包状态
					vo.setTabletnumweight(Double.parseDouble(ass[0]));//规格
					vo.setTabletnum(Integer.parseInt(ass[1]));//饮片包数
					vo.setTabletweight(Double.parseDouble(ass[2]));//总重量
					vo.setTabletboxitemnum(Integer.parseInt(ass[3]));//每箱包数
					vo.setTabletboxnum(Integer.parseInt(ass[4]));//箱数
					list.add(vo);
			   }
		   }			
	   }
	   
	   return list;
   }
   
   public static String xmlCpcMed_local(String cpcCorp, String basecode){
	   String method="";
	   method+="273"+cpcCorp.substring(6,13)+basecode;
	   method+=Tools.getCheckCode(method);
	   return method;
   }
   
   public static String xmlCpcMed(String cpcCorp, String basecode){
		String method="";
    	method+="<?xml version=\"1.0\" encoding=\"utf-8\"?>"; 
		method += "<cpc>";
		method += "<operatetype>zcyprodinfo</operatetype>";
		method += "<operatecode>insert</operatecode>";
		method += "<operatename>"+ServletActionContext.getServletContext().getInitParameter("operatename")+"</operatename>";
		method += "<operatepwd>"+ServletActionContext.getServletContext().getInitParameter("operatepwd")+"</operatepwd>";
		
		method += "<operadata>";
		method += "<corpcpccode>"+cpcCorp+"</corpcpccode>";
		method += "<prodcode>"+basecode+"</prodcode>";
		method += "</operadata>";
		method += "</cpc>";
		
		return method;
   }
   
   
   public static String xmlCpcTablet(String cpcCorp, String tabletName){
	   String method="";
	   method+="<?xml version=\"1.0\" encoding=\"utf-8\"?>"; 
		method += "<cpc>";
		method += "<operatetype>prodinfo</operatetype>";
		method += "<operatecode>insert</operatecode>";
		method += "<operatename>"+ServletActionContext.getServletContext().getInitParameter("operatename")+"</operatename>";
		method += "<operatepwd>"+ServletActionContext.getServletContext().getInitParameter("operatepwd")+"</operatepwd>";
		
		method += "<operadata>";
		method += "<corpcpccode>"+cpcCorp+"</corpcpccode>";
		method += "<prodname>"+tabletName+"</prodname>";
		method += "<prodenname></prodenname>";
		method += "<prodintro></prodintro>";
		method += "<prodsize></prodsize>";
		method += "<prodcountry></prodcountry>";
		method += "<submitdate></submitdate>"; 
		method += "<updatedate></updatedate>";
		method += "</operadata>";
		method += "</cpc>";
		
		return method;
  }
   
   
   //创建分包列表数据
   public static List<MedStorage> createMedStoragePack(String packStr,MedStorage storage)
   {
	   List<MedStorage> list=null;
	   if(!"".equals(removeNullString(packStr)))
	   {
		   String[] assArr = packStr.split("\\|");
		   if(assArr != null && assArr.length > 0)
		   {
			   list = new ArrayList<MedStorage>();
			   for(String m:assArr)
			   {
					String[] ass = m.split("\\~");
					MedStorage vo=new MedStorage();					
					Tools.setVOToVO(storage, vo);
					vo.setUserid(null);
					vo.setMedtype(1);//已分包状态
					vo.setMednumweight(Double.parseDouble(ass[1]));//规格 变成g以下一位
					vo.setMednum(Integer.parseInt(ass[2]));//药材包数
					vo.setMedweight(Double.parseDouble(ass[0]));//库存重量
					//vo.setChangemedweight(vo.getMedweight());//实际库存重量
					list.add(vo);
			   }
		   }			
	   }
	   
	   return list;
   }
   

 //药材出库拆分
   public static List<InOutStorBox> inOutStorageMedPack(String packStr,Integer orgid)
   {
	   List<InOutStorBox> list=null;
	   if(!"".equals(removeNullString(packStr)))
	   {
		   String[] assArr=packStr.split("\\|");
		   if(assArr!=null&&assArr.length>0)
		   {
			   list=new ArrayList<InOutStorBox>();
			   for(String m:assArr)
			   {
					String[] ass=m.split("\\~");
					InOutStorBox vo = new InOutStorBox();
					vo.setProdname(ass[0]);  //name
					vo.setBatchcpc(ass[1]);	//cpc
					vo.setBoxnum(Integer.parseInt(ass[2])); 		//packnum
					vo.setBoxnumweight(Double.parseDouble(ass[3])); 	//weight
					vo.setTotalweight(Double.parseDouble(ass[4]));	//weightall
					if(!"".equals(removeNullString(ass[5]))){
						vo.setRealtotalweight(Double.parseDouble(ass[5])); //weightreal
					}
					if(!"".equals(removeNullString(ass[6])) ){
						vo.setPrice(Double.parseDouble(ass[6]));		//unitprice
					}
					if(!"".equals(removeNullString(ass[7]))){
						vo.setTotalmoney(Double.parseDouble(ass[7]));	//totalprice
					}
					vo.setKeyname(ass[8]);
					list.add(vo);					
			   }
		   }			
	   }
	   
	   return list;
   }

   
   //饮片出库拆分
   public static List<InOutStorBox> inOutStorageTabletPack(String packStr,Integer orgid)
   {
	   List<InOutStorBox> list=null;
	   if(!"".equals(removeNullString(packStr)))
	   {
		   String[] assArr=packStr.split("\\|");
		   if(assArr!=null&&assArr.length>0)
		   {
			   list=new ArrayList<InOutStorBox>();
			   for(String m:assArr)
			   {
					String[] ass=m.split("\\~");
					InOutStorBox vo = new InOutStorBox();
					vo.setProdname(ass[0]);  //name
					vo.setBatchcpc(ass[1]);	//cpc
					vo.setBoxnumweight(Double.parseDouble(ass[2]));//规格		
					vo.setBoxitemnum(Integer.parseInt(ass[3]));
					vo.setBoxnum(Integer.parseInt(ass[4])); 		//箱数
					vo.setTotalweight(Double.parseDouble(ass[5]));	//weightall		
					vo.setRealtotalweight(Double.parseDouble(ass[5]));
					if(!"".equals(removeNullString(ass[6]))){
						vo.setPrice(Double.parseDouble(ass[6]));		//unitprice
					}
					if(!"".equals(removeNullString(ass[7]))){
						vo.setTotalmoney(Double.parseDouble(ass[7]));	//totalprice
					}
					vo.setKeyname(ass[8]);
					
					list.add(vo);					
			   }
		   }			
	   }
	   
	   return list;
   }
   
   public static Map createInStorResult(String inXml,Integer type)
   {

	   Map<String, Object> map=new HashMap<String, Object>();
	   List<InStorFailCode> failList=new ArrayList<InStorFailCode>();
	   List<InStorSuccessCode> succList=new ArrayList<InStorSuccessCode>();
	   try{
//			SAXReader reader = new SAXReader();
//			Document doc = reader.read(Tools.class.getResourceAsStream("/"+inXml));
			Document doc = DocumentHelper.parseText(inXml);
			Element root = doc.getRootElement();
		
			//成功列表                                     
			List<Node> succcodes = root.selectNodes("msgbody/result/successcodes/sourcecode");
			if(succcodes!=null&&succcodes.size()>0)
			{
				for(int i = 0 ; i < succcodes.size() ; i++){
					//成功溯源码
					if("true".equals(succcodes.get(i).valueOf("@success").toString()))
					{
						InStorSuccessCode succ=new InStorSuccessCode();
						succ.setCode(succcodes.get(i).selectSingleNode("code").getText().toString());
						int codeType=Tools.dealNullInt(succ.getCode().substring(0, 1), 0);
						if(codeType!=8){
							succ.setBatchno(succcodes.get(i).selectSingleNode("batchno").getText().toString());
							succ.setAreacode(succcodes.get(i).selectSingleNode("areacode").getText().toString());
							succ.setLasttime(succcodes.get(i).selectSingleNode("lasttime").getText().toString());
							succ.setPcode(succcodes.get(i).selectSingleNode("pcode").getText().toString());
							succ.setPname(succcodes.get(i).selectSingleNode("pname").getText().toString());
							succ.setSpec(succcodes.get(i).selectSingleNode("spec").getText().toString());
							String weight = succcodes.get(i).selectSingleNode("weight").getText();
							if(weight!=null&&!"".equals(weight)){
								succ.setWeight(succcodes.get(i).selectSingleNode("weight").getText());
							}else{
								succ.setWeight("0");
							}
							//饮片
							if(type==1)
							{
								String boxitemnum = succcodes.get(i).selectSingleNode("boxitemnum").getText();
								if(boxitemnum!=null&&!"".equals(boxitemnum)){
									succ.setBoxitemnum(succcodes.get(i).selectSingleNode("boxitemnum").getText());
									succ.setBoxnum(1);
								}else{
									succ.setBoxitemnum("0");
								}
								//获取箱码
								List<Node> boxs = root.selectNodes("msgbody/result/successcodes/boxs/box");														
								String boxsCode="";
								if(boxs!=null&&boxs.size()>0){
									for(int j=0;j<boxs.size();j++){
										boxsCode+=boxs.get(j).selectSingleNode("code").getText().toString();
										if(j!=boxs.size()-1){
											boxsCode+=";";
										}
									}					
									succ.setBoxsCode(boxsCode);
									succ.setBoxnum(boxs.size());
								}
							}
							succList.add(succ);
						}else{
							succ.setLasttime(succcodes.get(i).selectSingleNode("lasttime").getText().toString());
							
							double totalWeight=0.0;
							//获取箱码
							List<Node> boxs = root.selectNodes("msgbody/result/successcodes/sourcecode/boxs/box");														
							if(boxs!=null&&boxs.size()>0){
								for(int j=0;j<boxs.size();j++){
									InStorSuccessCode child=new InStorSuccessCode();
									child.setCode(boxs.get(j).selectSingleNode("code").getText().toString());
									child.setBatchno(boxs.get(j).selectSingleNode("batchno").getText().toString());
									child.setAreacode(boxs.get(j).selectSingleNode("areacode").getText().toString());
									child.setPcode(boxs.get(j).selectSingleNode("pcode").getText().toString());
									child.setPname(boxs.get(j).selectSingleNode("pname").getText().toString());
									child.setSpec(boxs.get(j).selectSingleNode("spec").getText().toString());
									String weight_child = boxs.get(j).selectSingleNode("weight").getText();
									if(weight_child!=null&&!"".equals(weight_child)){
										child.setWeight(boxs.get(j).selectSingleNode("weight").getText());
									}else{
										child.setWeight("0");
									}
									String boxitemnum_child = boxs.get(j).selectSingleNode("boxitemnum").getText();
									if(boxitemnum_child!=null&&!"".equals(boxitemnum_child)){
										child.setBoxitemnum(boxs.get(j).selectSingleNode("boxitemnum").getText());
										child.setBoxnum(1);
									}else{
										child.setBoxitemnum("0");
									}
									succ.getChildList().add(child);
									
									double allweight=Tools.multiply(child.getWeight(), child.getBoxitemnum());
									//规格*包数
									totalWeight=Tools.addtr(totalWeight+"",allweight+"");
								}					
								
							}
							succ.setWeight(totalWeight+"");
							succList.add(succ);
						}
						
						
						
					}else{
						InStorFailCode fail=new InStorFailCode();
						fail.setCode(succcodes.get(i).selectSingleNode("code").getText().toString());
						fail.setReason(succcodes.get(i).selectSingleNode("reason").getText().toString());
						fail.setOriownercpc(succcodes.get(i).selectSingleNode("oriownercpc").getText().toString());
						fail.setNewownercpc(succcodes.get(i).selectSingleNode("newownercpc").getText().toString());
						failList.add(fail);
					}				
				}				
			}
			
			map.put("succList", succList);
			map.put("failList", failList);

		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return map;
   }
   
   /**
	 * @param res
	 *            源字符串
	 * @return md5值
	 */
	public final static String MD5(String res)
	{
		char hexDigits[] =
		{ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
				'e', 'f' };
		try
		{
			byte[] strTemp = res.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++)
			{
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			String result = new String(str);
			return result;
		} catch (Exception e)
		{
			return null;
		}
	}
	
	public static String scienceToString(Double d){
		NumberFormat formatter=NumberFormat.getNumberInstance(); 
		formatter.setMaximumFractionDigits(30);
		return formatter.format(d).replaceAll(",","");
	}
	
	public static List<InStorFailCode>  setFailCodes(List<String> codeList,List<InStorFailCode> failList){		
		for(String code:codeList){
			InStorFailCode instor=new InStorFailCode();
			instor.setReason("0");
			instor.setCode(code);
			failList.add(instor);
		}
			
		return failList;
	}
	
	public static void setFreezes(InOutStor form,List<Freeze> freezeList,List<InStorFailCode> failList){
		
		if(freezeList!=null&&freezeList.size()>0){
			for(Freeze freeze:freezeList){
				
				InStorFailCode instor = new InStorFailCode();				
				instor.setCode(freeze.getCpccode());
				instor.setReason(freeze.getCpclevel()+freeze.getReason());			
				failList.add(instor);
				//删除锁定溯源码
				if(form.getBoxcodes().indexOf(freeze.getCpccode()+"BR")!=-1){					
					form.setBoxcodes(form.getBoxcodes().replaceAll(freeze.getCpccode()+"BR", ""));				
				}		
			}
		}
		//去掉最后一个BR符号
		int index=form.getBoxcodes().lastIndexOf("BR");
		if(index!=-1&&index==form.getBoxcodes().length()-2){
			form.setBoxcodes(form.getBoxcodes().substring(0,form.getBoxcodes().length()-2));
		}
	}
	
	 public static void printJson(HttpServletResponse response,String json)
		{
		 	System.out.println(json);
			PrintWriter out = null;
			try{				
				response.setContentType("text/javascript;charset=UTF-8");
		        response.setHeader("Cache-Control","no-store, max-age=0, no-cache, must-revalidate");     
		        response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		        response.setHeader("Pragma", "no-cache"); 
		        
				out=response.getWriter();
						
				out.print(json);
				
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}finally{
				out.flush();
				out.close();
			}
		}
	 
	 /**
	  * 注册企业,组织结构的xml
	  * @param form 公司实体
	  * @param operType xml类型  insert update
	  * @param areaCode 区域编码
	  * @param ComOrOrg 注册的是公司还是组织 0公司 1组织
	  * @param marketcode 商户所属市场的cpc  注册商户时候,此值为市场用户的cpc,其余时候此值为空
	  * @@param supercpccode 在注册组织时候的企业cpc码
	  * @return
	  */
	 public static String xmlRegister(Object form , String operType ,String areaCode,int ComOrOrg,String marketcode,String supercpccode,List<OrgUpload> orgUploads){
		 	String method="";
	    	method+="<?xml version=\"1.0\" encoding=\"utf-8\"?>"; 
			method += "<cpc>";
			method += "<operatetype>corpinfo</operatetype>";
			method += "<operatecode>"+operType+"</operatecode>";
			method += "<operatename>"+ServletActionContext.getServletContext().getInitParameter("operatename")+"</operatename>";
			method += "<operatepwd>"+ServletActionContext.getServletContext().getInitParameter("operatepwd")+"</operatepwd>";
			
			method += "<operadata>";
			
			if("update".equals(operType)){
				if(ComOrOrg == 0){
					method += "<corpcpccode>" + ((Company)form).getCpccorp() + "</corpcpccode>";
				}else{
					method += "<corpcpccode>" + ((Org)form).getCpccorp() + "</corpcpccode>";
				}
			}
			
			if(ComOrOrg == 0){
				method += "<zyctype>"+((Company)form).getZyctype()+"</zyctype>";
				method += "<corpname>"+((Company)form).getCorpname()+"</corpname>";
				method += "<corpshortname>"+((Company)form).getCorpshortname()+"</corpshortname>";
				method += "<linkman>"+((Company)form).getLinkman()+"</linkman>";
				method += "<master>"+((Company)form).getMasterman()+"</master>";
				method += "<identitycard>"+((Company)form).getIdentitycard()+"</identitycard>";
				method += "<orgcode>"+((Company)form).getOrgcode()+"</orgcode>";
				method += "<businesscode>"+((Company)form).getBusinesscode()+"</businesscode>";
				method += "<mobile>"+((Company)form).getMobile()+"</mobile>";
				method += "<telephone>"+((Company)form).getTelephone()+"</telephone>";
				method += "<officephone>"+((Company)form).getOfficephone()+"</officephone>";
				method += "<email>"+((Company)form).getEmail()+"</email>";
				method += "<postcode>"+((Company)form).getPostcode()+"</postcode>";
				method += "<gapcode>"+(((Company)form).getGapcode()==null?"":((Company)form).getGapcode())+"</gapcode>";
				method += "<gmpcode>"+(((Company)form).getGmpcode()==null?"":((Company)form).getGmpcode())+"</gmpcode>";
				method += "<gspcode>"+(((Company)form).getGspcode()==null?"":((Company)form).getGspcode())+"</gspcode>";
				method += "<registeraddress>"+((Company)form).getRegisteraddress()+"</registeraddress>";
				method += "<longitude>"+((Company)form).getLongitude()+"</longitude>";	
				method += "<latitude>"+((Company)form).getLatitude()+"</latitude>";	
			}else{
				method += "<zyctype>"+((Org)form).getZyctype()+"</zyctype>";
				method += "<corpname>"+((Org)form).getOrgname()+"</corpname>";
				method += "<corpshortname>"+((Org)form).getOrgshortname()+"</corpshortname>";
				method += "<linkman>"+((Org)form).getLinkman()+"</linkman>";
				method += "<master>"+((Org)form).getMasterman()+"</master>";
				method += "<identitycard>"+((Org)form).getIdentitycard()+"</identitycard>";
				method += "<orgcode>"+((Org)form).getOrgcode()+"</orgcode>";
				method += "<businesscode>"+((Org)form).getBusinesscode()+"</businesscode>";
				method += "<mobile>"+((Org)form).getMobile()+"</mobile>";
				method += "<telephone>"+((Org)form).getTelephone()+"</telephone>";
				method += "<officephone>"+((Org)form).getOfficephone()+"</officephone>";
				method += "<email>"+((Org)form).getEmail()+"</email>";
				method += "<postcode>"+((Org)form).getPostcode()+"</postcode>";
				method += "<gapcode>"+(((Org)form).getGapcode()==null?"":((Org)form).getGapcode())+"</gapcode>";
				method += "<gmpcode>"+(((Org)form).getGmpcode()==null?"":((Org)form).getGmpcode())+"</gmpcode>";
				method += "<gspcode>"+(((Org)form).getGspcode()==null?"":((Org)form).getGspcode())+"</gspcode>";
				method += "<registeraddress>"+((Org)form).getRegisteraddress()+"</registeraddress>";	
				method += "<longitude>"+((Org)form).getLongitude()+"</longitude>";	
				method += "<latitude>"+((Org)form).getLatitude()+"</latitude>";	
			}
		
			method += "<sendcard></sendcard>";
			if(marketcode == null){
				method += "<marketcode></marketcode>";//非市场商户注册,此值为空
				method += "<partion></partion>";
				method += "<coordinate></coordinate>";
			}else{
				method += "<marketcode>"+marketcode+"</marketcode>";//市场商户注册,此值为该市场用户的cpc
				if(ComOrOrg == 0){
					method += "<partion>"+((Company)form).getPartion()+"</partion>";
					method += "<coordinate>"+((Company)form).getCoordinate()+"</coordinate>";
				}else{
					method += "<partion>"+((Org)form).getPartion()+"</partion>";
					method += "<coordinate>"+((Org)form).getCoordinate()+"</coordinate>";
				}
			}
			method += "<businessnumber></businessnumber>";
			method += "<zscnumber></zscnumber>";
			method += "<area>"+areaCode+"</area>";
			if(ComOrOrg == 0){
				method += "<supercpccode></supercpccode>";//注册企业时,此值为空
			}else{
				method += "<supercpccode>"+supercpccode+"</supercpccode>";//注册企业所属组织机构时,此值所在企业的cpc编码
			}
			
			
			if(orgUploads != null && orgUploads.size() > 0){
				String otherurl="";
				for(OrgUpload orgUpload : orgUploads){
					String cont = orgUpload.getUploadcontent();
					cont = cont.substring(cont.length()-3,cont.length());
	    			System.out.println(cont);
					if(orgUpload.getUploadtype() == 1){
						if(cont.equals("jpg")||cont.equals("gif")||cont.equals("png")||cont.equals("bmp")){
			    			method += "<bussinesscodeurl>"+ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage.shtml?uploadcontent="+orgUpload.getUploadcontent()+"</bussinesscodeurl>";
			    		}else{
			    			method += "<bussinesscodeurl>"+ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage!getOrgUploadImageFile.shtml?uploadcontent="+orgUpload.getUploadcontent()+"</bussinesscodeurl>";
			    		}
					}else if(orgUpload.getUploadtype() == 2){
						if(cont.equals("jpg")||cont.equals("gif")||cont.equals("png")||cont.equals("bmp")){
			    			method += "<orgcodeurl>"+ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage.shtml?uploadcontent="+orgUpload.getUploadcontent()+"</orgcodeurl>";
			    		}else{
			    			method += "<orgcodeurl>"+ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage!getOrgUploadImageFile.shtml?uploadcontent="+orgUpload.getUploadcontent()+"</orgcodeurl>";
			    		}
					}else{
						otherurl = "<otherurl>";
						if(cont.equals("jpg")||cont.equals("gif")||cont.equals("png")||cont.equals("bmp")){
							otherurl += ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage.shtml?uploadcontent="+orgUpload.getUploadcontent()+";";
			    		}else{
			    			otherurl += ServletActionContext.getServletContext().getInitParameter("domainname")+"orgUploadImage.shtml?getOrgUploadImageFile="+orgUpload.getUploadcontent()+";";
			    		}
					}
				}
				if(otherurl.lastIndexOf(";") > -1){
					otherurl = otherurl.substring(0, otherurl.length()-1);
					otherurl += "</otherurl>";
				}
				
				method += otherurl;
			}else{
				method += "<bussinesscodeurl></bussinesscodeurl>";
				method += "<orgcodeurl></orgcodeurl>";
				method += "<otherurl></otherurl>";
			}
			
			method += "</operadata>";
			method += "</cpc>";
			
			return method;
	 }
	 
	 public static String getRealIp(HttpServletRequest req) {  		  
		    String ip = req.getHeader("X-Forwarded-For");  	  
		    if (ip != null) {  
		        if (ip.indexOf(',') == -1) {  
		            return ip;  
		        }  
		        return ip.split(",")[0];  
		    }  		  
		    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		        ip = req.getHeader("Proxy-Client-IP");  
		    }  
		    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		        ip = req.getHeader("WL-Proxy-Client-IP");  
		    }  
		    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		        ip = req.getRemoteAddr();  
		    }  
		  
		    return ip;  
		}  
	 
	 
	 //文件转成byte
	 public static byte[] getBytesFromFile(File file) throws IOException {
         //file size
         long length = file.length();
         InputStream is = null;
         is = new BufferedInputStream(new FileInputStream(file));
         if (length > Integer.MAX_VALUE) {
              throw new IOException("File is to large " + file.getName());
         }
         byte[] bytes = new byte[(int) length];
         int offset = 0;
         int numRead = 0;
         while (offset < bytes.length && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
              offset += numRead;
         }
          if (offset < bytes.length) {
                  throw new IOException("Could not completely read file " + file.getName());
         }
         is.close();
         return bytes;

   }
	 /**
	  * 企业,组织机构注册更新的返回信息
	  * @param respcode
	  * @param returninfo
	  * @return
	  */
	 public static String getReturnInfo(String respcode,String returninfo){
		 if (respcode.equals("0001")) {
				returninfo += " 接入网站ip非法,IP地址在正式环境中要设置，只允许设置的IP地址列表访问系统!";
			}else if (respcode.equals("0002")) {
				returninfo += " 渠道商的用户名或密码错误!";
			}else if (respcode.equals("0003")) {
				returninfo += " 状态码-operatecode不存在!";
			}else if (respcode.equals("0004")) {
				returninfo += " 请求的报文信息不全!";
			}else if (respcode.equals("0005")) {
				returninfo += " 系统运行时异常!";
			}else if (respcode.equals("0006")) {
				returninfo += " 新增信息二次添加,不做处理!";
			}else if (respcode.equals("0007")) {
				returninfo += " 公司CPC码错误!";
			}else if(respcode.equals("0008")){
				returninfo+=" 公司类型不正确，只能是一种类型!";
			}else if (respcode.equals("0009")) {
				returninfo += " （中草药）的产品编码不正确!";
			}else if (respcode.equals("0010")) {
				returninfo += " 产品CPC码不存在!";
			}
		 	return returninfo;
	 }
	 
	 /**
	  * 获取2个时间之间的分钟差
	  * @param endtime
	  * @param startTime
	  * @return
	  */
	 public static long diffTime(String endtime,String startTime){
		 long minute=0l;
		 try{
			 DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			 Date d1 = df.parse(endtime);
			 Date d2 = df.parse(startTime);
			 long diff = d1.getTime() - d2.getTime();  
			 minute = diff / (1000 * 60);
		 }catch(Exception ex){
			 ex.printStackTrace();
		 }
		 	return minute;
	 }
	 
     /**
      * 加密
      * 
      * @param content 需要加密的内容,长度必须为16的整数倍
      * @param password  key、iv 长度必须为16
      * @return
      */
     public static String encrypt(String content, byte[] key,byte[] iv) {
             try {           
            	 SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
            	 IvParameterSpec ivSpec = new IvParameterSpec(iv);    
            	 Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
            	 cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
                 byte[] result = cipher.doFinal(content.getBytes("GB2312"));
                 return Base16.encode(result); // 加密
             } catch (NoSuchAlgorithmException e) {
                     e.printStackTrace();
             } catch (NoSuchPaddingException e) {
                     e.printStackTrace();
             } catch (InvalidKeyException e) {
                     e.printStackTrace();
             } catch (UnsupportedEncodingException e) {
                     e.printStackTrace();
             } catch (IllegalBlockSizeException e) {
                     e.printStackTrace();
             } catch (BadPaddingException e) {
                     e.printStackTrace();
             } catch (InvalidAlgorithmParameterException e) {
				e.printStackTrace();
			}
             return null;
     }
     
     /**解密
      * @param content  待解密内容，长度必须为16的整数倍
      * @param password 解密密钥，key、iv 长度必须为16
      * @return
      */
     public static String decrypt(String content, byte[] key,byte[] iv) {
             try {
            	 SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
            	 IvParameterSpec ivSpec = new IvParameterSpec(iv);    
            	 Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
            	 cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
                 byte[] result = cipher.doFinal(Base16.decode(content));
                 return new String(result,"GB2312"); // 加密
             } catch (NoSuchAlgorithmException e) {
                     e.printStackTrace();
             } catch (NoSuchPaddingException e) {
                     e.printStackTrace();
             } catch (InvalidKeyException e) {
                     e.printStackTrace();
             } catch (IllegalBlockSizeException e) {
                     e.printStackTrace();
             } catch (BadPaddingException e) {
                     e.printStackTrace();
             } catch (InvalidAlgorithmParameterException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
             return null;
     }
     
     /**将二进制转换成16进制
      * @param buf
      * @return
      */
     public static String parseByte2HexStr(byte buf[]) {
             StringBuffer sb = new StringBuffer();
             for (int i = 0; i < buf.length; i++) {
                     String hex = Integer.toHexString(buf[i] & 0xFF);
                     if (hex.length() == 1) {
                             hex = '0' + hex;
                     }
                     sb.append(hex.toUpperCase());
             }
             return sb.toString();
     }
     
     /**将16进制转换为二进制
      * @param hexStr
      * @return
      */
     public static byte[] parseHexStr2Byte(String hexStr) {
             if (hexStr.length() < 1)
                     return null;
             byte[] result = new byte[hexStr.length()/2];
             for (int i = 0;i< hexStr.length()/2; i++) {
                     int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);
                     int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);
                     result[i] = (byte) (high * 16 + low);
             }
             return result;
     }
     
     public static void main(String[] args) throws UnsupportedEncodingException{
//         String content = "{\"commandid\":\"1\",\"loginname\":\"yaocaimarket\",\"loginpass\":\"1231手\"}000000000000000";
//         byte[] key = "1234567812345678".getBytes("UTF-8");
//         byte[] iv = "fedcba9876543210".getBytes("UTF-8");
//         //加密
//         System.out.println("加密前：" + content);
//         String c = encrypt(content,key,iv);
//         System.out.println("加密后：" + c);
//         //解密
//         System.out.println("解密后：" + decrypt(c,key,iv));
    	 
    	 //int a = cipherJudgement("123456789012345==============");
    	 //System.out.println(a);
    	 
    	 //System.out.println(cipherCutoff("1234567890123\"}========"));
     }
     
     public static String cipherPadding(String content){
         int pad = content.length()%16;
         if (0!=pad){
        	 for(int i=0;i<(16-pad);i++){
            	 content+="=";
             }
         }
         return content;
     }
     
     public static String cipherCutoff(String content){
    	 int num = content.indexOf("\"}=")+3;
    	 int length = content.length();
         if(num==-1){
        	 return "false";
         }
         if(length!=num){
        	int numsub = num;
        	int flag = 0 ;
        	for(int i=0;i<content.length()-num;i++){
        		if(!content.substring(numsub,numsub+1).equals("=")){
        			flag=1;
        			break;
        		}
        		numsub=numsub+1;
        	}
        	if(flag==1){
        		return "false";
        	}
         }
         return content.substring(0,num-1);
     }
     
     public static boolean cipherJudgement(String content){
         int pad = content.length()%16;
         if (0==pad){
             return true;
         }else{
        	return false; 
         }
     }
     
     public static  String addMonth(String cur_time,int m)  
	 	{		
	 		String str="";	
	 		try{
	 			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");		
	 			Calendar c = Calendar.getInstance();
	 			c.setTime(df.parse(cur_time));
	 			c.add(Calendar.MONTH, m);	//传入时间增加月份	  						  			  
	 			Date date = c.getTime();			  		 			  
	 			str=df.format(date);  
	 		}catch(Exception e)
	 		{
	 			e.printStackTrace();
	 		}	
	 		
	 		return str;  
	 	}
     
     public  static String lastDayOfMonth(String cur_time) {
    	 String lasday="";
    	 try{
    		 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
             Calendar cal = Calendar.getInstance();
             cal.setTime(df.parse(cur_time));
             int value = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
             cal.set(Calendar.DAY_OF_MONTH, value);
             lasday=df.format(cal.getTime());
    	 }catch(Exception e){
    		 e.printStackTrace();
    	 }
    	 System.out.println(lasday);
         return lasday;
     }
}

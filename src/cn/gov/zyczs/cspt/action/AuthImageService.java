package cn.gov.zyczs.cspt.action;

import java.awt.Color;   
import java.awt.Font;   
import java.awt.Graphics;   
import java.awt.image.BufferedImage;   
import java.io.ByteArrayOutputStream;   
import java.io.IOException;   
import java.util.Random;   
   
import javax.imageio.ImageIO;   
import javax.imageio.stream.ImageOutputStream;   
   
   
public class AuthImageService {   
       
	/**  
     * 默认验证字符串  
     */   
    String Default_ValidateCode = "ABCDEFGHJKLMNPRSTUVWXYZ23456789";   
    /**  
     * 默认绘制干扰线的类型（不绘制干扰线）  
     */   
    static int Disturb_Type_Default = 0;   
    /**  
     * 绘制单一色调的干扰线  
     */   
    static int Disturb_Type_Simple = 1;   
    /**  
     * 绘制复杂的干扰线  
     */   
    static  int Disturb_Type_Complex = 2;   
       

    public String createValidateCode(int disturbType, int fontSize, ByteArrayOutputStream bos, int width, int height, String validateCode,int codeLength){   
        BufferedImage bImg = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);   
        Graphics g = bImg.getGraphics();   
        Random random = new Random();   
           
        if(null == validateCode || validateCode.trim().equals("")){   
            validateCode = Default_ValidateCode;   
        }   
        if(fontSize >= height){   
            fontSize = height-1;   
        }   
           
        drawOutline(g,width,height);   
        switch (disturbType) {   
        case 1:   
            drawSimpleDisturb(g,random,width,height);   
            break;   
        case 2:   
            drawDisturb(g,random,width,height);   
            break;   
        default:   
            break;   
        }   
           
        String code = drawCode(g,random,validateCode,codeLength,width,height,fontSize);   
        g.dispose();   
        try {                 
            ImageOutputStream   imOut   =ImageIO.createImageOutputStream(bos);     
            ImageIO.write(bImg,"JPEG",imOut);   
            imOut.close();   
        } catch (IOException e) {   
            e.printStackTrace();   
        }   
        return code;   
    }   
       
    /**  
     * 绘制边框  
     * @param g  
     * @param width  
     * @param height  
     */   
    private static void drawOutline(Graphics g, int width, int height){   
        g.setColor(Color.white);   
        g.fillRect(0,0,width,height);   
        g.setColor(Color.BLACK);   
        g.drawRect(0,0,width-1,height-1);   
    }   
       
    /**  
     * 绘制比较复杂的干扰线  
     * @param g  
     * @param random  
     * @param width  
     * @param height  
     */   
    private static void drawDisturb(Graphics g, Random random, int width, int height){   
        int x,y,x1,y1;   
        for(int i=0;i<width;i++){   
            x = random.nextInt(width);   
            y = random.nextInt(height);   
            x1 = random.nextInt(24);   
            y1 = random.nextInt(24);   
            g.setColor(getRandomColor(random,255,255));   
            g.drawLine(x,y,x+x1,y+y1);   
            g.fillArc(x,y,x1,y1,random.nextInt(360),random.nextInt(360));   
        }   
    }   
       
    /**  
     * 绘制简单的干扰线  
     * @param g  
     * @param random  
     * @param width  
     * @param height  
     */   
    private static void drawSimpleDisturb(Graphics g, Random random, int width, int height){   
        g.setColor(getRandomColor(random,200,255));  //160,200 
        for (int i=0;i<200;i++)   //155
        {   
            int x = random.nextInt(width);   
            int y = random.nextInt(height);   
                int xl = random.nextInt(12);  //12 
                int yl = random.nextInt(12);  //12
            g.drawLine(x,y,x+xl,y+yl);   
        }   
    }   
       
    /**  
     * 取得随机颜色  
     * @param random  
     * @param pMin  
     * @param pMax  
     * @return  
     */   
    private static Color getRandomColor(Random random, int pMin,int pMax){   
        pMax = (Math.abs(pMax) > 255 ? 255 : Math.abs(pMax));   
        pMin = (Math.abs(pMin) > 255 ? 255 :Math.abs(pMin));   
       
        int r = pMin + random.nextInt(Math.abs(pMax - pMin));   
        int g = pMin + random.nextInt(Math.abs(pMax - pMin));   
        int b = pMin + random.nextInt(Math.abs(pMax - pMin));   
       
        return new Color(r,g,b);   
    }    
       
    /**  
     * 绘制验证码  
     * @param g  
     * @param random  
     * @param validateCode  
     * @param codeLength  
     * @param width  
     * @param height  
     * @param fontSize  
     * @return  
     */   
    private static String drawCode(Graphics g, Random random, String validateCode,int codeLength, int width, int height, int fontSize){    
        int validateCodeLength = validateCode.length();   
        Font font2 = new Font("Birch Std",Font.BOLD,fontSize);   
        Font font1 = new Font("Brush Script Std",Font.BOLD,fontSize);   
           
        StringBuffer sb = new StringBuffer();        
        int x,y;   
        for(int i=0;i<codeLength;i++){   
            x = (width/codeLength-1) * i + random.nextInt(width/(codeLength * 2));   
            y = random.nextInt(height - fontSize) + fontSize;   
            sb.append(getRandomChar(validateCode,validateCodeLength,random));   
            g.setColor(getRandomColor(random,70,255));   
            if(sb.substring(i).getBytes().length > 1)   
            g.setFont(font2);   
            else   
            g.setFont(font1);   
            g.drawString(sb.substring(i),x,y);   
        }   
        return sb.toString();        
    }   
    


    
    /**  
     * 取得随机字符  
     * @param validateCode  
     * @param validateCodeLength  
     * @param random  
     * @return  
     */   
    private static char getRandomChar(String validateCode,int validateCodeLength,Random random){   
        return validateCode.charAt(random.nextInt(validateCodeLength));   
    }   
}   


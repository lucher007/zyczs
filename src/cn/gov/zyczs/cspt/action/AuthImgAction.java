package cn.gov.zyczs.cspt.action;

import java.io.ByteArrayInputStream;   
import java.io.ByteArrayOutputStream;   
import java.io.IOException;   
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;   
    


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("unchecked")
public class AuthImgAction extends ActionSupport{   
    
    private static final long serialVersionUID = 6894525175454169331L;   
   
    private static final String Default_ValidateCode = "ABCDEFGHJKLMNPRSTUVWXYZ23456789";   
          
    private int width;   
    private int height;   
    private int fontSize;   
    private int codeLength;   
    private String contentType;
    InputStream inputStream;    
    
        
    public AuthImgAction(){   
        this.contentType = "image/jpeg";       
        width = 80;   
        height = 20;   
        fontSize = 16;   
        codeLength = 4;   
    }   
         
   
    public void setWidth(int width) {   
        this.width = width;   
    }   
   
    public void setHeight(int height) {   
        this.height = height;   
    }   
   
   
    public void setFontSize(int fontSize) {   
        this.fontSize = fontSize;   
    }   
   
    public void setCodeLength(int codeLength) {   
        this.codeLength = codeLength;   
    }   
   
     
   
    public String execute() throws Exception {        
        return SUCCESS;   
    }   
       
       
    private String createInputStream(int disturbType) throws IOException{   
        ByteArrayOutputStream bos =new ByteArrayOutputStream();   
        String validateCode = null;
        AuthImageService vis=new AuthImageService();
        validateCode = vis.createValidateCode(disturbType,fontSize, bos, width, height, Default_ValidateCode, codeLength);   
        inputStream = new ByteArrayInputStream(bos.toByteArray());   

        bos.close();   
        return validateCode;   
    }
    

    public InputStream getInputStream() throws Exception { 
    	String authCode=createInputStream(AuthImageService.Disturb_Type_Simple);
    	System.out.println(authCode+"========================");
    	ActionContext.getContext().getSession().put("AUTH_CODE", authCode);
    	return inputStream; 
    } 
}   
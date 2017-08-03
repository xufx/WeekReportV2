package com.zn.wr.controller;
 

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zn.wr.dao.contentDAO;
import com.zn.wr.model.Content;


@Controller
public class SaveController {
	private Content content;
	
	@Resource 
	private contentDAO contentdao;
 
	@RequestMapping("/index") // 通过spring mvc 的requestingmapping 跳转到前台index.jsp
	public String toLoginPage()throws Exception {
 		return "index";
	}
	   /*
	    * 初始化最新数据
	    */
    @ResponseBody
    @RequestMapping(value = "initdata", method = RequestMethod.POST)
 	public Content toInitData(){
		this.content = new Content();
		this.content.setScontent(contentdao.search());
		System.out.println("content:"+contentdao.search());
		return content;
	}
    
   /*
    * 手工保存
    */
    @RequestMapping(value="save", method = {RequestMethod.POST} ,produces = "text/html;charset=UTF-8") 
    @ResponseBody  
	 public  Map<String, Object> doSave(@RequestBody String initcontent) {   
    	boolean state = contentdao.insert(initcontent); 
    	Map<String, Object> modelMap = new HashMap<String, Object>();  
        modelMap.put("state", state);  
        return modelMap;  
	 } 

}

package global.sesoc.mms.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.fasterxml.jackson.databind.util.JSONWrappedObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import global.sesoc.mms.dao.IntakeInfoRepository;
import global.sesoc.mms.dto.Foodinfo;
import global.sesoc.mms.dto.FoodinfoWrapperVO;
import global.sesoc.mms.dto.IntakeInfo;
import global.sesoc.mms.dto.wrapperVO;
import global.sesoc.mms.util.PageNavigator;

@Controller
public class IntakeInfoController {
	
	@Autowired
	IntakeInfoRepository repository;

	@RequestMapping(value="intakeInfo", method=RequestMethod.GET)
	public String intakeInfo() {
		
		return "intake/intakeInfo";
	}
		
	@RequestMapping(value="selectIntakeinfo", method=RequestMethod.POST)
	public @ResponseBody List<IntakeInfo> selectIntakeinfo(@RequestBody IntakeInfo intakeinfo, HttpSession session) {
		
		intakeinfo.setUserid(session.getAttribute("loginId").toString());
		
		List<IntakeInfo> result = repository.selectIntakeInfo(intakeinfo);
		
		return result;
	}
	
	@RequestMapping(value="selectIntakeinfoGet", produces="text/plain;charset=UTF-8")
	public @ResponseBody String selectIntakeinfoGet(String regdate, HttpSession session) {
		
		IntakeInfo intakeinfo = new IntakeInfo();
		intakeinfo.setRegdate(regdate);
		intakeinfo.setUserid(session.getAttribute("loginId").toString());
		
		List<IntakeInfo> result = repository.selectIntakeInfo(intakeinfo);
		
		for(IntakeInfo rs : result) {
			System.out.println(rs);
		}
		
		for(int i=0; i<result.size(); i++) {
			long pnum = result.get(i).getPnum();
			
			String delBtn = "<a href='javascript:delBtnFn(\"" + pnum + "\")'><img class='delBtn' src='images/intake/intakeinfo/trash.png' /></a>";
			
			result.get(i).setDeleteBtn(delBtn);
		}
		
		int iTotalRecords = repository.selectIntakeInfoTotalCount();
					
		wrapperVO vo = new wrapperVO();
		
		vo.setAaData(result);
		vo.setiTotalRecords(iTotalRecords);		
		
		Gson ojb = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		return ojb.toJson(vo);
	}
	
	@RequestMapping(value="searchIntakeinfo", method=RequestMethod.POST)
	public @ResponseBody List<IntakeInfo> searchIntakeinfo(@RequestBody String[] sendData, HttpSession session) {
		
		Map<String,String> map = new HashMap<>();
		map.put("userid", session.getAttribute("loginId").toString());
		map.put("regdate1", sendData[0]);
		map.put("regdate2", sendData[1]);
		
		List<IntakeInfo> result = repository.searchIntakeinfo(map);
		
		return result;
	}
	
	@RequestMapping(value="intakeInsert", method=RequestMethod.GET)
	public String intakeInsert(String regdate, Model model) {
		List<Foodinfo> foodinfo = repository.selectFoodCategory();
		
		List<String> fdgrp_nm = new ArrayList<>();
		
		for(Foodinfo rs : foodinfo) {
			fdgrp_nm.add(rs.getFdgrp_nm());
		}
		
		model.addAttribute("foodCategory", fdgrp_nm);
		model.addAttribute("regdate", regdate);		
		return "intake/intakeInsert";
	}
	
	@RequestMapping(value="intakeModify", method=RequestMethod.GET)
	public String intakeModify(String pnum, Model model) {
		model.addAttribute("pnum", pnum);
		return "intake/intakeModify";
	}
	
	@RequestMapping(value="searchFoodinfo", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public @ResponseBody String searchFoodinfoByFoodName(@RequestBody Map<String,String> sendData ) {
		
		List<Foodinfo> list = null;
		
		FoodinfoWrapperVO vo = new FoodinfoWrapperVO();
		int totalRecordCount = 0;
		PageNavigator navi = null;
		
		if(sendData.get("fdgrp_nm") == null) {
			Map<String,String> map = new HashMap<>();
			map.put("searchItem", "desc_kor");
			map.put("searchWord", sendData.get("desc_kor"));
			
			totalRecordCount = repository.getTotalCount(map);
			navi = new PageNavigator(Integer.parseInt(sendData.get("currentPage")),totalRecordCount);
			
			list = repository.searchFoodinfo("desc_kor",sendData.get("desc_kor"), navi.getStartRecord(), navi.getCountPerPage());
			vo.setSearchItem("desc_kor");
			vo.setSearchWord(sendData.get("desc_kor"));
		}
		else {
			Map<String,String> map = new HashMap<>();
			map.put("searchItem", "fdgrp_nm");
			map.put("searchWord", sendData.get("fdgrp_nm"));
			
			totalRecordCount = repository.getTotalCount(map);
			
			list = repository.searchFoodinfo("fdgrp_nm",sendData.get("fdgrp_nm"), navi.getStartRecord(), navi.getCountPerPage());
			vo.setSearchItem("fdgrp_nm");
			vo.setSearchWord(sendData.get("desc_kor"));
		}
		
		//System.out.println(list);
		vo.setList(list);		
		vo.setNavi(navi);
		vo.setCurrentPage(Integer.parseInt(sendData.get("currentPage")));
		
		Gson gjb = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		
		return gjb.toJson(vo);
	}
	
	@RequestMapping(value="selectFoodInfoByNum", method=RequestMethod.POST)
	public @ResponseBody Foodinfo selectFoodInfoByNum( long num )	{
		Foodinfo result = repository.selectFoodInfoByNum(num);
		
		return result;
	}
	
	@RequestMapping(value="insertIntake", method=RequestMethod.POST)
	public @ResponseBody String insertIntake(@RequestBody IntakeInfo sendData, HttpSession session) {
		//System.out.println(sendData);
		
		sendData.setUserid(session.getAttribute("loginId").toString());
		int result = repository.insertIntake(sendData);
		
		return result + "";
	}
	
	@RequestMapping(value="intakeInsertDelete", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody String intakeInsertDelete(@RequestBody String pnum) {
		
		long idx = Long.parseLong( pnum.substring(0, pnum.length()-1) );		
		int result = repository.deleteIntake(idx);
		
		return result + "";
	}
	
	@RequestMapping(value="kcalStatistics", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody List<Map<String,Object>> kcalStatistics(HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		
		List<Map<String,Object>> list = new ArrayList<>();
		Map<String,Object> map = null;
		
		Map<String,Object> rs = repository.kcalStatistics(userid);
		
		Calendar cal = Calendar.getInstance();
		
		int month = cal.get(Calendar.MONTH)+1;
		
		int minusIdx = 4;
		
		for(int i=minusIdx; i>=0; i--) {			
			map = new HashMap<>();
			map.put("month", (month-i)+"월");
			map.put("Kcal", rs.get("MONTH" + (i+1)).toString());
			
			list.add(map);
		}
		
		return list;
	}
	
	@RequestMapping(value="selectIntakeInfoByNum", method=RequestMethod.POST)
	public @ResponseBody IntakeInfo selectIntakeInfoByNum( long pnum )	{
		IntakeInfo result = repository.selectIntakeInfoByNum(pnum);
		return result;
	}
	
	@RequestMapping(value="selectThreeMajorNutrients", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody IntakeInfo selectThreeMajorNutrients(HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		
		IntakeInfo result = repository.selectThreeMajorNutrients(userid);
		return result;
	}
	
	@RequestMapping(value="ntrInfoTable", method= {RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody IntakeInfo ntrInfoTable(HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		
		IntakeInfo result = repository.ntrInfoTable(userid);
		System.out.println(result);
		return result;
	}
}

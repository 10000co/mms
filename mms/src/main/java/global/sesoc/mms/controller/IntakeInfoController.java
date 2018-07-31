package global.sesoc.mms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

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
		
		for(int i=0; i<result.size(); i++) {
			long pnum = result.get(i).getPnum();
			String modifyBtn = "<input class='modBtn' type='button' data-pnum='" + pnum + "'value='삭제' onclick='javascript:modBtnFn(this)' />";
			
			result.get(i).setModifyBtn(modifyBtn);
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
		
		//System.out.println("desc_kor: " + sendData.get("desc_kor"));
		//System.out.println("fdgrp_nm: " + sendData.get("fdgrp_nm"));
		
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
	
	@RequestMapping(value="selectIntakeInfoByNum", method=RequestMethod.POST)
	public @ResponseBody Foodinfo selectIntakeInfoByNum( long num )
	{
		Foodinfo result = repository.selectIntakeInfoByNum(num);
		
		return result;
	}
	
}

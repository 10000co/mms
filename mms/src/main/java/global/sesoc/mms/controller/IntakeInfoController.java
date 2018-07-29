package global.sesoc.mms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.mms.dao.IntakeInfoRepository;
import global.sesoc.mms.dao.dataRepository;
import global.sesoc.mms.dto.IntakeInfo;
import global.sesoc.mms.dto.data;

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
	
	@RequestMapping(value="searchIntakeinfo", method=RequestMethod.POST)
	public @ResponseBody List<IntakeInfo> searchIntakeinfo(@RequestBody String[] sendData, HttpSession session) {
		
		Map<String,String> map = new HashMap<>();
		map.put("userid", session.getAttribute("loginId").toString());
		map.put("regdate1", sendData[0]);
		map.put("regdate2", sendData[1]);
		
		List<IntakeInfo> result = repository.searchIntakeinfo(map);
		
		return result;
	}
}

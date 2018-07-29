package global.sesoc.mms.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.mms.dao.dataRepository;
import global.sesoc.mms.dto.data;

@Controller
public class dataController {
	

	@Autowired
	dataRepository repository;

	@RequestMapping(value="selectIntakeinfoGet", method=RequestMethod.GET)
	public @ResponseBody List<data> selectIntakeinfoGet(String regdate, HttpSession session) {
		
		data putData = new data();
		putData.setRegdate(regdate);
		putData.setUserid(session.getAttribute("loginId").toString());
		
		List<data> result = repository.selectIntakeInfoGet(putData);
		
		return result;
	}
	
}

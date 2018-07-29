package global.sesoc.mms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IntakeInfoController {

	@RequestMapping(value="intakeInfo", method=RequestMethod.GET)
	public String intakeInfo() {
		
		return "intake/intakeInfo";
	}
	
}

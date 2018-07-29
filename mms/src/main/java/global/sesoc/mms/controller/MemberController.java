package global.sesoc.mms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.mms.dao.MemberRepository;
import global.sesoc.mms.dto.Members;

@Controller
public class MemberController {
	
	@Autowired
	MemberRepository repository;
	
	/**
	 * 회원가입 페이지로 이동
	 * @return
	 */
	@RequestMapping(value="signup", method=RequestMethod.GET)
	public String signup() {
		
		return "signin/signup";
	}

	/**
	 * 회원가입 진행
	 * @param member
	 * @return
	 */
	@RequestMapping(value="signup", method=RequestMethod.POST)
	public String signup(Members member) {
		
		repository.insertMember(member);
		
		return "signin/signin";
	}
	
	/**
	 * 로그인 페이지 이동
	 * @return
	 */
	@RequestMapping(value="signin", method=RequestMethod.GET)
	public String signin() {
		
		return "signin/signin";
	}
	
	/**
	 * 로그인
	 * @return
	 */
	@RequestMapping(value="signin", method=RequestMethod.POST)
	public String signin(Members member, Model model, HttpSession session) {
		
		Members m = repository.selectMember(member);
		String url;
		
		if(m != null) {
			session.setAttribute("loginId", m.getUserid());
			session.setAttribute("loginName", m.getUsername());
			
			url = "index";
		}
		else {
			model.addAttribute("member", member);
			url = "signin/signin";
		}
		
		return url;
	}
	
	/**
	 * 로그아웃
	 * @return
	 */
	@RequestMapping(value="signout", method=RequestMethod.GET)
	public String signout(HttpSession session) {
		session.invalidate();
		
		return "signin/signin";
	}
}

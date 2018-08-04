package global.sesoc.mms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	/**
	 * ID 중복확인
	 * @param userid
	 * @return
	 */
	@RequestMapping(value="idOverlapCheck", method=RequestMethod.POST)
	public @ResponseBody Members idOverlapCheck(@RequestBody Members member) {
		
		System.out.println(member);
		Members result = repository.selectMember(member);
		if(result == null) {
			result = new Members();
			result.setUserid("");
		}
		
		return result;
	}
	
	/**
	 * 회원정보 수정 페이지로 이동
	 * @return
	 */
	@RequestMapping(value="updatePageMove", method=RequestMethod.GET)
	public String updatePageMove() {		
		
		return "signin/memberModify";
	}
	
	/**
	 * 수정할 회원 정보 가져오기
	 * @param userid
	 * @return
	 */
	@RequestMapping(value="selectMemberInfo", method=RequestMethod.POST)
	public @ResponseBody Members selectMemberInfo(HttpSession session) {
		String userid = session.getAttribute("loginId").toString();
		
		Members result = repository.selectMemberInfo(userid);
		
		return result;
	}
	
	/**
	 * 회원정보 수정
	 * @param sendData
	 * @return
	 */
	@RequestMapping(value="memberUpdate", method=RequestMethod.POST)
	public String memberUpdate(Members member, HttpSession session) {
		
		repository.updateMember(member);
		session.invalidate();
		
		return "signin/signin";
	}
	
	/**
	 * 비밀번호 일치 확인
	 * @param userpwd
	 * @param session
	 * @return
	 */
	@RequestMapping(value="memberChkPwd", method=RequestMethod.POST)
	public @ResponseBody Members memberChkPwd(String userpwd, HttpSession session) {
		Members member = new Members();
		member.setUserid(session.getAttribute("loginId").toString());
		member.setUserpwd(userpwd);
		
		Members result = repository.memberChkPwd(member);
		
		if(result == null) {
			member.setUserid("");
			member.setUserpwd("");
			result = member;
		}
		
		return result;
	}
}

package global.sesoc.mms.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.mms.dto.Members;

@Repository
public class MemberRepository {
	
	@Autowired
	SqlSession session;
	
	/**
	 * 회원 가입
	 * @param member
	 * @return int 회원가입처리
	 */
	public int insertMember(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);		
		int result = mapper.insertMember(member);
		
		return result;
	}

	/**
	 * 아이디 중복확인, 로그인
	 * @param member
	 * @return 조회된 member
	 */
	public Members selectMember(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Members result = mapper.selectMember(member);
		
		return result;
	}

	public int updateMember(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.updateMember(member);
		
		return result;
	}

	public Members selectMemberInfo(String userid) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Members result = mapper.selectMemberInfo(userid);
		
		return result;
	}

	public Members memberChkPwd(Members member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Members result = mapper.selectMember(member);
		
		return result;
	}
	
}

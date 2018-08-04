package global.sesoc.mms.dao;

import global.sesoc.mms.dto.Members;

public interface MemberMapper {
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */	
	public int insertMember(Members member);
	
	/**
	 * 회원정보 수정
	 * @param member
	 * @return
	 */
//	public int update(Member member);
	
	/**
	 * 로그인, id 중복확인
	 * @param member
	 * @return
	 */
	public Members selectMember(Members member);

	/**
	 * 업데이트
	 * @param member
	 * @return
	 */
	public int updateMember(Members member);

	/**
	 * 회원정보 가져오기
	 * @param userid
	 * @return
	 */
	public Members selectMemberInfo(String userid);
}

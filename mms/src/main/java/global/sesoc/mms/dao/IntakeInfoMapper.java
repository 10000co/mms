package global.sesoc.mms.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.mms.dto.IntakeInfo;
import global.sesoc.mms.dto.data;

public interface IntakeInfoMapper {
	
	/**
	 * 자료 등록
	 * @param member
	 * @return
	 */	
//	public int insertIntakeInfo(IntakeInfo intakeinfo);
	
	/**
	 * 등록 정보 수정
	 * @param member
	 * @return
	 */
//	public int updateIntakeInfo(IntakeInfo intakeinfo);
	
	/**
	 * 등록 자료 검색
	 * @param intakeinfo
	 * @return
	 */
	public List<IntakeInfo> selectIntakeInfo(IntakeInfo intakeinfo);

	/**
	 * 등록 자료 검색(지정된 기간에 해당되는 자료 검색)
	 * @param map
	 * @return
	 */
	public List<IntakeInfo> searchIntakeinfo(Map<String, String> map);

	
}

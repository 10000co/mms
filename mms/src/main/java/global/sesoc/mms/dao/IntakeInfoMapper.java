package global.sesoc.mms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.mms.dto.Foodinfo;
import global.sesoc.mms.dto.IntakeInfo;

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
	
	/**
	 * 등록된 자료의 총 개수 확인
	 * @return
	 */
	public int selectIntakeInfoTotalCount();

	/**
	 * 식품군 검색
	 * @return
	 */
	public List<Foodinfo> selectFoodCategory();

	/**
	 * 검색내용 개수(식품명으로 검색)
	 * @param sendData
	 * @return
	 */
	public int getTotalCount(Map<String, String> map);

	/**
	 * 음식 검색
	 * @param map
	 * @param rb
	 * @return
	 */
	public List<Foodinfo> searchFoodinfo(Map<String, String> map, RowBounds rb);

	/**
	 * 음식 선택
	 * @param num
	 * @return
	 */
	public Foodinfo selectIntakeInfoByNum(long num);

	/**
	 * 섭취한 음식 정보 등록
	 * @param sendData
	 * @return
	 */
	public int insertIntake(IntakeInfo sendData);

	/**
	 * 등록한 음식 정보 삭제
	 * @param idx
	 * @return
	 */
	public int deleteIntake(long idx);

	
}

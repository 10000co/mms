package global.sesoc.mms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.mms.dto.IntakeInfo;
import global.sesoc.mms.dto.data;

@Repository
public class IntakeInfoRepository {
	
	@Autowired
	SqlSession session;

	
	public List<IntakeInfo> selectIntakeInfo(IntakeInfo intakeinfo) {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		List<IntakeInfo> result = mapper.selectIntakeInfo(intakeinfo);
		
		return result;
	}


	public List<IntakeInfo> searchIntakeinfo(Map<String, String> map) {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		List<IntakeInfo> result = mapper.searchIntakeinfo(map);
		
		return result;
	}


	
	
}

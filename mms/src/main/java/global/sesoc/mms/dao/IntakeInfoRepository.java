package global.sesoc.mms.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.mms.dto.Foodinfo;
import global.sesoc.mms.dto.IntakeInfo;

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


	public int selectIntakeInfoTotalCount() {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		int result = mapper.selectIntakeInfoTotalCount();
		
		return result;
	}


	public List<Foodinfo> selectFoodCategory() {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		List<Foodinfo> result = mapper.selectFoodCategory();
		
		return result;
	}

	public int getTotalCount(Map<String, String> map) {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		int result = mapper.getTotalCount(map);
		
		return result;
	}

	public List<Foodinfo> searchFoodinfo(String searchItem, String searchWord, int startRecord, int countPerPage) {
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		Map<String,String> map = new HashMap<>();
		
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		
		List<Foodinfo> list = mapper.searchFoodinfo(map, rb);
		
		return list;
	}


	public Foodinfo selectIntakeInfoByNum(long num) {
		IntakeInfoMapper mapper = session.getMapper(IntakeInfoMapper.class);
		
		Foodinfo result = mapper.selectIntakeInfoByNum(num);
		
		return result;
	}


	
	
	
}

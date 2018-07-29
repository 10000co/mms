package global.sesoc.mms.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.mms.dto.data;

@Repository
public class dataRepository {
	
	@Autowired
	SqlSession session;
	
	public List<data> selectIntakeInfoGet(data putData) {
		
		dataMapper mapper = session.getMapper(dataMapper.class);
		List<data> result = mapper.selectIntakeInfoGet(putData);
		
		System.out.println(result);
		
		return result;
	}
	
}

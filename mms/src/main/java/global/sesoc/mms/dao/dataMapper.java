package global.sesoc.mms.dao;

import java.util.List;

import global.sesoc.mms.dto.data;

public interface dataMapper {
	
	/**
	 * 등록 자료 검색(GET 방식 datatables 때문에)
	 * @param intakeinfo
	 * @return
	 */
	public List<data> selectIntakeInfoGet(data putData);

}

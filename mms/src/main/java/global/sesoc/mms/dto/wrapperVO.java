package global.sesoc.mms.dto;

import java.util.List;

public class wrapperVO {
	private List<?> aaData;
	private int iTotalRecords;
	private int iTotalDisplayRecords;
	
	public wrapperVO() { }

	public wrapperVO(List<?> aaData, int iTotalRecords, int iTotalDisplayRecords) {
		super();
		this.aaData = aaData;
		this.iTotalRecords = iTotalRecords;
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	public List<?> getAaData() {
		return aaData;
	}

	public int getiTotalRecords() {
		return iTotalRecords;
	}

	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setAaData(List<?> aaData) {
		this.aaData = aaData;
	}

	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	@Override
	public String toString() {
		return "wrapperVO [aaData=" + aaData + ", iTotalRecords=" + iTotalRecords + ", iTotalDisplayRecords="
				+ iTotalDisplayRecords + "]";
	}
	
	
}

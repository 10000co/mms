package global.sesoc.mms.dto;

import java.util.List;

import global.sesoc.mms.util.PageNavigator;

public class FoodinfoWrapperVO {
	private List<Foodinfo> list;
	private String searchItem;
	private String searchWord;
	private PageNavigator navi;
	private int currentPage;
	
	public FoodinfoWrapperVO() { }

	public FoodinfoWrapperVO(List<Foodinfo> list, String searchItem, String searchWord, PageNavigator navi,
			int currentPage) {
		super();
		this.list = list;
		this.searchItem = searchItem;
		this.searchWord = searchWord;
		this.navi = navi;
		this.currentPage = currentPage;
	}

	public List<Foodinfo> getList() {
		return list;
	}

	public String getSearchItem() {
		return searchItem;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public PageNavigator getNavi() {
		return navi;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setList(List<Foodinfo> list) {
		this.list = list;
	}

	public void setSearchItem(String searchItem) {
		this.searchItem = searchItem;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public void setNavi(PageNavigator navi) {
		this.navi = navi;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	@Override
	public String toString() {
		return "FoodinfoWrapperVO [list=" + list + ", searchItem=" + searchItem + ", searchWord=" + searchWord
				+ ", navi=" + navi + ", currentPage=" + currentPage + "]";
	}

	
	
	
	
}

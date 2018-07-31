package global.sesoc.mms.dto;

public class IntakeInfo {
	
	private long pnum;
	private String userid;
	private long num;
	private String desc_kor;
	private float nutr_cont1;
	private float nutr_cont2;
	private float nutr_cont3;
	private float nutr_cont4;
	private float nutr_cont5;
	private float nutr_cont6;
	private float nutr_cont7;
	private float nutr_cont8;
	private float nutr_cont9;
	private String regdate;
	private String modifyBtn;
	
	public IntakeInfo() { }

	public IntakeInfo(long pnum, String userid, long num, String desc_kor, float nutr_cont1, float nutr_cont2,
			float nutr_cont3, float nutr_cont4, float nutr_cont5, float nutr_cont6, float nutr_cont7, float nutr_cont8,
			float nutr_cont9, String regdate, String modifyBtn) {
		super();
		this.pnum = pnum;
		this.userid = userid;
		this.num = num;
		this.desc_kor = desc_kor;
		this.nutr_cont1 = nutr_cont1;
		this.nutr_cont2 = nutr_cont2;
		this.nutr_cont3 = nutr_cont3;
		this.nutr_cont4 = nutr_cont4;
		this.nutr_cont5 = nutr_cont5;
		this.nutr_cont6 = nutr_cont6;
		this.nutr_cont7 = nutr_cont7;
		this.nutr_cont8 = nutr_cont8;
		this.nutr_cont9 = nutr_cont9;
		this.regdate = regdate;
		this.modifyBtn = modifyBtn;
	}

	public long getPnum() {
		return pnum;
	}

	public String getUserid() {
		return userid;
	}

	public long getNum() {
		return num;
	}

	public String getDesc_kor() {
		return desc_kor;
	}

	public float getNutr_cont1() {
		return nutr_cont1;
	}

	public float getNutr_cont2() {
		return nutr_cont2;
	}

	public float getNutr_cont3() {
		return nutr_cont3;
	}

	public float getNutr_cont4() {
		return nutr_cont4;
	}

	public float getNutr_cont5() {
		return nutr_cont5;
	}

	public float getNutr_cont6() {
		return nutr_cont6;
	}

	public float getNutr_cont7() {
		return nutr_cont7;
	}

	public float getNutr_cont8() {
		return nutr_cont8;
	}

	public float getNutr_cont9() {
		return nutr_cont9;
	}

	public String getRegdate() {
		return regdate;
	}

	public String getModifyBtn() {
		return modifyBtn;
	}

	public void setPnum(long pnum) {
		this.pnum = pnum;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setNum(long num) {
		this.num = num;
	}

	public void setDesc_kor(String desc_kor) {
		this.desc_kor = desc_kor;
	}

	public void setNutr_cont1(float nutr_cont1) {
		this.nutr_cont1 = nutr_cont1;
	}

	public void setNutr_cont2(float nutr_cont2) {
		this.nutr_cont2 = nutr_cont2;
	}

	public void setNutr_cont3(float nutr_cont3) {
		this.nutr_cont3 = nutr_cont3;
	}

	public void setNutr_cont4(float nutr_cont4) {
		this.nutr_cont4 = nutr_cont4;
	}

	public void setNutr_cont5(float nutr_cont5) {
		this.nutr_cont5 = nutr_cont5;
	}

	public void setNutr_cont6(float nutr_cont6) {
		this.nutr_cont6 = nutr_cont6;
	}

	public void setNutr_cont7(float nutr_cont7) {
		this.nutr_cont7 = nutr_cont7;
	}

	public void setNutr_cont8(float nutr_cont8) {
		this.nutr_cont8 = nutr_cont8;
	}

	public void setNutr_cont9(float nutr_cont9) {
		this.nutr_cont9 = nutr_cont9;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public void setModifyBtn(String modifyBtn) {
		this.modifyBtn = modifyBtn;
	}

	@Override
	public String toString() {
		return "IntakeInfo [pnum=" + pnum + ", userid=" + userid + ", num=" + num + ", desc_kor=" + desc_kor
				+ ", nutr_cont1=" + nutr_cont1 + ", nutr_cont2=" + nutr_cont2 + ", nutr_cont3=" + nutr_cont3
				+ ", nutr_cont4=" + nutr_cont4 + ", nutr_cont5=" + nutr_cont5 + ", nutr_cont6=" + nutr_cont6
				+ ", nutr_cont7=" + nutr_cont7 + ", nutr_cont8=" + nutr_cont8 + ", nutr_cont9=" + nutr_cont9
				+ ", regdate=" + regdate + ", modifyBtn=" + modifyBtn + "]";
	}
	
	
}

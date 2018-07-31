package global.sesoc.mms.dto;

public class Foodinfo {
	
	private long num;
	private long food_cd;
	private String fdgrp_nm;
	private String desc_kor;
	private double serving_wt;
	private double nutr_cont1;
	private double nutr_cont2;
	private double nutr_cont3;
	private double nutr_cont4;
	private double nutr_cont5;
	private double nutr_cont6;
	private double nutr_cont7;
	private double nutr_cont8;
	private double nutr_cont9;
	private String animal_plant;
	private int bgn_year;
	
	public Foodinfo() {	}

	public Foodinfo(long num, long food_cd, String fdgrp_nm, String desc_kor, double serving_wt, double nutr_cont1,
			double nutr_cont2, double nutr_cont3, double nutr_cont4, double nutr_cont5, double nutr_cont6,
			double nutr_cont7, double nutr_cont8, double nutr_cont9, String animal_plant, int bgn_year) {
		super();
		this.num = num;
		this.food_cd = food_cd;
		this.fdgrp_nm = fdgrp_nm;
		this.desc_kor = desc_kor;
		this.serving_wt = serving_wt;
		this.nutr_cont1 = nutr_cont1;
		this.nutr_cont2 = nutr_cont2;
		this.nutr_cont3 = nutr_cont3;
		this.nutr_cont4 = nutr_cont4;
		this.nutr_cont5 = nutr_cont5;
		this.nutr_cont6 = nutr_cont6;
		this.nutr_cont7 = nutr_cont7;
		this.nutr_cont8 = nutr_cont8;
		this.nutr_cont9 = nutr_cont9;
		this.animal_plant = animal_plant;
		this.bgn_year = bgn_year;
	}

	public long getNum() {
		return num;
	}

	public long getFood_cd() {
		return food_cd;
	}

	public String getFdgrp_nm() {
		return fdgrp_nm;
	}

	public String getDesc_kor() {
		return desc_kor;
	}

	public double getServing_wt() {
		return serving_wt;
	}

	public double getNutr_cont1() {
		return nutr_cont1;
	}

	public double getNutr_cont2() {
		return nutr_cont2;
	}

	public double getNutr_cont3() {
		return nutr_cont3;
	}

	public double getNutr_cont4() {
		return nutr_cont4;
	}

	public double getNutr_cont5() {
		return nutr_cont5;
	}

	public double getNutr_cont6() {
		return nutr_cont6;
	}

	public double getNutr_cont7() {
		return nutr_cont7;
	}

	public double getNutr_cont8() {
		return nutr_cont8;
	}

	public double getNutr_cont9() {
		return nutr_cont9;
	}

	public String getAnimal_plant() {
		return animal_plant;
	}

	public int getBgn_year() {
		return bgn_year;
	}

	public void setNum(long num) {
		this.num = num;
	}

	public void setFood_cd(long food_cd) {
		this.food_cd = food_cd;
	}

	public void setFdgrp_nm(String fdgrp_nm) {
		this.fdgrp_nm = fdgrp_nm;
	}

	public void setDesc_kor(String desc_kor) {
		this.desc_kor = desc_kor;
	}

	public void setServing_wt(double serving_wt) {
		this.serving_wt = serving_wt;
	}

	public void setNutr_cont1(double nutr_cont1) {
		this.nutr_cont1 = nutr_cont1;
	}

	public void setNutr_cont2(double nutr_cont2) {
		this.nutr_cont2 = nutr_cont2;
	}

	public void setNutr_cont3(double nutr_cont3) {
		this.nutr_cont3 = nutr_cont3;
	}

	public void setNutr_cont4(double nutr_cont4) {
		this.nutr_cont4 = nutr_cont4;
	}

	public void setNutr_cont5(double nutr_cont5) {
		this.nutr_cont5 = nutr_cont5;
	}

	public void setNutr_cont6(double nutr_cont6) {
		this.nutr_cont6 = nutr_cont6;
	}

	public void setNutr_cont7(double nutr_cont7) {
		this.nutr_cont7 = nutr_cont7;
	}

	public void setNutr_cont8(double nutr_cont8) {
		this.nutr_cont8 = nutr_cont8;
	}

	public void setNutr_cont9(double nutr_cont9) {
		this.nutr_cont9 = nutr_cont9;
	}

	public void setAnimal_plant(String animal_plant) {
		this.animal_plant = animal_plant;
	}

	public void setBgn_year(int bgn_year) {
		this.bgn_year = bgn_year;
	}

	@Override
	public String toString() {
		return "Foodinfo [num=" + num + ", food_cd=" + food_cd + ", fdgrp_nm=" + fdgrp_nm + ", desc_kor=" + desc_kor
				+ ", serving_wt=" + serving_wt + ", nutr_cont1=" + nutr_cont1 + ", nutr_cont2=" + nutr_cont2
				+ ", nutr_cont3=" + nutr_cont3 + ", nutr_cont4=" + nutr_cont4 + ", nutr_cont5=" + nutr_cont5
				+ ", nutr_cont6=" + nutr_cont6 + ", nutr_cont7=" + nutr_cont7 + ", nutr_cont8=" + nutr_cont8
				+ ", nutr_cont9=" + nutr_cont9 + ", animal_plant=" + animal_plant + ", bgn_year=" + bgn_year + "]";
	}
	
}

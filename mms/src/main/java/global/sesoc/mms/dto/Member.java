package global.sesoc.mms.dto;

public class Member {

	private String userid;
	private String userpwd;
	private String username;
	private String gender;
	private String birth;
	private String phone;
	private float height;
	private float weight;
	private String address;
	
	public Member() { }

	public Member(String userid, String userpwd, String username, String gender, String birth, String phone,
			float height, float weight, String address) {
		super();
		this.userid = userid;
		this.userpwd = userpwd;
		this.username = username;
		this.gender = gender;
		this.birth = birth;
		this.phone = phone;
		this.height = height;
		this.weight = weight;
		this.address = address;
	}

	public String getUserid() {
		return userid;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public String getUsername() {
		return username;
	}

	public String getGender() {
		return gender;
	}

	public String getBirth() {
		return birth;
	}

	public String getPhone() {
		return phone;
	}

	public float getHeight() {
		return height;
	}

	public float getWeight() {
		return weight;
	}

	public String getAddress() {
		return address;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setHeight(float height) {
		this.height = height;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Member [userid=" + userid + ", userpwd=" + userpwd + ", username=" + username + ", gender=" + gender
				+ ", birth=" + birth + ", phone=" + phone + ", height=" + height + ", weight=" + weight + ", address="
				+ address + "]";
	}
	
}

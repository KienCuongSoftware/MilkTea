package beans;

public class Warehouse {
	private int code;
	private String name;
	private String address;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Warehouse(int code, String name, String address) {
		super();
		this.code = code;
		this.name = name;
		this.address = address;
	}
	public Warehouse() {
	}
	
}

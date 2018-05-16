package tw.chad;

public class m1{
	public String account,realname,id;
	String[] stocks;
	public m1(String account,String realname,String id){
		this.account=account;
		this.realname=realname;
		this.id=id;
	}
	public m1(String account,String realname,String id,String[] stocks){
		this(account, realname,id);
		this.stocks=stocks;
	}
	public String getRealname() {
		return realname;
	}
	public String getAccount() {
		return account;
	}
	public String getId() {
		return id;
	}
}

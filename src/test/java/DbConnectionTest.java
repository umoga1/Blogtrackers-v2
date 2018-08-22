import java.util.HashMap;

import authentication.*;


public class DbConnectionTest {
	public static void main(String[] args) {
		DbConnection testConnection = new DbConnection();
		HashMap<String, String> hm = new HashMap<String, String>();
		
		hm = DbConnection.loadConstant();		
		//System.out.println(testConnection.isUserExists("baodium"));
		System.out.println(hm.get("elasticIndex")+"blogposts/");						// Test JDBC Connection
		//System.out.println(testConnection.md5Funct("wale"));
		//testConnection.addUser("abcabc", "pass", "baodium@gmail.com");
		//testConnection.removeUser("ax");
		//System.out.println(new DbConnection().query("SELECT * FROM usercredentials where Email = '"+baodium@gmail.com+"'"));
	
	}
}

import authentication.*;


public class DbConnectionTest {
	public static void main(String[] args) {
		DbConnection testConnection = new DbConnection();
		System.out.println(testConnection.getConnection());						// Test JDBC Connection
		System.out.println(testConnection.md5Funct("wale"));
		
		testConnection.addUser("abcabc", "pass", "baodium@gmail.com");
		//testConnection.removeUser("ax");
		System.out.println(testConnection.query("SELECT * FROM usercredentials"));
	
	}
}

/**
 * The class DbConnection is used to create/read/update/delete database connections etc.
 * 
 * <p>
 * The method loadConstant is used to load the connection parameter from a remote config file for security reasons
 * @author Adewale Obadimu
 */

package authentication;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DbConnection {

	/**
	 * loadConstant() - For loading the configuration file from a remote repository	
	 */
	private HashMap<String, String> hm = new HashMap<String, String>();				//Hashmap that will contain the key-value pair from the config file
	private void loadContant() {
		BufferedReader br = null;	
		try {
			br = new BufferedReader(new FileReader("C:\blogtrackers.config"));  	//Read the config file
			String temp = "";
			while((temp = br.readLine()) != null) {
				temp = temp.trim();  											 	//Strip the whitespaces 
				if(temp.isEmpty() || temp.startsWith("//")) { 						
					continue;														// Skip the comments, for example the author, created on and document type
				}
				else {
					String[] arr = temp.split("##");								// Split it by ##, for example, if you have name##wale, then arr[0] = name and arr[1] = wale and arr.length = 2 since it contains 2 elements
					if(arr.length == 2) {
						hm.put(arr[0].trim(), arr[1].trim());						// Save the element as a key value pair. Using example above, the Hashmap will be [user, wale], where user is the key and wale is the value
					}
				}
			}
		} catch(IOException ex) {
			Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, "Encounter error while loading config file", ex);
		}
	}
}
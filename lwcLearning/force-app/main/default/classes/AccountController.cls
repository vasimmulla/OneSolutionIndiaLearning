public with sharing class AccountController {
            @AuraEnabled(cacheable=true)
        	public static List<Account> getAccounts() {
       			return [SELECT Id, Name, Industry FROM Account ORDER BY CreatedDate DESC LIMIT 10];
        	}
        	@AuraEnabled
        	public static Account createAccount(String accName) {
        		Account acc = new Account(Name = accName);
        		insert acc;
        		return acc;
        }
  }
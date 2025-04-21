public class LWCLazyLoadingCtrl {    
    @AuraEnabled
    public static List<Account> getAccountData() {
        return [SELECT Id, Name, Type, Phone, Industry, CreatedDate FROM Account LIMIT 50000];
    }

    @AuraEnabled (cacheable=true)
    public static List<Account> retrieveAccounts(){
        return [SELECT Id, Name, Type, Phone, Industry, CreatedDate FROM Account LIMIT 50000];
    }
 }
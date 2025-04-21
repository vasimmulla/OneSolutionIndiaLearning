public with sharing class NewsController {
    @AuraEnabled
    public static Map<String,Object> retriveNews(){
       HttpRequest httpRequest  = new HttpRequest();
       httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e6ac47ca903f4760b730796c481c9c65');
       httpRequest.setMethod('GET');

       Map<String,Object> newsJsondata = new Map<String,Object>();
       String strResponse = null;

       try {
           Http http = new Http();
           HttpResponse httpResponse = http.send(httpRequest);
           if(httpResponse.getStatusCode() == 200){
               strResponse = httpResponse.getBody();
           }else {
               throw new CalloutException(httpResponse.getBody());
           }
       } catch (Exception ex) {
           throw ex;
           
       } 
       if (!String.isBlank(strResponse)) {
           newsJsondata = (Map<String,Object>)JSON.deserializeUntyped(strResponse);          
       }
       if (!newsJsondata.isEmpty()) {
           return newsJsondata;
       }else {
           return null;
       }
   }
}
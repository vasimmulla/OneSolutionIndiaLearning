public class NasaCallout {
    
    @AuraEnabled(cacheable = true)
    public static String getNasaImage(){
        Http http = new Http();                // Create Http object
		HttpRequest request = new HttpRequest();          // Create Http request object
		//  Specify the URL of the external service you are calling
		request.setEndpoint('https://api.nasa.gov/planetary/apod?api_key=FKXt2cdxUihjPPj8BliA7uYixLPDZu3RQqtLphyl');
		// HTTP method to fetch data from service
		request.setMethod('GET');            
		HttpResponse response = http.send(request);
        String responseData = '';
		// If the request is successful, parse the JSON response.
		if(response.getStatusCode() == 200) {
   			responseData = response.getBody();
   			System.debug(responseData);
        	return responseData;
        }else{
            String errorMsg = 'Error ' + response.getStatusCode()+ '-'+ response.getStatus();
            return errorMsg;
        }
        
    }
}
public class OCRSpaceService {
    private static final String API_URL = 'https://api.ocr.space/parse/image';
    private static final String API_KEY = 'Your API key';  // Your API key
    
    public static String extractTextFromImage(String base64Image) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('POST');
        request.setHeader('apikey', API_KEY);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        // Prepare the request body
        String body = 'base64image=' + EncodingUtil.urlEncode('data:image/jpeg;base64,' + base64Image, 'UTF-8');
        request.setBody(body);

        Http http = new Http();
        try {
            HttpResponse response = http.send(request);
            
            System.debug('OCRSpace API Response Status: ' + response.getStatusCode());
            System.debug('OCRSpace API Response Body: ' + response.getBody());
            
            if (response.getStatusCode() == 200) {
                // Deserialize the response JSON
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                
                // Check if ParsedResults exist
                if (responseMap.containsKey('ParsedResults')) {
                    List<Object> parsedResults = (List<Object>) responseMap.get('ParsedResults');
                    
                    if (parsedResults.size() > 0) {
                        Map<String, Object> firstResult = (Map<String, Object>) parsedResults.get(0);
                        
                        // Extract ParsedText from the first result
                        if (firstResult.containsKey('ParsedText')) {
                            String extractedText = (String) firstResult.get('ParsedText');
                            System.debug('Extracted Text: ' + extractedText);
                            return extractedText;
                        } else {
                            System.debug('No ParsedText found in the first ParsedResult');
                        }
                    } else {
                        System.debug('No ParsedResults found in the API response');
                    }
                } else {
                    System.debug('ParsedResults key missing in the API response');
                }
            } else {
                System.debug('OCRSpace API responded with error: ' + response.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Error making API call: ' + e.getMessage());
        }

        // Return null if extraction fails
        return null;
    }
}

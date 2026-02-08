public class FuelPriceService {
  @AuraEnabled(cacheable=true)
  public static String getFuelPrices(String state, String city) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    String endpoint =
            'https://daily-petrol-diesel-lpg-cng-fuel-prices-in-india.p.rapidapi.com/v1/fuel-prices/history/india/'
            + state
            + '/'
            + city;
    req.setEndpoint(endpoint);
    req.setMethod('GET');
    req.setHeader('x-rapidapi-key','6703912fdemsh4a9456523c9a7e2p1c9fe0jsnd0ce2ae61c42');
    req.setHeader('x-rapidapi-host','daily-petrol-diesel-lpg-cng-fuel-prices-in-india.p.rapidapi.com');
    HttpResponse res = http.send(req);
    System.debug(res.getBody());
    return res.getBody();
  }
}
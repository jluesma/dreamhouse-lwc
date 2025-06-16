public with sharing class GeocodingCalloutService {
    private static final String BASE_URL = System.Label.GeocodingServiceBaseUrl;
    
    /**
     * @description Makes an HTTP callout to the geocoding service
     * @param addressParams Map of address parameters to be included in the URL
     * @return List<GeocodingService.Coordinates> List of coordinates from the geocoding service
     */
    public static List<GeocodingService.Coordinates> makeGeocodeCallout(Map<String, String> addressParams) {
        String geocodingUrl = buildGeocodeUrl(addressParams);

        String religion = 'catholic';
        
        if (geocodingUrl == BASE_URL) {
            return new List<GeocodingService.Coordinates>();
        }
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(geocodingUrl);
        request.setMethod('GET');
        request.setHeader('http-referer', URL.getSalesforceBaseUrl().toExternalForm());
        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return (List<GeocodingService.Coordinates>) JSON.deserialize(
                response.getBody(),
                List<GeocodingService.Coordinates>.class
            );
        }
        return new List<GeocodingService.Coordinates>();
    }
    
    /**
     * @description Builds the geocoding URL with address parameters
     * @param addressParams Map of address parameters
     * @return String The complete geocoding URL
     */
    private static String buildGeocodeUrl(Map<String, String> addressParams) {
        String geocodingUrl = BASE_URL;
        
        for (String key : addressParams.keySet()) {
            if (String.isNotBlank(addressParams.get(key))) {
                geocodingUrl += '&' + key + '=' + addressParams.get(key);
            }
        }
        
        return geocodingUrl;
    }
}
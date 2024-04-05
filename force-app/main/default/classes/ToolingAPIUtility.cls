/**
 * @description - Class to execute  queries via Tooling API Requests when needed
 */
public with sharing class ToolingAPIUtility {

    public static final String endpoint = '/services/data/v57.0/tooling/query/?q=';
    
    public static HttpResponse queryToolingAPI(String query) {
        
        String urlString = endpoint + EncodingUtil.urlEncode(query, 'UTF-8');
        String baseUrl = URL.getOrgDomainURL().toExternalForm();

        HttpRequest request = new HttpRequest();
        
        request.setEndpoint(baseUrl + urlString);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        return response;
    }
}

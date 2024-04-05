/**
 * This class contains unit tests for validating the behavior of ToolingAPIUtility Apex classes
 */
@isTest
private class ToolingAPIUtilityTest {

    /**
     * @description - Test method to get the object description against its API Name
     */
    @isTest
    static void getObjectDescriptionFromAPIName() {
        
        //Given
        String objectAPIName = 'Account';
        String query = 'SELECT DeveloperName, QualifiedApiName, Description FROM EntityDefinition WHERE QualifiedApiName = \'' + objectAPIName + '\' LIMIT 1';
        
        //When

        //setting mock response for http callout
        String mockResponse = 'account object description';
        Integer mockStatus = 200;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockStatus, mockResponse));
        
        //making http callout
        HttpResponse res = ToolingAPIUtility.queryToolingAPI(query);
        Integer statusCode = res.getStatusCode();
        String responseJson = res.getBody();

        //Then 

        Assert.areEqual(mockResponse, responseJson, 'the response did not match');
        Assert.areEqual(mockStatus, statusCode, 'the response status did not match');
    }



    /**
	 * @description - class to generate user generated response for API calls.
	 */
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String response;
        private String limitExceed;

        /**
         * @description - constructor to set response and status code.
         * @param statusCode - status code of the mock response
         * @param response - the mock response
         */
        public MockHttpResponseGenerator(Integer statusCode, String response) {
            this.statusCode = statusCode;
            this.response = response;
        }

        /**
         * @description - Method to set response .
         * @param request - the request for the mock response
         * @return - user generated response.
         */
        public HttpResponse respond(HttpRequest request) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(this.statusCode );
            res.setBody(this.response);
            return res;
        }
    }
}
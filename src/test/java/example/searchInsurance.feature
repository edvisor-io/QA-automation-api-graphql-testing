Feature: Verify the searchInsurance query

# Background: Initialize stuff
#    Given url 'https://localhost:3100/graphql'
    

Scenario: Verify the searchInsurance query
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchInsurance {
            searchInsurance(
                filter: {
                    officeId: 3171
                    studentAge: 18,
                    destinationCountry: CA
                    policyStart: "2023-12-01",
                    policyEnd: "2024-12-02",
                }       
        ) {
            records {
            currency
            duration {
                amount
            }
            }
        }
        }    
    
    """
    And request { query: '#(query)' }
    And header Authorization = 'testAuthorization7'
    When method post
    Then status 200
    And match response == { data: '#notnull'}
   

Scenario: Authorization testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchInsurance {
            searchInsurance(
                filter: {
                    officeId: 3030
                    studentAge: 18,
                    destinationCountry: CA
                    policyStart: "2023-12-01",
                    policyEnd: "2024-12-02",
                }       
        ) {
            records {
            currency
            duration {
                amount
            }
            }
        }
        }   
    
    """
    And request { query: '#(query)' }
    And header Authorization = 'testAuthorization7'
    When method post
    Then status 200
    And print response.errors[0]
    And match response.errors[0] contains { message: "You do not have access to officeId 3030" }


Scenario: Performance testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
    query SearchInsurance {
        searchInsurance(
            filter: {
                officeId: 3171
                studentAge: 18,
                destinationCountry: CA
                policyStart: "2023-12-01",
                policyEnd: "2024-12-02",
            }       
    ) {
        records {
        currency
        duration {
            amount
        }
        }
    }
    }    
    
    """
    And request { query: '#(query)' }
    And header Authorization = 'testAuthorization7'
    When method post
    Then status 200
    And match response == { data: '#notnull'}
    And print responseTime
    And assert responseTime < 100
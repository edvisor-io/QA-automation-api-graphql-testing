Feature: Verify the userSearchDefaultSettings query

# Background: Initialize stuff
#     Given url 'https://localhost:3100/graphql'

Scenario: Verify the userSearchDefaultSettings query
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query userSearchDefaultSettings {
            userSearchDefaultSettings(
                officeId: 3171
            
        ) {
            currency
            location
            nationality
            office {
                name
                id
            }
            user {
                id
                firstName
                email
                lastName
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
    
        query userSearchDefaultSettings {
            userSearchDefaultSettings(
                officeId: 3030
            
        ) {
            currency
            location
            nationality
            office {
                name
                id
            }
            user {
                id
                firstName
                email
                lastName
            }
            }
        }
    
    """
    And request { query: '#(query)' }
    And header Authorization = 'testAuthorization7'
    When method post
    Then status 200
    And print response.errors[0]
    And match response.errors[0] contains { message: "Forbidden" }


Scenario: Performance testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query userSearchDefaultSettings {
            userSearchDefaultSettings(
                officeId: 3171
            
        ) {
            currency
            location
            nationality
            office {
                name
                id
            }
            user {
                id
                firstName
                email
                lastName
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
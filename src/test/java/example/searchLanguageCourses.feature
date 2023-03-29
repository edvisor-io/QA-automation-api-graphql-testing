Feature: Verify the searchLanguageCourses query

Scenario: Verify the searchLanguageCourses query
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchLanguageCourses {
            searchLanguageCourses(
                filter: {
                    officeId: 3171,                  
                    studentAge: 15,
                    minDurationAmount: 3,
                    durationType: WEEK,
                }       
        ) {
        metadata {
        size
        total
        }
        records {
            course {
                id 
                name
                category {
                    code
                }
            }
        }
        }   
        }
    
    """
    And request { query: '#(query)' }
    And header Authorization = token
    When method post
    Then status 200
    And match response == { data: '#notnull'}
   
Scenario: Authorization testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchLanguageCourses {
            searchLanguageCourses(
                filter: {
                    officeId: 3030,                  
                    studentAge: 15,
                    minDurationAmount: 3,
                    durationType: WEEK,
                }       
        ) {
        metadata {
        size
        total
        }
        records {
            course {
                id 
                name
                category {
                    code
                }
            }
        }
        }   
        }
    
    """
    And request { query: '#(query)' }
    And header Authorization = token
    When method post
    Then status 200    
    And print response.errors[0]
    And match response.errors[0] contains { message: "Not allowed to access the informed officeId" }


Scenario: Performance testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchLanguageCourses {
            searchLanguageCourses(
                filter: {
                    officeId: 3171,                  
                    studentAge: 15,
                    minDurationAmount: 3,
                    durationType: WEEK,
                }       
        ) {
        metadata {
        size
        total
        }
        records {
            course {
                id 
                name
                category {
                    code
                }
            }
        }
        }   
        }
    
    """
    And request { query: '#(query)' }
    And header Authorization = token
    When method post
    Then status 200
    And match response == { data: '#notnull'}
    And print responseTime
    And assert responseTime < 100        
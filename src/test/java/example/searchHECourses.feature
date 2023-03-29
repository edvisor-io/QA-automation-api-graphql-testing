Feature: Verify the searchHeCourses query

Background: Initialize stuff
    Given url postService

Scenario: Verify the searchHeCourses query
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchHECourses {
            searchHECourses(
                filter: {
                    officeId: 3171
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
            }
        }
        }
        }
    
    """
    And request { query: '#(query)' }
    And header Authorization = token
    When method post
    Then status 200
    And print response
    And match response == { data: '#notnull'}
   
Scenario: Authorization testing
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchHECourses {
            searchHECourses(
                filter: {
                    officeId: 3030
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
    And match response.errors[0] contains { message: "You do not have access to officeId 3030" }


Scenario: Performance testing
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchHECourses {
            searchHECourses(
                filter: {
                    officeId: 3171
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



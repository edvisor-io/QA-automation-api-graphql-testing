Feature: Verify the searchJuniorCourses query

# Background: Initialize stuff
#     Given url 'https://localhost:3100/graphql'

Scenario: Verify the searchHeCourses query
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchJuniorCourses {
            searchJuniorCourses(
                filter: {
                    officeId: 3171,
                    durationType: WEEK,
                    minDurationAmount: 3,
                    studentAge: 15
                }       
        ) {
            records {
            course {
                id
                name
            }
            duration {
                amount
            }
            nextStartDate
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
    
        query SearchJuniorCourses {
            searchJuniorCourses(
                filter: {
                    officeId: 3030,
                    durationType: WEEK,
                    minDurationAmount: 3,
                    studentAge: 15
                }       
        ) {
            records {
            course {
                id
                name
            }
            duration {
                amount
            }
            nextStartDate
            }
        }
        }   
    
    """
    And request { query: '#(query)' }
    And header Authorization = 'testAuthorization7'
    When method post
    Then status 200
    And print response.errors[0]
    And print response.data
    And match response.errors[0] contains { message: "You do not have access to officeId 3030" }

Scenario: Performance testing
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchJuniorCourses {
            searchJuniorCourses(
                filter: {
                    officeId: 3171,
                    durationType: WEEK,
                    minDurationAmount: 3,
                    studentAge: 15
                }       
        ) {
            records {
            course {
                id
                name
            }
            duration {
                amount
            }
            nextStartDate
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
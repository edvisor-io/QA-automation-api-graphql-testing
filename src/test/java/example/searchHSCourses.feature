Feature: Verify the searchHSCourses query

# Background: Initialize stuff
#     Given url 'https://localhost:3100/graphql'

Scenario: Verify the searchHSCourses query
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
        query SearchHighschoolCourses {
            searchHighschoolCourses(
                filter: {
                    officeId: 3171
                }       
        ) {
            records {
                course {
                    id
                    campus {
                    provider {
                        id
                        name
                    }
                    location {
                        country
                    }
                    }
                }
            }
            metadata {
                total
                totalAfterFacets
                size
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
    
    query SearchHighschoolCourses {
        searchHighschoolCourses(
            filter: {
                officeId: 3030
            }       
    ) {
        records {
            course {
                id
                campus {
                provider {
                    id
                    name
                }
                location {
                    country
                }
                }
            }
        }
        metadata {
            total
            totalAfterFacets
            size
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
    Given url 'http://localhost:3100/graphql'
    And header Content-type = 'application/json; charset=UTF-8'
    And text query = 
    """
    
    query SearchHighschoolCourses {
        searchHighschoolCourses(
            filter: {
                officeId: 3171
            }       
    ) {
        records {
            course {
                id
                campus {
                provider {
                    id
                    name
                }
                location {
                    country
                }
                }
            }
        }
        metadata {
            total
            totalAfterFacets
            size
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
    
# QA-automation-api-graphql-testing
This repo is for keep automation testing for API GraphQL that was developing by Core Services Team to keep quality of this system and use this test cases as regression tests when necessary

## Install MVN
`mvn install`

## To run all the tests (they will run on local environment, so run compose project before this)
`mvn test`

## To run all tests on staging environment
`mvn test "-Dkarate.env=staging"`

## To run a single test (using searchHECourses query as example)
`mvn test "-Dkarate.options=classpath:example/searchHECourses.feature" -Dtest=TestRunner`

Feature: Probar API de Login de la página Reqres.In

  Background:
    * url 'https://reqres.in'
    * header X-Api-Key = 'reqres-free-v1'


  Scenario: Validar función de Login por API

    Given path 'api','login'
    And request { "email": "eve.holt@reqres.in" , "password": "cityslicka" }
    When method post
    Then status 200
    And match response == { token: '#string' , token2: '#notpresent' }

  Scenario: Login Fallido

    Given path 'api','login'
    And request { "email": "peter@klaven" }
    When method post
    Then status 400

    * def error_message = response.error

    And match error_message == 'Missing password'
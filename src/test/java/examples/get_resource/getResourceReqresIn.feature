Feature: Probar API de Obtener recurso de la página Reqres.In

  Background:
    * url 'https://reqres.in'
    * header X-Api-Key = 'reqres-free-v1'


  Scenario: Validar función de Get Resource por API

    Given path 'api','unknown'
    When method get
    Then status 200

    * def resources = response.data

    And match each resources contains deep { "year": '#number' }


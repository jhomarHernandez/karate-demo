Feature: Probar API de Usuarios de la página Reqres.In

  Background:
    * url 'https://reqres.in'
    * header X-Api-Key = 'reqres-free-v1'


    Scenario: Obtener todos los usuarios y validar el primero por id

      Given path 'api','users'
      And param page = 2
      When method get
      Then status 200

      * def primero = response.data[0]
      * header X-Api-Key = 'reqres-free-v1'

      Given path 'api','users', primero.id
      When method get
      Then status 200
      And match primero.id == 7
      And match primero.first_name == 'Michael'
      And match primero contains { id: '#notnull' , avatar: '#string' }

    Scenario: Modificar usuario por id=2

      Given path 'api', 'users', '2'
      And def userRequest =
      """
      {
         "name": "morpheus",
        "job": "zion resident"
      }
      """
      And method put
      Then status 200
      And match response contains { "updatedAt" : '#present' }

    Scenario: Eliminar usuario

      Given path 'api', 'users', '2'
      And method delete
      Then status 204
@Users @ServerRest
Feature: Probar CRUD usuarios en ServerRest.Dev

  Background:
    * url 'https://serverest.dev'

    Scenario: Obtener lista de todos los usuarios

      Given path 'usuarios'
      When method get
      Then status 200

      * def listaUsuarios = response.usuarios

      Then status 200
      And match each listaUsuarios contains { _id: '#notnull' , administrador: '#string' , password: '#string' , email : '#string' , nome: '#string' }


    Scenario: Registrar un nuevo usuario con datos válidos

      * def email = generateDataByTime()
      Given path 'usuarios'
      And request
      """
      {
        "nome": "Jhomar Hernandez abc",
        "email": "#(email)",
        "password": "teste",
        "administrador": "true"
      }
      """
      When method post
      Then status 201
      And match response.message == "Cadastro realizado com sucesso"


    Scenario: Registrar un usuario con correo ya existente

      Given path 'usuarios'
      And request
      """
      {
        "nome": "Jhomar Hernandez 1",
        "email": "jhomar@qa.com.br",
        "password": "teste",
        "administrador": "true"
      }
      """
      When method post
      Then status 400
      And match response.message == "Este email já está sendo usado"


    Scenario: Buscar un registro específico por ID

      Given path 'usuarios','0MRfaldkHbt6IgvJ'
      When method get
      Then status 200
      And match response ==
      """
        {
          "nome": "Greg Wunsch",
          "email": "Jefferey13@hotmail.com",
          "password": "FFHcwvdLwCXZCpF",
          "administrador": "false",
          "_id": "0MRfaldkHbt6IgvJ"
        }
      """

    Scenario: Se puede actualizar la información de un usuario existente.

      Given path 'usuarios','0uxuPY0cbmQhpEz1'
      And request
      """
      {
        "nome": "Fulano da Silva",
        "email": "beltrano1@qa.com.br",
        "password": "teste",
        "administrador": "true"
      }
      """
      When method put
      Then status 200
      And match response.message == "Registro alterado com sucesso"


  Scenario: Se puede eliminar un usuario del sistema.

    * def email = generateDataByTime()

    Given path 'usuarios'
    And request
      """
      {
        "nome": "Jhomar Hernandez 107",
        "email": "#(email)",
        "password": "teste",
        "administrador": "false"
      }
      """
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"

    * def id = response._id

    Given path 'usuarios', id
    When method delete
    Then status 200
    And match response.message contains "Registro excluído com sucesso"

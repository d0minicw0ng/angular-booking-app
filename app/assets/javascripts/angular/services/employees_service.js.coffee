@Guru.service "EmployeesService", ["$http", "$auth", ($http, $auth) ->

  createEmployee: (registrationForm) ->
    randomPassword = @_generateRandomPassword()
    registrationForm.password = randomPassword
    registrationForm.password_confirmation = randomPassword

    $auth.submitRegistration registrationForm

  _generateRandomPassword: ->
    Math.random().toString(36).substring 2,10

  getEmployees: (scope) ->
    $http(url: "/api/v1/users", method: "GET")
      .then (data, status, headers, config) ->
        data.data

]

@Guru.service "EmployeesService", ["$http", "$auth", ($http, $auth) ->

  createEmployee: (scope) ->
    randomPassword = @_generateRandomPassword()
    scope.registrationForm.password = randomPassword
    scope.registrationForm.password_confirmation = randomPassword
    scope.registrationForm.company_id = scope.currentUser().company_id

    $auth.submitRegistration(scope.registrationForm)

  _generateRandomPassword: ->
    Math.random().toString(36).substring 2,10

  getEmployees: (scope) ->
    $http(url: "/api/v1/users", method: "GET", params: { company_id: scope.currentUser().company_id })
      .then (data, status, headers, config) ->
        scope.employees = data.data

]

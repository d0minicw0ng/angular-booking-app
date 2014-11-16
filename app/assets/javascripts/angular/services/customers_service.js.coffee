@Guru.service "CustomersService", ["$http", "$auth", ($http, $auth) ->

  createCustomer: (registrationForm) ->
    randomPassword = @_generateRandomPassword()
    registrationForm.password = randomPassword
    registrationForm.password_confirmation = randomPassword
    registrationForm.role = "customer"

    $auth.submitRegistration registrationForm

  _generateRandomPassword: ->
    Math.random().toString(36).substring 2,10

  getCustomers: ->
    $http(url: "/api/v1/customers", method: "GET")
      .then (data, status, headers, config) ->
        data.data

]

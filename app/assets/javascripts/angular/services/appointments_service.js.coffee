@Guru.service "AppointmentsService", ["$http", ($http) ->

  createAppointment: (appointment) ->
    $http.post(url: "/api/v1/appointments", appointment: appointment)

  getAppointments: ->
    $http(url: "/api/v1/appointments", method: "GET")
      .then (data, status, headers, config) ->
        data.data

]

@Guru.service "AppointmentsService", ["$http", ($http) ->

  createAppointment: (appointment) ->
    startTime = moment("#{appointment.date} #{appointment.start_time}")
    appointment.start_time = startTime.format()
    appointment.end_time = startTime.add(appointment.duration, "hours").format()
    delete appointment.duration
    delete appointment.date
    $http.post("/api/v1/appointments", { appointment: appointment })

  getAppointments: ->
    $http(url: "/api/v1/appointments", method: "GET")
      .then (data, status, headers, config) ->
        data.data

]

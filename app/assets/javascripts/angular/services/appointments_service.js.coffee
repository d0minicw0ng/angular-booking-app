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
        appointments = data.data
        appointments = appointments.map (appointment) ->
          appointment.date = moment(appointment.start_time).format "LL"
          appointment.start_time = moment(appointment.start_time).format "LT"
          appointment.end_time = moment(appointment.end_time).format "LT"
          appointment
        appointments

]

@Guru.service "AppointmentsService", ["$http", ($http) ->

  createAppointment: (appointment) ->
    self = @
    startTime = moment("#{appointment.date} #{appointment.time}")
    appointment.start_time = startTime.format()
    appointment.end_time = startTime.add(appointment.duration, "hours").format()
    $http.post("/api/v1/appointments", { appointment: appointment }).then (resp) ->
      self._setFormattedDateTime resp.data

  destroyAppointment: (id) ->
    $http.delete("/api/v1/appointments/#{id}")

  getAppointments: ->
    self = @
    $http(url: "/api/v1/appointments", method: "GET")
      .then (data, status, headers, config) ->
        appointments = data.data
        appointments = appointments.map (appointment) -> self._setFormattedDateTime appointment
        appointments

  _setFormattedDateTime: (appointment) ->
    appointment.date = moment(appointment.start_time).format "LL"
    appointment.start_time = @_setLocalTime appointment.start_time
    appointment.end_time = @_setLocalTime appointment.end_time
    appointment

  _setLocalTime: (datetime) ->
    moment(datetime).format "LT"

]

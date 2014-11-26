@Guru.service "StatisticsService", ["$http", ($http) ->

  # TODO: ability to optionally select how many months back
  appointmentsCount: ->
    $http(url: "/api/v1/appointments", method: "GET").then (data) ->
      appointments = _.map data.data, (appointment) ->
        appointment.start_time = moment(appointment.start_time)
        appointment

      groupedAppointments = _.groupBy appointments, (appointment) ->
        appointment.start_time.format("MMMM YYYY")

      appointmentsCount = {}
      for datetime, appointments of groupedAppointments
        appointmentsCount[datetime] = appointments.length

      labels = _.chain groupedAppointments
        .keys()
        .sortBy (datetime) -> moment(datetime)
        .value()

      sortedAppointmentsCount = _.map labels, (label) ->
        appointmentsCount[label]

      { appointmentsCount: sortedAppointmentsCount, labels: labels }

]

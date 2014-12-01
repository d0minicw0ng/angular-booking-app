@Guru.service "StatisticsService", ["$http", ($http) ->

  topUsers = (role, limit, date) ->
    countType = if role == "employees" then "jobs_count" else "appointments_count"
    $http(url: "/api/v1/top-#{role}", method: "GET", { limit: limit, year: moment(date).format("YYYY"), month: moment(date).format("MM") }).then (data) ->
      { labels: _.map(data.data, (user) -> user.name), count: _.map(data.data, (user) -> user[countType]) }

  topEmployees: (limit, date) ->
    topUsers "employees", limit, date

  topCustomers: (limit, date) ->
    topUsers "customers", limit, date

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

      { count: sortedAppointmentsCount, labels: labels }

]

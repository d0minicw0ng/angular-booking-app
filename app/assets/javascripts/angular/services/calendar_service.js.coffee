@Guru.service "CalendarService", ["$http", ($http) ->

  generateCalendarData: ->
    self = @
    $http(url: "/api/v1/appointments", method: "GET")
      .then (data, status, headers, config) ->
        appointments = data.data
        dataNodes = appointments.map (appointment) ->
          {
            id          : appointment.id
            start       : appointment.start_time
            end         : appointment.end_time
            content     : appointment.customer.name
            group       : appointment.masseur.id
            className   : "appointment-calendar-time"
            type        : "range"
          }

        groupedAppointments = _.groupBy appointments, (appointment) ->
          appointment.masseur.id

        groups = []
        for id, appointments of groupedAppointments
          groups.push {
            id        : id
            content   : appointments[0].masseur.name
            className : "appointment-calendar-masseur"
          }

        { data: dataNodes, groups: groups }

]

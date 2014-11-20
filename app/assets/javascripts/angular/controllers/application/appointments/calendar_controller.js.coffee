@Guru.controller "CalendarController", [
  "$scope"
  "CalendarService"
  "AppointmentsService"
  ($scope, CalendarService, AppointmentsService) ->

    $scope.timeline = null

    $scope.setDate = (date) ->
      $scope.timeline.moveTo moment(date).format("YYYY-MM-DD") if $scope.timeline

    $scope.setWindow = (start, end) ->
      $scope.timeline.setWindow
        start : start
        end   : end

    $scope.generateCalendar = (defaultDate=moment().format()) ->
      CalendarService.generateCalendarData().then (dataNodes) ->
        options =
          minHeight: "300px"
          locale: "en"
          orientation: "top"
          zoomMin: 12500000
          zoomMax: 604800000
          selectable: true
          editable:
            remove: true
            updateTime: true
            updateGroup: true
          onRemove: (data, callback) ->
            if data.end <= moment().format()
              $scope.alertDanger "APPOINTMENT.CANNOT_CHANGE_PAST_APPOINTMENT"
            else
              AppointmentsService.destroyAppointment(data.id).then ->
                callback data
                $scope.alertSuccess "APPOINTMENT.REMOVED"
              .catch ->
                callback null
                $scope.alertDanger "ERROR"
          onMove: (data, callback) ->
            AppointmentsService.updateAppointment(data).then ->
              callback data
              $scope.alertSuccess "APPOINTMENT.UPDATED"
            .catch (err) ->
              if err.data.errors.masseur_id
                $scope.alertDanger "APPOINTMENT.MASSEUR_CONFLICT"
              else if err.data.errors.customer_id
                $scope.alertDanger "APPOINTMENT.CUSTOMER_CONFLICT"
              else if moment(data.end).format() < moment().format()
                $scope.alertDanger "APPOINTMENT.BEFORE_CURRENT_TIME"
              else
                $scope.alertDanger "ERROR"

              callback null

        $scope.timeline = new vis.Timeline(
          document.getElementById("appointments-calendar"),
          new vis.DataSet(dataNodes.data),
          dataNodes.groups,
          options
        )
        $scope.setDate defaultDate
        $scope.setWindow 1416239702159, 1416313238094

    $scope.zoom = (percentage) ->
      range    = $scope.timeline.getWindow()
      interval = range.end - range.start
      start    = range.start.valueOf() - interval * percentage
      end      = range.end.valueOf()   + interval * percentage

      $scope.setWindow start, end

    $scope.pickADateOptions =
      format: "d mmmm yyyy"
      min: moment().format()
      onSet: (context) ->
        $scope.setDate context.select

    $scope.generateCalendar()

    $scope.$on "appointment-created", (ev, appointment) ->
      $("#appointments-calendar").empty()
      #TODO: Maybe just push the appointment and re-generate the graph?
      $scope.generateCalendar appointment.date

  ]

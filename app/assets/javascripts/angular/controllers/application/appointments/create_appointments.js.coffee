@Guru.controller "CreateAppointmentsController", [
  "$scope"
  "AppointmentsService"
  ($scope, AppointmentsService) ->

    $scope.addAppointment = ->
      AppointmentsService.createAppointment($scope.appointment).then (resp) ->
        $("#add-appointment-form").modal "hide"
        $scope.appointment = {}
        $scope.$emit "appointment-created", resp.data.data
      .catch (err) ->
        console.log err

  ]


@Guru.controller "AppointmentsController", [
  "$scope"
  "AppointmentsService"
  ($scope, AppointmentsService) ->
    $scope.appointments = []
    AppointmentsService.getAppointments().then (appointments) ->
      $scope.appointments = appointments

    $scope.$on "appointment-created", (ev, appointment) ->
      $scope.appointments.push appointment
  ]

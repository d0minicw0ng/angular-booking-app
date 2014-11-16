@Guru.controller "CreateAppointmentsController", [
  "$scope"
  "AppointmentsService"
  "EmployeesService"
  "CustomersService"
  ($scope, AppointmentsService, EmployeesService, CustomersService) ->

    $scope.masseurs = []
    $scope.customers = []

    EmployeesService.getEmployees().then (employees) ->
      $scope.masseurs = employees
      $("select#masseur").trigger "chosen:updated"

    CustomersService.getCustomers().then (customers) ->
      $scope.customers = customers
      $("select#customer").trigger "chosen:updated"

    $scope.pickADateOptions =
      format: "d mmmm yyyy"
      min: new Date()
    $scope.pickATimeOptions = {}

    $scope.addAppointment = ->
      AppointmentsService.createAppointment($scope.appointment).then (resp) ->
        $("#add-appointment-form").modal "hide"
        $scope.appointment = {}
        $scope.$emit "appointment-created", resp.data.data
      .catch (err) ->
        console.log err

  ]


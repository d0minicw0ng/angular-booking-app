@Guru.controller "CreateAppointmentsController", [
  "$scope"
  "$q"
  "AppointmentsService"
  "EmployeesService"
  "CustomersService"
  ($scope, $q, AppointmentsService, EmployeesService, CustomersService) ->

    $scope.masseurs = []
    $scope.customers = []
    # TODO: float is converted to int, fix it before allowing it.
    $scope.durations = [
      # { value: 0.5, text: "30 minutes" }
      { value: 1, text: "1 hour" }
      # { value: 1.5, text: "1.5 hours" }
      { value: 2, text: "2 hours" }
    ]

    $q.all([
      EmployeesService.getEmployees().then (employees) ->
        $scope.masseurs = employees
      CustomersService.getCustomers().then (customers) ->
        $scope.customers = customers
    ]).then ->
      # TODO: Very unfortunate that we have to do a setTimeout here
      # to ensure that the data is ready.
      setTimeout ->
        $("select#customer").trigger "chosen:updated"
        $("select#masseur").trigger "chosen:updated"

    $scope.pickADateOptions =
      format: "d mmmm yyyy"
      min: new Date()
    $scope.pickATimeOptions = {}

    $scope.addAppointment = ->
      AppointmentsService.createAppointment($scope.appointment).then (resp) ->
        $("#add-appointment-form").modal "hide"
        $scope.appointment = {}
        $scope.$emit "appointment-created", resp.data
      .catch (err) ->
        console.log err

  ]


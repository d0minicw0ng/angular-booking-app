@Guru.controller "EmployeesController", [
  "$scope"
  "EmployeesService"
  ($scope, EmployeesService) ->
    $scope.employees = []
    EmployeesService.getEmployees().then (employees) ->
      $scope.employees = employees

    $scope.$on "employee-created", (ev, employee) ->
      $scope.employees.push employee
  ]

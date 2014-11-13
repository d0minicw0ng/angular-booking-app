@Guru.controller "EmployeesController", [
  "$scope"
  "$http"
  "EmployeesService"
  ($scope, $http, EmployeesService) ->
    $scope.employees = []
    EmployeesService.getEmployees $scope
  ]

@Guru.controller "CreateEmployeesController", [
  "$scope"
  "$auth"
  "EmployeesService"
  ($scope, $auth, EmployeesService) ->

    $scope.submitRegistration = ->
      $scope.registrationForm.company_id = $scope.currentUser().company_id
      EmployeesService.createEmployee($scope.registrationForm).then (resp) ->
        $("#add-employee-form").modal "hide"
        $scope.registrationForm = {}
        $scope.alertSuccess "SESSION.EMPLOYEE_ADDED"
        # TODO: add the employee to the table.
      .catch (err) ->
        console.log err

  ]


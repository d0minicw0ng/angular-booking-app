@Guru.controller "CreateEmployeesController", [
  "$scope"
  "$auth"
  "$translate"
  "$state"
  "EmployeesService"
  ($scope, $auth, $translate, $state, EmployeesService) ->

    $scope.showFlashMessage = (successMessage, alertClass="success") ->
      $translate("SESSION.#{successMessage}").then (translation) ->
        $("body").prepend("<div class='alert alert-#{alertClass} fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-#{alertClass}").alert "close",
        , 2000

    $scope.submitRegistration = ->
      EmployeesService.createEmployee($scope).then (resp) ->
        $("#add-employee-form").modal "hide"
        $scope.registrationForm = {}
        $scope.showFlashMessage("EMPLOYEE_ADDED")
        # TODO: add the employee to the table.
      .catch (err) ->
        console.log err

  ]


@Guru.controller "CreateCustomersController", [
  "$scope"
  "$auth"
  "CustomersService"
  ($scope, $auth, CustomersService) ->

    $scope.submitRegistration = ->
      $scope.registrationForm.company_id = $scope.currentUser().company_id
      CustomersService.createCustomer($scope.registrationForm).then (resp) ->
        $("#add-customer-form").modal "hide"
        $scope.registrationForm = {}
        $scope.alertSuccess "SESSION.CUSTOMER_ADDED"
        $scope.$emit "customer-created", resp.data.data
      .catch (err) ->
        console.log err

  ]


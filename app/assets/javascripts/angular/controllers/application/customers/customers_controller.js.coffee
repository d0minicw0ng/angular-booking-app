@Guru.controller "CustomersController", [
  "$scope"
  "CustomersService"
  ($scope, CustomersService) ->
    $scope.customers = []
    CustomersService.getCustomers().then (customers) ->
      $scope.customers = customers

    $scope.$on "customer-created", (ev, customer) ->
      $scope.customers.push customer
  ]

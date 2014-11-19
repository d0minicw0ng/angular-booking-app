@Guru.controller "AccountsController", [
  "$scope"
  "$auth"
  ($scope, $auth) ->

    $scope.viewOnly = true
    $scope.user = $scope.currentUser()

    angular.element("#mobile-phone-number").val $scope.user.mobile_phone_number_formatted

    $scope.toggleEditMode = ->
      $scope.viewOnly = !$scope.viewOnly

    $scope.updateAccount = ->
      $auth.updateAccount($scope.user)

    $scope.$on "auth:account-update-success", (ev, data) ->
      $scope.setCurrentUser _.extend($scope.currentUser(), data.data)
      $scope.toggleEditMode()
      $scope.alertSuccess "ACCOUNT.UPDATED"

    $scope.$on "auth:account-update-error", ->
      $scope.alertDanger "ERROR"
  ]

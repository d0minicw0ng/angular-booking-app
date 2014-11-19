@Guru.controller "PasswordController", [
  "$scope"
  "$auth"
  "$state"
  ($scope, $auth, $state) ->

    $scope.updatePassword = ->
      $auth.updatePassword($scope.passwordForm)

    $scope.$on "auth:password-change-success", ->
      $state.go "dashboard.account"
      $scope.alertSuccess "ACCOUNT.UPDATED"

    $scope.$on "auth:password-change-error", ->
      $scope.alertDanger "ERROR"
  ]

@Guru.controller "ApplicationController", ($scope) ->

  $scope.currentUser = null
  $scope.setCurrentUser = (user) ->
    $scope.currentUser = user

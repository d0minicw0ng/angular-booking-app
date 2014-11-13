@Guru.controller "ApplicationController", [
  "$scope"
  "$cookieStore"
  "$auth",
  ($scope, $cookieStore, $auth) ->

    $scope.setCurrentUser = (user) ->
      $cookieStore.put "currentUser", user

    $scope.currentUser = ->
      $cookieStore.get "currentUser"

    $scope.$on "auth:login-success", (ev, user) ->
      $scope.setCurrentUser user

    $scope.$on "auth:logout-success", ->
      $cookieStore.remove "currentUser"
  ]

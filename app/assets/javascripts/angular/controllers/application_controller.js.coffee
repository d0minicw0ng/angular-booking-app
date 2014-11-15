@Guru.controller "ApplicationController", [
  "$scope"
  "$translate"
  "$cookieStore"
  "$auth",
  ($scope, $translate, $cookieStore, $auth) ->

    $scope.setCurrentUser = (user) ->
      $cookieStore.put "currentUser", user

    $scope.currentUser = ->
      $cookieStore.get "currentUser"

    $scope.$on "auth:login-success", (ev, user) ->
      $scope.setCurrentUser user

    $scope.$on "auth:logout-success", ->
      $cookieStore.remove "currentUser"

    $scope.alertSuccess = (successMessage) ->
      $translate(successMessage).then (translation) ->
        $scope.successMessage = translation
        setTimeout ->
          # TODO: what is the proper way to do this?
          $scope.successMessage = undefined
          $(".alert-success").empty()
          $(".alert-success").hide()
        , 2000
  ]

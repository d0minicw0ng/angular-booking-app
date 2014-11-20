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
        $("body").prepend("<div class='alert alert-success fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-success").remove()
        , 3000

    $scope.alertDanger = (dangerMessage) ->
      $translate(dangerMessage).then (translation) ->
        $("body").prepend("<div class='alert alert-danger fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-danger").remove()
        , 3000
  ]

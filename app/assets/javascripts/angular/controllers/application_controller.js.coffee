@Guru.controller "ApplicationController", [
  "$scope"
  "$rootScope"
  "$translate"
  "$cookieStore"
  "$auth"
  "$state",
  ($scope, $rootScope, $translate, $cookieStore, $auth, $state) ->

    $scope.setCurrentUser = (user) ->
      $cookieStore.put "currentUser", user

    $scope.currentUser = ->
      $cookieStore.get "currentUser"

    $rootScope.$on 'auth:password-reset-confirm-success', ->
      $state.go "dashboard.password"

    $scope.$on 'auth:email-confirmation-success', (ev, user) ->
      $scope.setCurrentUser user
      $state.go "dashboard"
      $scope.alertSuccess "SESSION.EMAIL_CONFIRMED"

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

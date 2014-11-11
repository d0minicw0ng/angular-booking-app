@Guru.controller "SessionsController", [
  "$scope"
  "$auth"
  "$location"
  "$translate"
  "$rootScope"
  "$state"
  ($scope, $auth, $location, $translate, $rootScope, $state) ->

    $scope.showFlashMessage = (successMessage, alertClass="success") ->
      $translate(successMessage).then (translation) ->
        $("body").prepend("<div class='alert alert-#{alertClass} fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-#{alertClass}").alert "close",
        , 5000

    $scope.submitRegistration = ->
      $auth.submitRegistration($scope.registrationForm)
        .then (resp) ->
          $("#signup-form").modal "hide"
          $scope.registrationForm = {}
          $scope.showFlashMessage("SIGNUP_SUCCESS")

        .catch (err) ->
          console.log err

    $scope.submitLogin = ->
      $auth.submitLogin($scope.loginForm).then ->
        $("#login-form").modal "hide"
        $scope.loginForm = {}
        setTimeout ->
          $state.go "dashboard"
          $scope.showFlashMessage("SIGNIN_SUCCESS")
        , 250

    $scope.$on 'auth:login-success', (ev, user) ->
      $rootScope.currentUser = user

    $scope.signOut = ->
      $auth.signOut()
        .then (resp) ->
          $rootScope.currentUser = null
          $state.go "root"
          $scope.showFlashMessage("SIGNOUT_SUCCESS", "danger")
        .catch (err) ->
          console.log err

    $scope.$on 'auth:email-confirmation-success', (ev, user) ->
      $rootScope.currentUser = user
      $state.go "dashboard"
      $scope.showFlashMessage("EMAIL_CONFIRMED")
  ]


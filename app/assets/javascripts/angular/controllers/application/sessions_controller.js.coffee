@Guru.controller "SessionsController", [
  "$scope"
  "$auth"
  "$location"
  "$translate"
  "$rootScope"
  "$state"
  ($scope, $auth, $location, $translate, $rootScope, $state) ->

    $scope.showFlashMessage = (successMessage, alertClass="success") ->
      $translate("SESSION.#{successMessage}").then (translation) ->
        $("body").prepend("<div class='alert alert-#{alertClass} fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-#{alertClass}").alert "close",
        , 2000

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
        # TODO: I am not sure why the modal hiding is not fast enough,
        # adding 250 ms for now until I know what the problem is.
        setTimeout ->
          $state.go "dashboard"
          $scope.showFlashMessage("SIGNIN_SUCCESS")
        , 250

    $scope.$on 'auth:login-success', (ev, user) ->
      $scope.setCurrentUser user

    $scope.signOut = ->
      $auth.signOut()
        .then (resp) ->
          $scope.setCurrentUser null
          $state.go "root"
          $scope.showFlashMessage("SIGNOUT_SUCCESS", "danger")
        .catch (err) ->
          console.log err

    $scope.$on 'auth:email-confirmation-success', (ev, user) ->
      $rootScope.currentUser = user
      $state.go "dashboard"
      $scope.showFlashMessage("EMAIL_CONFIRMED")
  ]


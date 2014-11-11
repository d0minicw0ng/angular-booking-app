@Guru.controller "SessionsController", ["$scope", "$auth", "$location", ($scope, $auth, $location) ->

  $scope.submitRegistration = ->
    $auth.submitRegistration($scope.registrationForm)
      .then (resp) ->
        console.log resp
        $("body").append "SUCCESS!"
      .catch (err) ->
        console.log err

  $scope.submitLogin = ->
    $auth.submitLogin($scope.loginForm)

  $scope.signOut = ->
    $auth.signOut()
      .then (resp) ->
        $state.go "landing"
      .catch (err) ->
        console.log "error"
        console.log err

  $scope.$on 'auth:login-success', (ev, user) ->
    $rootScope.currentUser = user
    $location "dashboard"
]


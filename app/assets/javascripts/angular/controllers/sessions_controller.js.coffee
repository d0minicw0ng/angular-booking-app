@Guru.controller "SessionsController", ["$scope", "$auth", "$location", ($scope, $auth, $location) ->

  $scope.submitRegistration = ->
    $auth.submitRegistration($scope.registrationForm)
      .then (resp) ->
        console.log "success"
        console.log resp
      .catch (err) ->
        console.log "error"
        console.log err

  $scope.submitLogin = ->
    $auth.submitLogin($scope.loginForm)
      .then (resp) ->
        console.log "success"
        console.log resp
        $state.go "dashboard"
      .catch (err) ->
        console.log "error"
        console.log err

  $scope.signOut = ->
    $auth.signOut()
      .then (resp) ->
        $state.go "landing"
      .catch (err) ->
        console.log "error"
        console.log err

  $scope.$on 'auth:login-success', (ev, user) ->
    console.log 'login success'
    console.log ev
    console.log user
]


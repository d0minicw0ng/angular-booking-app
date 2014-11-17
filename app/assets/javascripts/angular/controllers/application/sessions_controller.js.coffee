# TODO: Need a SessionsService to handle the logic.
@Guru.controller "SessionsController", [
  "$scope"
  "$auth"
  "$translate"
  "$state"
  "$http"
  ($scope, $auth, $translate, $state, $http) ->

    $scope.submitRegistration = ->
      # TODO: Is this quite clumsy to do the whole getting company's name here?
      companyName = $scope.private._getUsersCompanyName()
      $scope.registrationForm.role = "admin"

      $auth.submitRegistration($scope.registrationForm)
        .then (resp) ->
          # TODO: Is this better to be moved to a service?
          userId = resp.data.data.id
          $http.post("/api/v1/companies", { company: name: companyName, employee_id: userId }).then ->
            $("#signup-form").modal "hide"
            $scope.registrationForm = {}
            $scope.alertSuccess "SESSION.SIGNUP_SUCCESS"

        .catch (err) ->
          console.log err
          $scope.alertDanger("ERROR")

    $scope.private =
      _getUsersCompanyName: ->
        companyName = $scope.registrationForm.company_name
        delete $scope.registrationForm.company_name
        companyName

    $scope.submitLogin = ->
      $auth.submitLogin($scope.loginForm).then ->
        $("#login-form").modal "hide"
        $scope.loginForm = {}
        # TODO: I am not sure why the modal hiding is not fast enough,
        # adding 250 ms for now until I know what the problem is.
        setTimeout ->
          $state.go "dashboard.appointments"
          $scope.alertSuccess "SESSION.SIGNIN_SUCCESS"
        , 250
      .catch (err) ->
        $scope.alertDanger("SESSION.INVALID_CREDENTIALS")

    $scope.signOut = ->
      $auth.signOut()
        .then (resp) ->
          $state.go "root"
          $scope.alertSuccess "SESSION.SIGNOUT_SUCCESS"
        .catch (err) ->
          console.log err
          $scope.alertDanger("ERROR")

    $scope.$on 'auth:email-confirmation-success', (ev, user) ->
      $scope.setCurrentUser user
      $state.go "dashboard"
      $scope.alertSuccess "SESSION.EMAIL_CONFIRMED"
  ]


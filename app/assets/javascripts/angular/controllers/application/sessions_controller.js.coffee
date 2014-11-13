@Guru.controller "SessionsController", [
  "$scope"
  "$auth"
  "$translate"
  "$state"
  "$http"
  ($scope, $auth, $translate, $state, $http) ->

    $scope.showFlashMessage = (successMessage, alertClass="success") ->
      $translate("SESSION.#{successMessage}").then (translation) ->
        $("body").prepend("<div class='alert alert-#{alertClass} fade in' role='alert'>#{translation}</div>")
        setTimeout ->
          $(".alert-#{alertClass}").alert "close",
        , 2000

    $scope.submitRegistration = ->
      # TODO: Is this quite clumsy to do the whole getting company's name here?
      companyName = $scope.private._getUsersCompanyName()

      $auth.submitRegistration($scope.registrationForm)
        .then (resp) ->
          # TODO: Is this better to be moved to a service?
          userId = resp.data.data.id
          $http.post("/api/v1/companies", {
            company:
              name: companyName
              employee_ids: [userId]
          }).then ->
            $("#signup-form").modal "hide"
            $scope.registrationForm = {}
            $scope.showFlashMessage("SIGNUP_SUCCESS")

        .catch (err) ->
          console.log err

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
          $state.go "dashboard"
          $scope.showFlashMessage("SIGNIN_SUCCESS")
        , 250

    $scope.signOut = ->
      $auth.signOut()
        .then (resp) ->
          $state.go "root"
          $scope.showFlashMessage("SIGNOUT_SUCCESS", "danger")
        .catch (err) ->
          console.log err

    $scope.$on 'auth:email-confirmation-success', (ev, user) ->
      $scope.setCurrentUser user
      $state.go "dashboard"
      $scope.showFlashMessage("EMAIL_CONFIRMED")
  ]


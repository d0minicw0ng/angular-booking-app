@Guru = angular.module("Guru", [
  "ngCookies"
  "ng-token-auth"
  "ui.router"
  "pascalprecht.translate"
  "templates"
  "ng-rails-csrf"
  "localytics.directives"
  "angular-datepicker"
  "smart-table"
  "angularMoment"
])

@Guru.config ($authProvider) ->
  $authProvider.configure
    apiUrl: window.location.origin


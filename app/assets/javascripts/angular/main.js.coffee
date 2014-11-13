@Guru = angular.module("Guru", [
  "ngCookies"
  "ng-token-auth"
  "ui.router"
  "pascalprecht.translate"
  "templates"
])

@Guru.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr "content"
]

@Guru.config ($authProvider) ->
  # TODO: The apiUrl should depend on the environment.
  $authProvider.configure(apiUrl: "http://localhost:3000")


@Guru.config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider
    .state "root",
      url: "/"
      templateUrl: "root.html"

    .state "dashboard",
      url: "/dashboard"
      templateUrl: "dashboard.html"

    .state "dashboard.employees",
      url: "/employees"
      templateUrl: "dashboard/employees/dashboard.employees.html"

  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode true

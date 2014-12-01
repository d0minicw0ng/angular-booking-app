@Guru.controller "StatisticsController", ["$scope", "$translate", "StatisticsService", ($scope, $translate, StatisticsService) ->

  $scope.appointmentsData = {}
  $scope.employeesData = {}
  $scope.customersData = {}

  dataConfig = (data, label) ->
    labels: data.labels
    datasets: [
      {
        # TODO: translation?
        label: label
        fillColor: "rgba(151,187,205,0.2)"
        strokeColor: "rgba(151,187,205,1)"
        pointColor: "rgba(151,187,205,1)"
        pointStrokeColor: "#fff"
        pointHighlightFill: "#fff"
        pointHighlightStroke: "rgba(151,187,205,1)"
        data: data.count
      }
    ]

  StatisticsService.appointmentsCount().then (data) ->
    $translate("STATISTICS.MONTHLY_APPOINTMENTS_STATISTICS").then (translation) ->
      $scope.appointmentsData = dataConfig data, "Monthly Appointments Statistics"

  StatisticsService.topEmployees(10, moment().format("YYYY"), moment().format("MM")).then (data) ->
    $translate("STATISTICS.MONTHLY_EMPLOYEES_STATISTICS").then (translation) ->
      $scope.employeesData = dataConfig data, translation

  StatisticsService.topCustomers(10, moment().format("YYYY"), moment().format("MM")).then (data) ->
    $translate("STATISTICS.MONTHLY_CUSTOMERS_STATISTICS").then (translation) ->
      $scope.customersData = dataConfig data, translation
]

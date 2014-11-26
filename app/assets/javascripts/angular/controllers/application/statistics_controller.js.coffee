@Guru.controller "StatisticsController", ["$scope", "CONSTANTS", "StatisticsService", ($scope, CONSTANTS, StatisticsService) ->

  $scope.appointmentsData = {}
  StatisticsService.appointmentsCount().then (data) ->
    $scope.appointmentsData = {
      labels: data.labels
      datasets: [
        {
          # TODO: translation?
          label: "Monthly Appointments Statistics",
          fillColor: "rgba(151,187,205,0.2)",
          strokeColor: "rgba(151,187,205,1)",
          pointColor: "rgba(151,187,205,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(151,187,205,1)",
          data: data.appointmentsCount
        }
      ]
    }

  $scope.appointmentsOptions = {}

]

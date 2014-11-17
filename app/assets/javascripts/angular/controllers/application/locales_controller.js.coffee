@Guru.controller "LocaleController", ["$scope", "$translate", ($scope, $translate) ->

  $scope.changeLocale = (lang) ->
    $translate.use lang
    moment.locale lang

]

@Guru.directive "phone", ->
  replace: true
  restrict: "E"
  require: "ngModel"
  template: "<input class='form-control' type='text' required='required'></input>"
  link: (scope, element, attrs, ngModel) ->
    read = ->
      inputValue = element.val()
      ngModel.$setViewValue inputValue

    element.intlTelInput
      defaultCountry: "id"
      preferredCountries: "id"
      onlyCountries: ["id", "my", "cn", "ph", "tl", "vn", "th"]
    element.on "focus blur keyup change", ->
      scope.$apply read

    read()

mochis_app = angular.module('mochis_app',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

mochis_app.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'PatientsController'
      ).when('/patients/new',
        templateUrl: "form.html"
        controller: 'PatientController'
      ).when('/patients/:patientId',
        templateUrl: "show.html"
        controller: 'PatientController'
      ).when('/patients/:patientId/edit',
        templateUrl: "form.html"
        controller: 'PatientController'
      )
])

controllers = angular.module('controllers',[])
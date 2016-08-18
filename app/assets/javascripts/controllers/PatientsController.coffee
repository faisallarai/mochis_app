controllers = angular.module('controllers')
controllers.controller("PatientsController",['$scope','$routeParams','$location','$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)-> $location.path("/").search('keywords',keywords)
    Patient = $resource('/patients/:patientId', { patientId: "@id", format: 'json'})
    
    if $routeParams.keywords
      Patient.query(keywords: $routeParams.keywords, (results)-> $scope.patients = results)
    else
      $scope.patients = []

    $scope.view = (patientId)-> $location.path("/patients/#{patientId}")

    $scope.newPatient = -> $location.path("/patients/new")
    $scope.edit = -> (patientId)-> $location.path("/patients/#{patientId}/edit")
])
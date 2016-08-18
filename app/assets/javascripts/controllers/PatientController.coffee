controllers = angular.module('controllers')
controllers.controller("PatientController",['$scope','$routeParams', '$resource','$location','flash'
  ($scope,$routeParams,$resource,$location,flash)->
    Patient = $resource('/patients/:patientId', 
      { 
        patientId: "@id", format: 'json'
      },
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )

    if $routeParams.patientId
      Patient.get({patientId: $routeParams.patientId},
        ( (patient)-> $scope.patient = patient ),
        ( (httpResponse)-> 
          $scope.patient = null
          flash.error = "There is no patient with ID #{$routeParams.patientId}"
        )
      )
    else
      $scope.patient = {}


    $scope.back = -> $location.path("/")
    $scope.edit = -> $location.path("/patients/#{$scope.patient.id}/edit")
    $scope.cancel = -> 
      if $scope.patient.id
        $location.path("/patients/#{$scope.patient.id}")
      else
        $location.path("/")

    $scope.save = -> 
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.patient.id
        $scope.patient.$save(
          (()-> $location.path("/patients/#{$scope.patient.id}")),
          onError
        )
      else
        Patient.create($scope.patient,
          ((newPatient)-> $location.path("/patients/#{newPatient.id}")),
          onError
        )

    $scope.delete = -> 
      $scope.patient.$delete()
      $scope.back()
])
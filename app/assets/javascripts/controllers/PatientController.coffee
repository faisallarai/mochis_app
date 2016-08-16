controllers = angular.module('controllers')
controllers.controller("PatientController",['$scope','$routeParams', '$resource','flash'
  ($scope,$routeParams,$resource,flash)->
    Patient = $resource('/patients/:patientId', { patientId: "@id", format: 'json'})

    Patient.get({patientId: $routeParams.patientId},
      ( (patient)-> $scope.patient = patient ),
      ( (httpResponse)-> 
        $scope.patient = null
        flash.error = "There is no patient with ID #{$routeParams.patientId}"
      )
    )
])
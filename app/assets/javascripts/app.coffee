mochis = angular.module('mochis_app',[
  'templates',
  'ngRoute',
  'controllers'
])

mochis.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'PatientsController'
      )
])

patients = [ 
  {
    id: 1
    last_name: 'Mohammed-Rabiu'
    first_name: 'Anissatu'
    other_name: ''
    dob: '10-01-1987'
    phone_number: '0246559067'
    email_address: 'anissatumohammedrabiu@gmail.com'
  },
  {
    id: 2
    last_name: 'Fareed'
    first_name: 'Safia'
    other_name: ''
    dob: '10-01-1984'
    phone_number: '0240856309'
    email_address: 'safiagmail.com'
  },
  {
    id: 3
    last_name: 'Aziz'
    first_name: 'Stephanie'
    other_name: ''
    dob: '10-01-1989'
    phone_number: '0208655198'
    email_address: 'stephanie@gmail.com'
  },
]

controllers = angular.module('controllers',[])
controllers.controller("PatientsController",['$scope','$routeParams','$location',
  ($scope,$routeParams,$location)->
    $scope.search = (keywords)-> $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.patients = patients.filter (patient)-> patient.last_name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.patients = []
])
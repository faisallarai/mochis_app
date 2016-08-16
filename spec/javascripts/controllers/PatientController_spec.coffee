describe "PatientController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  location     = null
  patientId     = 1

  fakePatient   =
    id: patientId
    last_name: "Mohammed-Rabiu"
    first_name: "Anissatu"
    dob: "01/01/1989"

  setupController =(patientExists=true,patientId=1)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.patientId = patientId if patientId
      flash = _flash_

      if patientId
        request = new RegExp("\/patients/#{patientId}")
        results = if patientExists
          [200,fakePatient]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('PatientController',
                                $scope: scope)
    )

  beforeEach(module("mochis_app"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'patient is found', ->
      beforeEach(setupController())
      it 'loads the given patient', ->
        httpBackend.flush()
        expect(scope.patient).toEqualData(fakePatient)
    describe 'patient is not found', ->
      beforeEach(setupController(false))
      it 'loads the given patient', ->
        httpBackend.flush()
        expect(scope.patient).toBe(null)
        expect(flash.error).toBe("There is no patient with ID #{patientId}")

  
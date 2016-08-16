describe "PatientsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController =(keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.keywords = keywords

      if results
        request = new RegExp("\/patients.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('PatientsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("mochis_app"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())
      
      it 'defaults to no patients', ->
        expect(scope.patients).toEqualData([])

    describe 'with keywords', ->
      keywords = 'foo'
      patients = [
        {
          id: 1
          last_name: 'Mohammed-Rabiu'
          first_name: 'Anissatu'
          dob: '01/01/1987'
          phone_number: '0246559067'
          email_address: 'anissatu@gmail.com'
        },
        {
          id: 1
          last_name: 'Mohammed'
          first_name: 'Samiratu'
          dob: '01/01/1989'
          phone_number: '0246181700'
          email_address: 'samiratu@gmail.com'
        }
      ]
      beforeEach ->
        setupController(keywords,patients)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.patients).toEqualData(patients)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe("/")
      expect(location.search()).toEqualData({keywords: keywords})
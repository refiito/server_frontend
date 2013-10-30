# Get the context of the canvas element we want to select
###

###

osp = angular.module('osp', ['ngRoute']).config(($routeProvider, $locationProvider) ->
	$routeProvider.when('/controller/:controllerId',
    	templateUrl: 'controller.html',
    	controller: 'ControllerCntl'
	)
	$routeProvider.when('/controller/:controllerId/sensor/:sensorId',
		templateUrl: 'sensor.html',
		controller: 'SensorCntl'
	)

	$locationProvider.html5Mode(false)
)

osp.controller("ControllersCntl", ($scope, $http, $route, $routeParams, $location) ->
	$scope.controllers = []

	$scope.$route = $route
	$scope.$location = $location
	$scope.$routeParams = $routeParams

	$http({method: 'GET', url: 'http://zeitl.com/api/controllers'}).
  	success((data, status, headers, config) ->
  			$scope.controllers = data
  	).
  	error((data, status, headers, config) ->
  		console.log(data, status)
	)
)

osp.controller("ControllerCntl", ($scope, $routeParams) ->
	$scope.currentController = _.find($scope.controllers, (item) ->
		item.id == $routeParams.controllerId
	)
	ospMap.drawMap()
	$scope.name = "ControllerCntl"
	$scope.params = $routeParams
)

osp.controller("SensorCntl", ($scope, $routeParams) ->
	$scope.name = "SensorCntl"
	$scope.params = $routeParams
)

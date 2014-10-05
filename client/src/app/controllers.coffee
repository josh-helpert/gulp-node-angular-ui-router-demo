"use strict"

###
# Controllers
###
angular.module("app.controllers", [])

.controller("AppCtrl", ["$rootScope", "$scope", "$location",
    ($rootScope, $scope, $location) ->
        $rootScope.log = (val) ->
            console.log val
        
        $rootScope.alert = (txt) ->
            alert txt
        
        $rootScope.pageTitle = "Single identity, many accounts"

        # Uses the url to determine if the selected
        # menu item should have the class "active"
        $scope.$location = $location
        
        $scope.$watch("$location.path()", (path) ->
            $scope.activeNavId = path || "/"
        )

        # Compares the current URL with the id.
        # If the current URL starts with the id it returns "active"
        # otherwise it will return "".
        #
        # e.g.
        #   # current url = "/products/1"
        #   getClass("/products") # returns "active"
        #   getClass("/orders") # returns ""
        $scope.getClass = (id) ->
            if $scope.activeNavId.substring(0, id.length) == id
                return "active"
            else
                return ""
])

.controller("MyCtrl1", ["$scope",
    ($scope) ->
        $scope.onePlusOne = 2
])

.controller("MyCtrl2", ["$scope",
    ($scope) ->
        $scope
])

.controller("TodoCtrl", ["$scope",
    ($scope) ->
        $scope.todos = [
                text: "learn angular"
                done: true
            ,
                text: "build an angular app"
                done: false
        ]
        
        $scope.addTodo = ->
            $scope.todos.push
                text: $scope.todoText
                done: false
        
        $scope.todoText = ""
        
        $scope.remaining = ->
            count = 0
            angular.forEach $scope.todos, (todo) ->
                count += (if todo.done then 0 else 1)
            
            count
        
        $scope.archive = ->
            oldTodos = $scope.todos
            $scope.todos = []
            angular.forEach oldTodos, (todo) ->
                $scope.todos.push todo unless todo.done
])

.controller("ProviderCtrl", ["$scope", "provider",
    #($scope, $urlRouterProvider, provider) ->
    ($scope, provider) ->
        #$scope.providerID = $urlRouterProvider.providerID
        
        $scope.providers = provider.loadProviders(false)
        $scope.selectedTab = "Google"
])

.controller("AccountCtrl", ["$scope", "provider",
    ($scope, provider) ->
        # Manage the account listing
        $scope.edit = (i) ->
            $scope.$parent.log("Edit: " + i)
        
        $scope.toggleEnabled = (i) ->
            $scope.$parent.log("Toggle enabled: " + i)
        
        $scope.delete = (i) ->
            $scope.$parent.log("Delete: " + i)
        
        # Manage w/ selected account indexes
        $scope.clearIndexes = () ->
            $scope.selectedIndexes = []
        
        $scope.clearIndexes()
])

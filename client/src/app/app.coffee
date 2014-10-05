"use strict"

# Declare app level module which depends on filters, and services
angular.module("app", [
    "ui.router"
    "ui.bootstrap"
    "app.controllers"
    "app.directives"
    "app.filters"
    "app.services"
    "app.templates"
    #"partials"
    #"templates"
])

.config(["$locationProvider", "$stateProvider", "$urlRouterProvider",
    ($locationProvider, $stateProvider, $urlRouterProvider) ->
        
        $urlRouterProvider.otherwise("/")
        
        console.log "URL: " + $urlRouterProvider
        console.log "State: " + $stateProvider
        
        $stateProvider
            .state("home",
                url:"/"
                templateUrl:"common/partials/partial2.html")
            .state("providers",
                url:"/providers"
                templateUrl:"app/user_accounts/providers_partial.html"
                controller:"ProviderCtrl")
            .state("tab_test",
                url:"/tab_test"
                templateUrl:"common/partials/tab_test.html")
            .state("todo",
                url:"/todo"
                templateUrl:"common/partials/todo.html")
            .state("view1",
                url:"/view1"
                templateUrl:"common/partials/partial1.html")
            .state("view2",
                url:"/view2"
                templateUrl:"common/partials/partial2.html")

        $locationProvider.html5Mode(true)
])

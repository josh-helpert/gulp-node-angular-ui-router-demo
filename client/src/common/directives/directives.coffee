"use strict"

###
# Directives
###
angular.module("app.directives", [
    "app.services"
])

.directive("appVersion", ["version",
    (version) ->
        (scope, elm, attrs) ->
            elm.text(version)
])

.directive("showTab", [
    () ->
        (scope, elem, attrs) ->
            elem.click (e) ->
                e.preventDefault()
                $(elem).tab("show")
])

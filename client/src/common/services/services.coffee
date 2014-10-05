"use strict"

###
# Sevices
###

###
#
# table
#   tr
#     th
#       H0
#       H1
#   tr
#     td
#       v0,0
#       v0,1
#     td
#       v1,0
#       v1,1
#
# Methods to provide JSON for table:
#   - Embedded in objects in []
#       - Use 'track by' w/ index in property to properly order
#   - [[]]
#       - First element w/ header data?
#       -
#   - Separate header w/ metadata separate from values: {meta:[{}], vals:[{}]}
#       -
#   - Global, single header for request rather than for each object
#       - e.g.) {meta:{strategies:{}, accounts:{}}, vals:{strategies:{accounts:[{}, {}]}}}
###

angular.module("app.services", [])

.constant("version", "0.1")

.factory("provider", ["$http"
    ($http) ->
        metadata = [
                key:"last-login"
                value:"2014-5-23"
                description:"Previous login date."
                is_public:true
            ,
                key:"num-contacts"
                value:24
                description:"Number of immediate contacts."
                is_public:false
        ]
        
        accounts = [
                email:"abc@abc.com"
                alias:"ABC"
                description:"ABC description"
                is_active:true
                status:"active"
                justification:""
                metadata:metadata.slice(0)
            ,
                email:"123@123.com"
                alias:"123"
                description:"123 description"
                is_active:false
                status:"active"
                justification:""
                metadata:metadata.slice(0)
            ,
                email:"josh.helpert@gmail.com"
                alias:"J.Helpert Gmail Account"
                description:"Josh description"
                is_active:true
                status:"active"
                justification:""
                metadata:metadata.slice(0)
        ]
        
        accnt_arr_h = ["Email", "Alias", "Description", "Is Active", "Status", "Justification", "Metadata"]
        account_arr = [
            ["abc@abc.com", "ABC", "ABC Description", true, "active", "", metadata.slice(0)],
            ["123@123.com", "123", "123 Description", false, "active", "", metadata.slice(0)],
        ]
        
        account_h = [
            email:
                key:"email"
                pretty:"Email"
                index:0
            alias:
                key:"alias"
                pretty:"Alias"
                index:1
            description:
                key:"description"
                pretty:"Description"
                index:2
            is_active:
                key:"is_active"
                pretty:"Is Active"
                index:3
            status:
                key:"status"
                pretty:"Status"
                index:4
            justification:
                key:"justification"
                pretty:"Justification"
                index:5
            metadata:
                key:"metadata"
                pretty:"Metadata"
                index:6
        ]
        
        strategies = [
                protocol:"OAuth"
                protocol_version:"2.0"
                accounts:accounts.slice(0)
                #accounts:account_h.concat(account_arr)
            ,
                protocol:"OpenID"
                protocol_version:"1a"
                accounts:accounts.slice(0)
                #accounts:account_h.concat(account_arr)
        ]
        
        providers = [
                name:"Google"
                description:"Google Description"
                strategies:strategies.slice(0)
            ,
                name:"Facebook"
                description:"Facebook Description"
                strategies:strategies.slice(0)
            ,
                name:"Twitter"
                description:"Twitter Description"
                strategies:strategies.slice(0)
        ]
        
        isWnProviders = (i) ->
            i < 0 or i > providers.length
        
        loadProviders: (includeProto) ->
            if includeProto? || includeProto
                providers
            
            # Filter accounts while skipping strategy field
            filtered = []
            for provider in providers
                currProvider = {name:provider.name, description:provider.description}
                
                accounts = []
                accounts = accounts.concat strategy.accounts for strategy in provider.strategies
                currProvider.accounts = accounts
                
                filtered.push currProvider
            
            filtered
        
        addProvider: (provider) ->
            if provider? or provider.name? or provider.description?
                false
            
            providers.push(provider)
            true
        
        insertProvider: (i, provider) ->
            if not isWnProviders(i)
                false
            
            providers.splice(i, providers)
            true
        
        getProvider: (index) ->
            providers[index]
])

.factory("providerAPI", ["$resource"
    ($resource) ->
        #TODO: Finish this will a real test service
        {}
])

.factory("identity", ["$resource"
    ($resource) ->
        #TODO: Finish this will a real test service
        getFstName: ->
            "Josh"
        
        getLastName: ->
            "Helpert"
])

.service("authService", ["$http"
    ($http) ->
        isAuthenticated = true

        this.isLoggedIn = ->
            isAuthenticated

        this.login = (credentials) ->
            isAuthenticated

        this.logout = ->
            true
])

###
# Overview: Setup routing and handling of auth
#   TODO:
###
config = require "./../../build.config"

module.exports = (app) ->
    ###
    # Utils
    ###
    
    ###
    # STANDARD
    ###

    ###
    # Hard-coded paths w/ catch-all
    ###
    app.get "/templates.js", (req, res) ->
        res.sendfile "templates.js", root:config.public_dir

    app.get "/", (req, res) ->
        res.sendfile "index.html", root:config.public_dir
    app.get "*", (req, res) ->
        res.sendfile "index.html", root:config.public_dir


###
# Utils
###

# Log request
logRequestPath = (req, res, next) ->
    console.log req.path
    next()

# Debug the request
concatDebugReq =  (req, sep) ->
    data  = 'URL: ' + req.url + sep
    data += 'Method: ' + req.method + sep
    data += 'Headers: ' + (JSON.stringify req.headers) + sep
    data += 'Params: ' + (JSON.stringify req.params) + sep
    data += 'Body: ' + (JSON.stringify req.body) + sep
    data += 'Query: ' + (JSON.stringify req.query) + sep

express = require "express"
app = express()
config = require "../build.config"
port = process.env.PORT || config.port

###
# Configure server
###
app.use express.logger "dev"
app.use express.cookieParser()

app.use express.json()
app.use express.urlencoded()
#app.use express.multipart() # Don't use multipart (there are bugs w/ tmp files) unless needed

###
# Setup routing
###
app.use "/vendor", express.static config.bc_dir # Bower components for UI
app.use express.static config.public_dir # Serve all in public dir

setupRoutes = require("./routes/routes")
setupRoutes(app)

###
# Startup
###
app.listen port
console.log "Starting up on port " + port

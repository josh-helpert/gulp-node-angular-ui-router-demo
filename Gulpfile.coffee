###
# TODO:
#   - Move to $templateCache
#     - Minify HTML?
#   - Get watch server running
#   - Get embedded node.js preview server running
#     - Use node server to run both at once
###

gulp = require "gulp"
coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
concat = require "gulp-concat"
cached = require "gulp-cached"
changed = require "gulp-changed"
gIf = require "gulp-if"
gFilter = require "gulp-filter"
ignore = require "gulp-ignore"
jade = require "gulp-jade"
jshint = require "gulp-jshint"
livereload = require "gulp-livereload"
gMatch = "gulp-match"
remember = require "gulp-remember"
uglify = require "gulp-uglify"
srcmaps = require "gulp-sourcemaps"
rimraf = require "gulp-rimraf"
notify = require "gulp-notify"
ngTmplCache = require "gulp-angular-templatecache"
nodemon = require "gulp-nodemon"
gutil = require "gulp-util"
lazypipe = require "lazypipe"
debug = require "gulp-debug"
config = require "./build.config"

###
# Shared tasks
###
isTmplCache = (file) ->
    #console.log "is arr? " + (config.files.html.src.app instanceof Array) + ", isTmplCache: " + config.files.html.src.app
    gMatch file, config.files.html.src.app

wrapScrMap = (name, task) ->
    lazypipe()
        .pipe cached, name
        .pipe srcmaps.init
        .pipe task
        .pipe remember, name
        .pipe srcmaps.write

coffTask = (cacheName) ->
    wrapScrMap(cacheName, lazypipe()
        .pipe coffee, bare:true
        .pipe uglify)

coffLint = (name) ->
    lazypipe()
        .pipe cached, name
        .pipe coffeelint
        .pipe coffeelint.reporter

jadeTask = lazypipe()
            .pipe cached, "html"
            .pipe jade, pretty:true
            .pipe remember, "html"

jadeLint = lazypipe()
            .pipe cached, "lint:html"
            .pipe jade, pretty:true, compileDebug:true

###
# Target tasks
###
gulp.task "js", ["js:lint"], ->
    gulp.src config.files.js.src.app
        .pipe coffTask("js")()
        .pipe concat "app.min.js"
        .pipe gulp.dest config.files.js.dest

gulp.task "js:lint", ->
    gulp.src config.files.js.src.app
        .pipe coffLint("client:js:lint")()

gulp.task "js:clean", ->
    gulp.src config.js.dest, read:false
        .pipe rimraf()

#http://127.0.0.1:8080/#/view1
gulp.task "html", ->
    gulp.src config.files.html.src.app
        .pipe jadeTask()
        #.pipe gIf "!**/*/index.*", ngTmplCache()
        #.pipe gIf "**/*/partials/**/*", ngTmplCache("templates.js", root:"http:\/\/127.0.0.1/#", module:"template", standalone:true)
        #.pipe gIf "**/*/partials/**/*", ngTmplCache("templates.js", root:"http", module:"template", standalone:true)
        #.pipe gIf "**/*/partials/**/*", ngTmplCache("templates.js", root:"/#", module:"template", standalone:true)
        #.pipe gIf "**/*/partials/**/*", ngTmplCache("templates.js", module:"app.templates", standalone:true)
        .pipe gIf "!index.html", ngTmplCache("templates.js", module:"app.templates", standalone:true)
        .pipe gulp.dest config.files.html.dest

gulp.task "html:lint", ->
    gulp.src config.files.html.src.app
        .pipe jadeLint()

gulp.task "html:clean", ->
    gulp.src config.html.dest, read:false
        .pipe rimraf()

gulp.task "clean", ->
    gulp.src config.public_dir, read:false
        .pipe rimraf()

gulp.task "lint", ["html:lint", "js:lint"]

gulp.task "dev", ->
    gulp.watch config.files.js.src.app, ["js"]
    gulp.watch config.files.html.src.app, ["html"]

gulp.task "serve", (cb) ->
    nodemon
        script: "bootstrap_app.js"
        env: "NODE_ENV":"development"
        ignore: ["client/"
                 "node_modules/"
                 "node-authentication-guide/node_modules/"]
        nodeArgs: []
        watch:[config.files.server.src]
        ext: "coffee"
        #ext: "coffee js html"
        #...add nodeArgs: ['--debug=5858'] to debug 
        #..or nodeArgs: ['--debug-brk=5858'] to debug at server start
    .on "start", ->
        console.log "started"
        ###
        setTimeout ->
            livereload.changed()
        , 2000 # Wait for the server to finish loading before restarting the browsers
        ###
    .on "change", ->
        console.log "changed"
        #livereload.changed()
    .on "restart", ->
        console.log "restarted"

#gulp.task "server:js"
###
gulp.watch "dev", ->
###

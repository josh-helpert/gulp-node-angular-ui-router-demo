path = require "path"

root = __dirname + "/"
client_dir = path.join root, "client/"
public_dir = path.join client_dir, "_public/"

module.exports =
    root: root
    port: 8080
    main:"./bootstrap_app.js"
    public_dir: public_dir
    bc_dir: path.join client_dir, "bower_components/"
    
    files:
        server:
            src:"./src/"
        html:
            src:
                all: "./client/src/**/*.jade"
                index: "./client/src/index.jade"
                vendor: [
                    
                ]
                app:[
                    "./client/src/**/*.jade"
                    #"!./client/src/index.jade"
                ]
                template:[
                    "./client/src/common/templates/"
                ]
            #dest:public_dir + "html/"
            dest:public_dir
        js:
            src:
                vendor: [
                    
                ]
                app:[
                    "./client/src/**/*.coffee"
                    "!./client/src/**/_*.coffee"
                ]
            dest: path.join public_dir, "js/"
        css:
            src:
                vendor: [
                    
                ]
                app:[
                    
                ]
            dest: path.join public_dir, "css/"
        static:
            src:""
            dest:""
        test:
            src:""
            dest:""

module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        connect:
            server:
                options:
                    port: 8000
                    hostname: '*'
                    base: 'public'
                    livereload: yes
        sass:
            theme:
                options:
                    style: "expanded"
                files: [
                    expand: true
                    cwd: "themes/ridingbytes/static/scss/"
                    src: ["*.scss"]
                    dest: 'themes/ridingbytes/static/css'
                    ext: '.css'
                ]
        watch:
            theme:
                files: ["themes/ridingbytes/**/*.*"]
                tasks: ["hugo:dev"]
                options:
                    livereload: yes
            config:
                files: ["config.toml"]
                tasks: ["hugo:dev"]
                options:
                    livereload: yes

            sass:
                files: ["themes/ridingbytes/static/scss/*.scss"]
                tasks: ['sass:theme']
                options:
                    livereload: yes

    # dependencies
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    # tasks
    grunt.registerTask 'default', ["connect", "watch"]

    # hugo
    grunt.registerTask 'hugo', (target) ->
        done = @async()
        args = ['--source=.', "--destination=public", "--theme=ridingbytes"]
        if target == 'dev'
            args.push '--baseUrl=http://localhost:8000'
            args.push '--buildDrafts=true'
            args.push '--buildFuture=true'
        hugo = require('child_process').spawn 'hugo', args, stdio: 'inherit'
        (hugo.on e, -> done(true)) for e in ['exit', 'error']

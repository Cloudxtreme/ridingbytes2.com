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
            options:
                atBegin: true
                livereload: true
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

            static:
                files: ["data/**", "content/**", "archetypes/**", "media/**"]
                tasks: ['hugo:dev']
                options:
                    livereload: yes

            sass:
                files: ["themes/ridingbytes/static/scss/*.scss"]
                tasks: ['sass:theme']
                options:
                    livereload: yes

        responsive_images:
            process:
                options:
                    engine: 'gm'
                    separator: '_'
                    sizes: [
                        { rename: false, width: '100%', height: '100%' }                # Copy the source.
                        { name: '64x64', width: 64, height: 64, aspectRatio: false }    # Exact 64x64 via cropping.
                        { name: '300', width: 300, aspectRatio: true }                  # At most 300px wide.
                        { name: '400x250', width: 400, height: 250, aspectRatio: true } # At most 400px wide and 250px tall.
                    ]
                files: [
                    expand: true
                    cwd: 'img'
                    src: '**.{png,jpg,jpeg,gif}'
                    dest: 'site/static/img'
                ]

    # dependencies
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-responsive-images'

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

module.exports = (grunt) ->
  grunt.initConfig
    uglify:
      options:
        banner: ''

      my_target:
        files:
          'build/js/vendor.js': [
            'vendor/jquery/jquery.js'
          ]

    coffee:
      compile:
        files:
          'js/all.js': "coffee/*.coffee"

    stylus:
      compile:
        files:
          'css/style.css': 'stylus/style.styl'

    clean: ['js/*.js', 'css/*.css', 'build']

    watch:
      scripts:
        files: ['stylus/*.styl', 'coffee/*.coffee', 'templates/*.html']
        tasks: ['default']

    jst:
      compile:
        files:
          'js/templates/index.js': ['templates/*.html']
      options:
        processName: (filename) -> filename.replace(/templates\/|\.html/gi, '')

    connect:
      server:
        options:
          keepalive: true
          port: 8005

    copy:
      main:
        files: [
          expand: true
          src: [
            # App stuff
            'index.html'
            'js/**'
            'css/**'

            # CSS and fonts
            'vendor/normalize-css/normalize.css'
          ]
          dest: 'build'
        ]

  require('jit-grunt')(grunt)

  grunt.registerTask 'default', ['stylus', 'coffee', 'jst']
  grunt.registerTask 'build', ['default', 'copy', 'uglify']

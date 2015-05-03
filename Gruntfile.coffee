'use strict'

module.exports = (grunt)->

  # load all grunt tasks
  require('load-grunt-tasks')(grunt)

  _ = grunt.util._
  path = require 'path'

  # Project configuration.
  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      gruntfile:
        src: '<%= watch.gruntfile.files %>'
      src:
        src: '<%= watch.src.files %>'
      # test:
      #   src: '<%= watch.test.files %>'

    coffee:
      options: bare: true
      src:
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'dist/'
        ext: '.js'
      # test:
      #   expand: true
      #   cwd: 'test/'
      #   src: ['**/*.coffee']
      #   dest: 'dist/test/'
      #   ext: '.js'

    jade:
      compile:
        options:
          data:
            debug: true
        files:
          "dist/index.html": "src/index.jade"
          "dist/tray.html": "src/tray.jade"

    sass:
      options:
        sourceMap: true
      dist:
        files:
          'dist/css/styles.css': 'src/scss/styles.scss'

    # mochaTest:
    #   test:
    #     options:
    #       require: 'coffee-script/register'
    #       reporter: 'spec'
    #     src: [
    #       'test/**/*.coffee'
    #     ]

    copy:
      dist:
        files: [
          {
            cwd: './'
            dest: 'dist/'
            src: 'package.json'
          }
          {
            expand: true
            cwd: 'src'
            dest: 'dist/'
            src: [
              '**/*.png'
              'assets/fonts/**/*'
              'bower_components/**/*'
            ]
          }
        ]

    watch:
      options:
        spawn: false
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffeelint:src', 'coffee:src']
      jade:
        files: ['src/**/*.jade']
        tasks: ['jade']
      sass:
        files: ['src/**/*.scss']
        tasks: ['sass:dist']
      # test:
      #   files: ['test/**/*.coffee']
      #   tasks: ['coffeelint:test']

    clean: ['dist/']

    shell:
      install:
        command: 'cd dist && npm install --production && cd -'

  # tasks.
  grunt.registerTask 'compile', [
    'clean'
    'coffee'
    'jade'
    'sass'
    'copy'
    'shell'
  ]

  # grunt.registerTask 'test', [
  #   'coffeelint'
  #   'mochaTest'
  # ]

  grunt.registerTask 'default', [
    # 'test'
    'compile'
    'watch'
  ]

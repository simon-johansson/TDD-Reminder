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
      scripts:
        src: '<%= watch.scripts.files %>'
      # test:
      #   src: '<%= watch.test.files %>'

    coffee:
      options: bare: true
      scripts:
        expand: true
        cwd: 'scripts/'
        src: ['**/*.coffee']
        dest: 'dist/scripts'
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
          client: false
          pretty: true
        files: [
          cwd: "markup"
          src: "**/*.jade"
          dest: "dist/markup"
          expand: true
          ext: ".html"
        ]

    sass:
      options:
        sourceMap: true
      dist:
        files:
          'dist/css/styles.css': 'scss/styles.scss'

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
            expand: true
            cwd: './'
            dest: 'dist/'
            src: [
              'package.json'
              'assets/images/**/*.png'
              'assets/fonts/**/*'
            ]
          }
        ]

    watch:
      options:
        spawn: false
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']
      scripts:
        files: ['scripts/**/*.coffee']
        tasks: ['coffeelint:src', 'coffee:src']
      jade:
        files: ['markup/**/*.jade']
        tasks: ['jade']
      sass:
        files: ['scss/**/*.scss']
        tasks: ['sass:dist']
      # test:
      #   files: ['test/**/*.coffee']
      #   tasks: ['coffeelint:test']

    clean: ['dist/']

    shell:
      bower_install:
        command: 'bower install'
      npm_install:
        command: 'cd dist && npm install --production && cd -'

    nodewebkit:
      options:
        platforms: ['osx']
        buildDir: './builds'
      src: ['dist/**/*']

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

  grunt.registerTask 'build', [
    'compile'
    'nodewebkit'
  ]

  grunt.registerTask 'default', [
    # 'test'
    'compile'
    'watch'
  ]

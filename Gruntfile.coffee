"use strict"

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"

  grunt.initConfig

    copy:
      js:
        files: [
          {
            expand: true
            flatten: true
            src: [
              'bower_components/jquery/dist/jquery.min.js'
              'bower_components/jquery/dist/jquery.min.map'
              'bower_components/bootstrap/dist/js/bootstrap.min.js'
            ]
            dest: 'vendor/js/'
            filter: 'isFile'
          }
        ]
      css:
        files: [
          {
            expand: true
            flatten: true
            src: [
              'bower_components/bootstrap/dist/css/bootstrap.min.css'
              'bower_components/bootstrap/dist/css/bootstrap.min.map'
            ]
            dest: 'vendor/css/'
            filter: 'isFile'
          }
        ]

    clean: ['vendor', '_site']

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "_drafts/**/*"
          "_includes/**/*"
          "_layouts/**/*"
          "_posts/**/*"
          "css/**/*"
          "js/**/*"
          "_config.yml"
          "*.html"
          "*.md"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

  grunt.registerTask "build", [
    "clean"
    "copy"
    "exec:jekyll"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]

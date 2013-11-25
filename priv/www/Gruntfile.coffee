module.exports = (grunt) ->
  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'
    sass:
      compile:
        expand: true
        sourcemap: true
        cwd: 'css'
        src: ['*.sass']
        dest: 'css'
        ext: '.css'

    haml:
      compile:
        expand: true
        sourcemap: true
        cwd: '.'
        src: ['*.haml']
        dest: '.'
        ext: '.html'

    coffee:
      compile:
        expand: true
        flatten: true
        sourcemap: true
        cwd: 'js'
        src: ['*.coffee']
        dest: 'js'
        ext: '.js'
      

  grunt.loadNpmTasks 'grunt-contrib-haml'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['haml', 'sass', 'coffee']

module.exports =  (grunt) ->
	grunt.loadNpmTasks 'grunt-contrib-stylus'

	grunt.initConfig {
		'stylus' : {
			compile : {
				files: {
					'app/css/main.css': 'assets/css/main.styl'
				}
			}
		}
	}
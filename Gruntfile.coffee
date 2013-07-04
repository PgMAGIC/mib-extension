module.exports =  (grunt) ->
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-jade'

	grunt.initConfig {
		'stylus' : {
			compile : {
				files: {
					'app/css/main.css': 'assets/css/main.styl'
				}
			}
		},
		'coffee' : {

			glob_to_multiple: {
				expand: true,
				cwd: 'assets/js/',
				src: '**/*.coffee',
				dest: 'app/js/',
				ext: '.js'
			}
		},
		'watch' : {
			'scripts' : {
				files : 'assets/**/*.coffee',
				tasks: ['coffee']
			},
			'styles' : {
				files: 'assets/**/*.styl',
				tasks: ['stylus']
			}
		},
		jade : {
			compile: {
				files: {
					"app/options.html": ["assets/html/options.jade"]
				}
			}
		}
	}
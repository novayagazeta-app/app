var gulp = require('gulp');
var gutil = require('gulp-util');
var bower = require('bower');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var coffee = require('gulp-coffee');
var coffeelint = require('gulp-coffeelint');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var sh = require('shelljs');
var karma = require("gulp-karma");
var Server = require('karma').Server;
var args   = require('yargs').argv;


var paths = {
    sass: ['./scss/**/*.scss'],
    coffee: ['./www/coffee/**/*.coffee'],
    test: ['test/spec/**/*.coffee'],
    conf: ['./www/conf/**/*.coffee']
};

var env = args.env || 'dev';

gulp.task('default', ['sass', 'coffee', 'conf']);


gulp.task('conf', function(){
  gulp.src('./www/conf/' + env +'/conf.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./www/js/'))
});

gulp.task('lint', function () {
    gulp.src(paths.coffee)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
});

gulp.task('coffee', ['lint'], function () {
    gulp.src(paths.coffee)
        .pipe(concat('newspaper.coffee'))
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('./www/js/'))
});


gulp.task('sass', function (done) {
    gulp.src('./scss/ionic.app.scss')
        .pipe(sass({
            errLogToConsole: true
        }))
        .pipe(gulp.dest('./www/css/'))
        .pipe(minifyCss({
            keepSpecialComments: 0
        }))
        .pipe(rename({extname: '.min.css'}))
        .pipe(gulp.dest('./www/css/'))
        .on('end', done);
});

gulp.task('watch', ['default'], function () {
    gulp.watch(paths.sass, ['sass']);
    gulp.watch(paths.coffee, ['coffee']);
    gulp.watch(paths.conf, ['conf']);
});

gulp.task('install', ['git-check'], function () {
    return bower.commands.install()
        .on('log', function (data) {
            gutil.log('bower', gutil.colors.cyan(data.id), data.message);
        });
});

gulp.task('git-check', function (done) {
    if (!sh.which('git')) {
        console.log(
            '  ' + gutil.colors.red('Git is not installed.'),
            '\n  Git, the version control system, is required to download Ionic.',
            '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
            '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
        );
        process.exit(1);
    }
    done();
});


gulp.task("karma", function (done) {
  new Server({
    configFile: __dirname + '/karma.conf.coffee',
    singleRun: true
  }, done).start();
});

gulp.task("env:test", function(){
  env = 'test';
});

gulp.task("test", ["env:test", "default", "karma"]);

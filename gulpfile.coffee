gulp = require "gulp"
gutil = require "gulp-util"
bower = require "bower"
concat = require "gulp-concat"
sass = require "gulp-sass"
coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
minifyCss = require "gulp-minify-css"
rename = require "gulp-rename"
sh = require "shelljs"
karma = require "gulp-karma"
Server = require("karma").Server
args = require("yargs").argv


paths =
  sass: ["./scss/**/*.scss"]
  coffee: ["./www/coffee/**/*.coffee"]
  test: ["test/spec/**/*.coffee"]
  conf: ["./www/conf/**/*.coffee"]

env = args.env or "dev"


gulp.task "default", ["sass", "coffee", "conf"]


gulp.task "conf", ->
  gulp.src("./www/conf/#{env}/conf.coffee")
  .pipe(coffee(bare: true).on("error", gutil.log))
  .pipe gulp.dest("./www/js/")


gulp.task "lint", ->
  gulp.src(paths.coffee)
  .pipe(coffeelint())
  .pipe coffeelint.reporter()


gulp.task "coffee", ["lint"], ->
  gulp.src(paths.coffee)
  .pipe(concat("newspaper.coffee"))
  .pipe(coffee(bare: true).on("error", gutil.log))
  .pipe gulp.dest("./www/js/")


gulp.task "sass", ->
  gulp.src("./scss/ionic.app.scss")
  .pipe(sass(errLogToConsole: true))
  .pipe(gulp.dest("./www/css/"))
  .pipe(minifyCss(keepSpecialComments: 0))
  .pipe(rename(extname: ".min.css"))
  .pipe(gulp.dest("./www/css/"))


gulp.task "watch", ["default"], ->
  gulp.watch paths.sass, ["sass"]
  gulp.watch paths.coffee, ["coffee"]
  gulp.watch paths.conf, ["conf"]


gulp.task "install", ["git-check"], ->
  bower.commands.install().on "log", (data) ->
    gutil.log "bower", gutil.colors.cyan(data.id), data.message


gulp.task "git-check", (done) ->
  unless sh.which("git")
    console.log "  " + gutil.colors.red("Git is not installed."), "\n  Git, the version control system, is required to download Ionic.", "\n  Download git here:", gutil.colors.cyan("http://git-scm.com/downloads") + ".", "\n  Once git is installed, run '" + gutil.colors.cyan("gulp install") + "' again."
    process.exit 1
  done()


gulp.task "karma", ->
  server = new Server
    configFile: "#{__dirname}/karma.conf.coffee"
    singleRun: yes
  server.start()


gulp.task "env:test", -> env = "test"


gulp.task "test", ["env:test", "default", "karma"]

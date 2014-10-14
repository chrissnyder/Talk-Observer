var gulp = require('gulp');

gulp.task('build', [
  'html',
  'browserify',
  'stylus'
]);

gulp.task('build-for-deploy', [
  'build',
  'version'
]);

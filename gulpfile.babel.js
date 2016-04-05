import gulp from 'gulp';
import gulpClangFormat from 'gulp-clang-format';
import gulpEslint from 'gulp-eslint';
import path from 'path';

const basePath = path.join(__dirname, './');
const paths = {
    base: basePath,
    src: path.join(basePath, 'webapp/app/assets/javascripts/app/**/*.js')
};


gulp.task('check', ['lint-javascript', 'check-javascript-format']);

/**
 * Lints all projects JavaScript files using ESLint. This includes frontend source code, as well as,
 * build scripts.
 */
gulp.task('lint-javascript', function() {
	return gulp
	    .src(paths.src)
	    // Attach lint output to the eslint property of the file.
	    .pipe(gulpEslint())
	    // Output the lint results to the console.
	    .pipe(gulpEslint.format())
	    // Exit with an error code (1) on a lint error.
	    .pipe(gulpEslint.failOnError());
    });

/**
 * Checks whether project's JavaScript files are formatted according to clang-format style.
 */
gulp.task('check-javascript-format', function() {
	return gulp.src(paths.src)
	    .pipe(gulpClangFormat.checkFormat('file', undefined, {verbose: true, fail: true}));
    });


/**
 * Formats all project's JavaScript files using clang-format.
 */
gulp.task('format-javascript', function() {
	  return gulp
	      .src(paths.src, {base: paths.base})
	      .pipe(gulpClangFormat.format('file'))
	      .pipe(gulp.dest(paths.base));
    });

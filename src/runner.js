'use strict';

const fs = require('fs');
const yaml = require('node-yaml');
const { spawnSync } = require('child_process');

module.exports = class Runner {
    constructor (rounds, language, test) {
        if(!Number.isInteger(rounds) || rounds <= 0) {
            throw new Error("Rounds is not a positive integer.");
        }

        this.rounds = rounds;
        this.language = language;
        this.test = test;
    }

    run() {
      var tests = this.getTests();
      for (var test of tests) {
        this.runTest(test);
      }
    }

    getTests() {
      var tests = [];
      fs.readdirSync('tests').forEach(test => {
        var result = this.getTest('tests/' + test);
        if(result && (this.test === 'all' || this.test === test)) {
          tests.push(result)
        }
      });
      return tests;
    }

    getTest(test) {
      var result = yaml.readSync(process.cwd() + '/' + test + '/spec.yaml');
      if(result) {
        result.dir = test;
      }

      result.languages = [];

      fs.readdirSync(process.cwd() + '/' + test).forEach(path => {
        if(fs.lstatSync(process.cwd() + '/' + test + '/' + path).isDirectory() && (this.language === 'all' || this.language === path)) {
          result.languages.push(path);
        }
      });

      return result;
    }

    runTest(test) {
      var dataDir = test.dir.replace('tests', 'data');
      var testDir = test.dir;

      // Generate the dataset for the program
      if (fs.existsSync(test.dir + '/gen.sh')) {
        console.log('Generating: ' + test.dir);
        this.runScript(test, 'gen.sh', testDir);
      }

      for (var language of test.languages) {
        if(this.language !== 'all' && language !== this.language) {
          continue;
        }

        var langDir = testDir + '/' + language;
        var langDataDir = dataDir + '/' + language;
        if (!fs.existsSync(langDataDir)) {
          spawnSync('mkdir', ['-p', langDataDir]);
        }

        // Build the program
        if (fs.existsSync(langDir + '/build.sh')) {
          console.log('Building: ' + langDir);
          this.runScript(test, 'build.sh', langDir);
        }

        // Run the program
        if (fs.existsSync(langDir + '/run.sh')) {
          console.log('Running: ' + langDir);
          this.runScript(test, 'run.sh', langDir);
        }

        // Move language specific results
        for(var file of ['runtime.txt', 'buildtime.txt', 'stdout.txt', 'stderr.txt']) {
          if (fs.existsSync(langDir + '/' + file)) {
            fs.renameSync(langDir + '/' + file, langDataDir + '/' + file);
          } else {
            if(file !== 'buildtime.txt') {
              throw new Error("File missing: " + langDir + '/' + file);
            }
          }
        }
      }

      // Move dataset used
      if (fs.existsSync(testDir + '/dataset.txt')) {
        fs.renameSync(testDir + '/dataset.txt', dataDir + '/dataset.txt');
      }
    }

    runScript(test, script, cwd) {
      // Create cwd if it doesn't exist
      if (!fs.existsSync('./' + cwd)) {
        spawnSync('mkdir', ['-p', './' + cwd]);
      }

      var result = spawnSync(process.cwd() + '/' + cwd + '/' + script, {
        cwd: cwd
      });

      if(!result || result.status) {
        var err = 'Failed.';
        if(result.status) {
          err += ' Returned exit code: ' + result.status;
        }

        throw new Error(err);
      }

      return result;
    }
}

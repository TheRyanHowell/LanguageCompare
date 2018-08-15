#!/usr/bin/env node
'use strict';

const Runner = require('./src/runner.js');
const program = require('commander');

program
  .version('0.0.1')
  .option('-r, --rounds [optional]','how many rounds to run tests', 100)
  .option('-l, --language [optional]','which language to process', 'all')
  .option('-t, --test [optional]','which test to process', 'all')
  .parse(process.argv);

const runner = new Runner(parseInt(program.rounds), program.language, program.test);
const result = runner.run();
process.exit(result);

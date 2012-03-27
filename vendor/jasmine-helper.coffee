module.exports.runSpecSuite = (specSuite, logErrors=true) ->
  {$$} = require 'space-pen'
  nakedLoad 'jasmine'
  nakedLoad 'jasmine-atom-reporter'
  nakedLoad 'jasmine-console-reporter'
  nakedLoad 'jasmine-focused'

  $ = require 'jquery'

  $('head').append $$ ->
    @link rel: "stylesheet", type: "text/css", href: "static/jasmine.css"

  $('body').append $$ ->
    @div id: 'jasmine-content'

  reporter = if atom.headless
    new jasmine.ConsoleReporter(document, logErrors)
  else
    new jasmine.AtomReporter(document)

  require specSuite
  jasmineEnv = jasmine.getEnv()
  jasmineEnv.addReporter(reporter)
  jasmineEnv.specFilter = (spec) -> reporter.specFilter(spec)
  jasmineEnv.execute()

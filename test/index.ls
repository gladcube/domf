{catch_, $, act} = require \glad-functions
require! <[fs colors]>
jsdom = require \jsdom .jsdom
doc = jsdom "
<h1 style=\"color:#000;\">
helloworld
</h1>
<h2>This is 1st h2</h2>
<div id=\"test-top\" class=\"test-class\">
  <div id=\"test-second\" class=\"test-class-second\">
  test-second-content
  </div>
  <div id=\"test-second-next\" class=\"test-class-second test-class-sub\">
  test-second-next-content
  </div>
</div>
<div id=\"test-top-second\">
</div>
<div id=\"test-top-third\">
</div>
<div id=\"test-top-text\">
  This text is for test only　日本語でも
  <form name=\"test-form\">
  <input type=\"text\" name=\"test-input-text\" value=\"test\">
  <input type=\"button\" name=\"test-input-button\" value=\"this is test button\">
  </form>
</div>
<div id=\"test-top-layer\">
  <div id=\"test-second-layer\">
    <div id=\"test-third-layer\">
    </div>
  </div>
</div>
<div id=\"test-empty\" >
</div>
<h2 class=\"testsecond\" >This is 2nd h2</h2>

"
global.window = doc.defaultView;
global.document= window.document
do main = ->
(require "../lib/index.ls")
|> obj-to-pairs
|> each ([key, func])->
  (fix (run)-> (assertions, func)->
      | assertions |> is-type \Array |> (not) =>
        run [assertions], func
      | _ =>
        (->
          assertions
          |> each $ _, func
          |> ( .length)
          |> -> console.log "#key ok. (#it/#it)".green
        ) `catch_` ->
          console.error "#key failed. (#{it.message})".red
  ) (require "./assertions/index.ls").(key), func
module_name = ( .match /(\w+)\.ls/) >> ( .1) >> camelize >> capitalize

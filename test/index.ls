{catch_, $} = require \glad-functions
require! <[fs colors]>

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


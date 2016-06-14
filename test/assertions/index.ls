{throws, does-not-throw, equal, not-equal, ok, deep-equal, not-deep-equal} = require \assert
module.exports = new class DomfAssertion
  on_: on_ =
      (on_, document, {query, value, click})->
        query "input[name='test-input-button']" document
        |> act (withl lazy set, \value, "test button pushed", _) >> (apply on_ \click)
        |> act click
        |> value >> (equal _, "test button pushed")
  parent: parent =
      (parent, document, {query, tag_name})->
        query \BODY, document
        |> parent >> tag_name >> (equal _, \HTML)
  parents: parents =
      (parents, document, {query})->
        query \#test-third-layer, document
        |> parents |> (deep-equal _, (map (query _, document ), [
          \#test-second-layer
          \#test-top-layer
          \body
          \html
        ]) ++ document)
  children: children =
      (children, document, {query, id})->
       query \#test-top, document
        |> children >> (map id) >> (deep-equal _, <[test-second test-second-next]>)
      (children, document, {query, id})->
       query \#test-second, document
        |> children >> (map id) >> (deep-equal _, [undefined])
  classes: classes =
     (classes, document, {query})->
        <[#test-second #test-second-next]>
        |> map (query _, document) >> classes
        |> zip-with deep-equal, [<[test-class-second]> <[test-class-second test-class-sub]>]
  has_class: has_class =
      (has_class, document, {query})->
       query \#test-second, document
        |> (has_class \test-class-second) >> (equal _, true)
      (has_class, document, {query})->
       query \#test-second, document
        |> (has_class \test-class-second-not-exists) >> (equal _, false)
  add_class: add_class =
      (add_class, document, {query, classes})->
       query \#test-second, document
        |> act add_class \test-class-third-class
        |> classes >> (\test-class-third-class in) >> (equal _, true)
  remove_class: remove_class =
      (remove_class, document, {query, classes, add_class})->
       query \#test-second, document
        |> $$ [
           add_class \test-class-added
           classes >> (.contains \test-class-added) >> (equal _, true)
           remove_class \test-class-added
           classes >> (.contains \test-class-added) >> (equal _, false)
        ]
  query: query =
      (query, document, {html})->
        <[#test-second h2]>
        |> map (query _, document) >> html
        |> deep-equal _, [ "test-second-content", "This is 1st h2" ]
      (query, document)->
        query \#test-second-not-exists, document
        |> equal _, null
  query_all: query_all =
      (query_all, document, {html})->
        query_all \.test-class-second, document
        |> (map html) >> (deep-equal _, <[test-second-content test-second-next-content]>)
      (query_all, document)->
        query_all \.test-class-second-not-exists, document
        |> length >> equal _, 0
  create: create =
      (create, document, {query, html, append})->
       query \#test-third-layer, document
        |> act append (create \div, document)
        |> html >> (equal _, \<div></div>)
  attr: attr =
      (attr, document, {query})->
       query \#test-top document
        |> $$ [(attr \class), (attr \rel)] >> (deep-equal _, [\test-class null])
  set_attr: set_attr =
      (set_attr, document, {query, attr})->
       query \#test-top document
        |> set_attr \rel \test-rel
        |> (attr \rel) >> (equal _, \test-rel)
  style: style =
      (style, document, {query, style})->
       query \h1, document
        |> style \color >> (equal _, "rgb(0, 0, 0)")
      (style, document, {query, style})->
       query \#test-top-text, document
        |> style >> length >> (equal _, 0)
  set_style: set_style =
      (set_style, document, {query, style})->
       query \h1 document
        |> set_style \text-decoration \underline
        |> (style \text-decoration) >> (equal _, \underline)
  append_to: append_to =
      (append_to, document, {query, html, create})->
       query \#test-top-second document
        |> act append_to _, (create \div, document)
        |> html >> (equal _, \<div></div>)
  append: append =
      (append, document, {query, append, create, html})->
       query \#test-top-third document
        |> act append (create \p document)
        |> html >> (equal _, \<p></p>)
  select: select =
      (select, document)->
        ok false, "it\'s not testable"
  focus: focus =
      (focus, document, {query, on_, value})->
       query "input[name='test-input-text']" document
        |> $$ [
            (withl lazy set, \value, "focused", _) >> (apply on_ \focus)
            value >> (equal _, "test")
            focus
            value >> (equal _, "focused")
        ]
  blur: blur =
      (blur, document, {query, on_ ,focus, value})->
       query "input[name='test-input-text']" document
        |> $$ [
            (withl lazy set, \value, "blured", _) >> (apply on_ \blur)
            value >> (equal _, "test")
            focus
            value >> (equal _, "test")
            blur
            value >> (equal _, "blured")
        ]
  text: text =
      (text, document, {query})->
       query \#test-top-text document
        |> text >> (equal _, "This text is for test only　日本語でも")
  set_text: set_text =
      (set_text, document, {query, text})->
       query \#test-top-text document
        |> act set_text "This text is added by test"
        |> text >> (equal _, "This text is added by test")
  html: html =
      (html, document, {query})->
       query \#test-second document
        |> html >> (equal _, \test-second-content)
      (html, document, {query})->
       query \#test-empty document
        |> html >> (equal _, "")
  set_html: set_html =
      (set_html, document, {query, html})->
       query \#test-second document
        |> act set_html "<p>this is test paragraph</p>"
        |> html >> (equal _, "<p>this is test paragraph</p>")
  outer_html: outer_html =
      (outer_html, document, {query})->
       query \#test-second-next document
        |> outer_html >> (equal _, "<div id=\"test-second-next\" class=\"test-class-second test-class-sub\">
          test-second-next-content
          </div>")
  set_outer_html: set_outer_html =
      (set_outer_html, document, {query, outer_html})->
       query \#test-second-next document
        |> act set_outer_html "<div id=\"test-second-next-rewritten\">
          test-set-alternatvie-content
          </div>"
       query \#test-second-next-rewritten document
        |> outer_html >> (equal _, "<div id=\"test-second-next-rewritten\">
          test-set-alternatvie-content
          </div>")
  tag_name: tag_name =
      (tag_name, document, {query})->
       query \#test-top document
        |> tag_name >> (equal _, \DIV)
  id: id =
      (id, document, {query})->
       query \#test-top document
        |> id >> (equal _, \test-top)
  value: value =
      (value, document, {query})->
       query "input[name='test-input-text']" document
        |> value >> (equal _, \test)
  click: click =
      (click, document, {query, on_, value})->
       query "input[name='test-input-button']" document
       |> act (withl lazy set, \value, "test button pushed", _) >> (apply on_ \click)
       |> act click
       |> value >> (equal _, "test button pushed")

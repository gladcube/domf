{throws, does-not-throw, equal, not-equal, ok, deep-equal, not-deep-equal} = require \assert
{case$, catch_, dist, $, $$, act, withl, $_at, lazy, lazyhoge, Obj: {get, set, let_}} = require \glad-functions
{query: _query, classes: _classes, html: _html, add_class: _add_class, attr: _attr, outer_html: _outer_html, text: _text, create: _create, style: _style, focus: _focus, append_to: _append_to, append: _append, tag_name: _tag_name, on_:_on_, id: id_} = require \../../lib/index.ls
module.exports = new class DomfAssertion
  on_: on_ =
      (on_, document)->
        _query "input[name='test-input-button']" document
        |> act (withl lazy set, \value, "test button pushed", _) >> (apply on_ \click)
        |> act (let_ _, \click)
        |> (get \value) >> (equal _, "test button pushed")
  parent: parent =
      (parent, document)->
        _query \BODY, document
        |> parent >> _tag_name >> (equal _, \HTML)
  parents: parents =
      (parents, document)->
        _query \#test-third-layer, document
        |> parents |> (deep-equal _, (map (_query _, document ), [
          \#test-second-layer
          \#test-top-layer
          \body
          \html
        ]) ++ document)
  children: children =
      (children, document)->
        _query \#test-top, document
        |> children >> (map id_) >> (deep-equal _, <[test-second test-second-next]>)
      (children, document)->
        _query \#test-second, document
        |> children >> (map id_) >> (deep-equal _, [undefined])
  classes: classes =
     (classes, document)->
        <[#test-second #test-second-next]>
        |> map (_query _, document) >> classes
        |> zip-with deep-equal, [<[test-class-second]> <[test-class-second test-class-sub]>]
  has_class: has_class =
      (has_class, document)->
        _query \#test-second, document
        |> (has_class \test-class-second) >> (equal _, true)
      (has_class, document)->
        _query \#test-second, document
        |> (has_class \test-class-second-not-exists) >> (equal _, false)
  add_class: add_class =
      (add_class, document)->
        _query \#test-second, document
        |> act add_class \test-class-third-class
        |> _classes >> (\test-class-third-class in) >> (equal _, true)
  remove_class: remove_class =
      (remove_class, document)->
        _query \#test-second, document
        |> $$ [
           _add_class \test-class-added
           _classes >> (.contains \test-class-added) >> (equal _, true)
           remove_class \test-class-added
           _classes >> (.contains \test-class-added) >> (equal _, false)
        ]
  query: query =
      (query, document)->
        <[#test-second h2]>
        |> map (query _, document) >> _html
        |> deep-equal _, [ "test-second-content", "This is 1st h2" ]
      (query, document)->
        query \#test-second-not-exists, document
        |> equal _, null
  query_all: query_all =
      (query_all, document)->
        query_all \.test-class-second, document
        |> (map _html) >> (deep-equal _, <[test-second-content test-second-next-content]>)
      (query_all, document)->
        query_all \.test-class-second-not-exists, document
        |> (get \length) >> equal _, 0
  create: create =
      (create, document)->
        _query \#test-third-layer, document
        |> act _append (create \div, document)
        |> _html >> (equal _, \<div></div>)
  attr: attr =
      (attr, document)->
        _query \#test-top document
        |> $$ [(attr \class), (attr \rel)] >> (deep-equal _, [\test-class null])
  set_attr: set_attr =
      (set_attr, document)->
        _query \#test-top document
        |> set_attr \rel \test-rel
        |> (_attr \rel) >> (equal _, \test-rel)
  style: style =
      (style, document)->
        _query \h1, document
        |> style \color >> (equal _, "rgb(0, 0, 0)")
      (style, document)->
        _query \#test-top-text, document
        |> style >> (get \length) >> (equal _, 0)
  set_style: set_style =
      (set_style, document)->
        _query \h1 document
        |> set_style \text-decoration \underline
        |> (_style \text-decoration) >> (equal _, \underline)
  append_to: append_to =
      (append_to, document)->
        _query \#test-top-second document
        |> act append_to _, (_create \div, document)
        |> _html >> (equal _, \<div></div>)
  append: append =
      (append, document)->
        _query \#test-top-third document
        |> act append (_create \p document)
        |> _html >> (equal _, \<p></p>)
  select: select =
      (select, document)->
        ok false, "it\'s not testable"
  focus: focus =
      (focus, document)->
        _query "input[name='test-input-text']" document
        |> $$ [
            (withl lazy set, \value, "focused", _) >> (apply _on_ \focus)
            (get \value) >> (equal _, "test")
            focus
            (get \value) >> (equal _, "focused")
        ]
  blur: blur =
      (blur, document)->
        _query "input[name='test-input-text']" document
        |> $$ [
            (withl lazy set, \value, "blured", _) >> (apply _on_ \blur)
            (get \value) >> (equal _, "test")
            _focus
            (get \value) >> (equal _, "test")
            blur
            (get \value) >> (equal _, "blured")
        ]
  text: text =
      (text, document)->
        _query \#test-top-text document
        |> text >> (equal _, "This text is for test only　日本語でも")
  set_text: set_text =
      (set_text, document)->
        _query \#test-top-text document
        |> act set_text "This text is added by test"
        |> _text >> (equal _, "This text is added by test")
  html: html =
      (html, document)->
        _query \#test-second document
        |> html >> (equal _, \test-second-content)
      (html, document)->
        _query \#test-empty document
        |> html >> (equal _, "")
  set_html: set_html =
      (set_html, document)->
        _query \#test-second document
        |> act set_html "<p>this is test paragraph</p>"
        |> _html >> (equal _, "<p>this is test paragraph</p>")
  outer_html: outer_html =
      (outer_html, document)->
        _query \#test-second-next document
        |> outer_html >> (equal _, "<div id=\"test-second-next\" class=\"test-class-second test-class-sub\">
          test-second-next-content
          </div>")
  set_outer_html: set_outer_html =
      (set_outer_html, document)->
        _query \#test-second-next document
        |> act set_outer_html "<div id=\"test-second-next-rewritten\">
          test-set-alternatvie-content
          </div>"
        _query \#test-second-next-rewritten document
        |> _outer_html >> (equal _, "<div id=\"test-second-next-rewritten\">
          test-set-alternatvie-content
          </div>")
  tag_name: tag_name =
      (tag_name, document)->
        _query \#test-top document
        |> tag_name >> (equal _, \DIV)
  id: id =
      (id, document)->
        _query \#test-top document
        |> id >> (equal _, \test-top)

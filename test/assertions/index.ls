{throws, does-not-throw, equal, ok, deep-equal, not-deep-equal} = require \assert
{case$, catch_, dist, $, $$, act, withr, withl, $_at, lazy, Obj: {get, set, let_}} = require \glad-functions
{query: _query, classes: _classes, html: _html, add_class: _add_class, attr: _attr, outer_html: _outer_html, text: _text, create: _create, style: _style, focus: _focus, append_to: _append_to, append: _append} = require \../../lib/index.ls
module.exports = new class DomfAssertion
  on_: on_ =
    * (on_)->
        _query "input[name='test-input-button']" document
        |> act on_ \click, (-> @value = "test button pushed")
        |> act (.click!)
        |> (get \value) >> (equal _, "test button pushed")
  parent: parent =
     (parent)->
        _query \BODY, document
        |> parent >> (get \tagName) >> (equal _, \HTML)
  parents: parents =
    * (parents)->
        _query \#test-third-layer, document
        |> parents >> (map get \id) >> (deep-equal _, [\test-second-layer \test-top-layer "" "" undefined])
  children: children =
     (children)->
        _query \#test-top, document
        |> children >> (map get \id) >> (deep-equal _, <[test-second test-second-next]>)
     (children)->
        _query \#test-second, document
        |> children >> (map get \id) >> (deep-equal _, [undefined])
  classes: classes =
     (classes)->
        <[#test-second #test-second-next]>
        |> map (_query _,document) >> classes
        |> act $_at 0, ( deep-equal _, <[test-class-second]>)
        |> act $_at 1, ( deep-equal _, <[test-class-second test-class-sub]>)
  has_class: has_class =
     (has_class)->
        _query \#test-second, document
        |> act (has_class \test-class-second) >> (equal _, true)
     (has_class)->
        _query \#test-second, document
        |> act (has_class \test-class-second-not-exists) >> (equal _, false)
  add_class: add_class =
     (add_class)->
        _query \#test-second, document
        |> act add_class \test-class-third-class
        |> act _classes >> (.contains \test-class-third-class) >> (equal _, true)
  remove_class: remove_class =
    * (remove_class)->
        _query \#test-second, document
        |> act _add_class \test-class-added
        |> act _classes >> (.contains \test-class-added) >> (equal _, true)
        |> act remove_class \test-class-added
        |> act _classes >> (.contains \test-class-added) >> (equal _, false)
  query: query =
    * (query)->
        <[#test-second h2]>
        |> (map query _, document) >> (map _html)
        |> deep-equal _, [ "test-second-content", "This is 1st h2" ]
    * (query)->
        query \#test-second-not-exists, document
        |> equal _, null
  query_all: query_all =
     * (query_all)->
        query_all \.test-class-second, document
        |> (map _html) >> (deep-equal _, <[test-second-content test-second-next-content]>)
     * (query_all)->
        query_all \.test-class-second-not-exists, document
        |> (map _html) >> (not-deep-equal _, <[test-second-content test-second-next-content]>)
  create: create =
       (create)->
        _query \#test-third-layer, document
        |> act _append (create \div, document)
        |> _html >> (equal _, \<div></div>)
  attr: attr =
      (attr)->
        _query \#test-top document
        |> $$ [(attr \class), (attr \rel)] >> (deep-equal _, [\test-class null])
  set_attr: set_attr =
     * (set_attr)->
        _query \#test-top document
        |> act set_attr \rel \test-rel
        |> (_attr \rel) >> (equal _, \test-rel)
  style: style =
     * (style)->
        _query \h1, document
        |> style >> (.item 0) >> (equal _, \color)
     * (style)->
        _query \#test-top-text, document
        |> style >> (get \length) >> (equal _, 0)
  set_style: set_style =
    * (set_style)->
        _query \h1 document
        |> act set_style \text-decoration \underline
        |> _style >> (get \text-decoration) >> (equal _, \underline)
  append_to: append_to =
    * (append_to)->
        _create \div, document
        |> append_to  _query \#test-top-second document
        _query \#test-top-second document
        |> _html >> (equal _, \<div></div>)
  append: append =
    * (append)->
        _query \#test-top-third document
        |> act append (_create \p document)
        |> _html >> (equal _, \<p></p>)
  select: select =
     * (select)->
        ok false, "it\'s not testable"
  focus: focus =
     * (focus)->
        document.activeElement.tagName |> equal _, \BODY
        _query "input[name='test-input-text']" document |> focus
        document.activeElement.tagName |> equal _, \INPUT
  blur: blur =
     * (blur)->
        _query "input[name='test-input-text']" document |> _focus
        document.activeElement.name |> equal _, \test-input-text
        _query "input[name='test-input-text']" document |> blur
        document.activeElement.name |> equal _, undefined
  text: text =
    * (text)->
        _query \#test-top-text document
        |> text >> (equal _, "This text is for test only　日本語でも")
  set_text: set_text =
    * (set_text)->
        _query \#test-top-text document
        |> act set_text "This text is added by test"
        |> _text >> (equal _, "This text is added by test")
  html: html =
    * (html)->
        _query \#test-second document
        |> html >> (equal _, \test-second-content)
    * (html)->
        _query \#test-empty document
        |> html >> (equal _, "")
  set_html: set_html =
    * (set_html)->
        _query \#test-second document
        |> act set_html "<p>this is test paragraph</p>"
        |> _html >> (equal _, "<p>this is test paragraph</p>")
  outer_html: outer_html =
    * (outer_html)->
        _query \#test-second-next document
        |> outer_html >> (equal _, "<div id=\"test-second-next\" class=\"test-class-second test-class-sub\">
          test-second-next-content
          </div>")
  set_outer_html: set_outer_html =
    * (set_outer_html)->
        _query \#test-second-next document
        |> set_outer_html "<div id=\"test-second-next\">
          test-set-alternatvie-content
          </div>"
        _query \#test-second-next document
        |> _outer_html >> (equal _, "<div id=\"test-second-next\">
          test-set-alternatvie-content
          </div>")

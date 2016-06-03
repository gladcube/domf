{throws, does-not-throw, equal, ok} = require \assert
{case$, catch_, $, act,Obj: {get, set, let_}} = require \glad-functions
{query: _query, classes: _classes, html: _html, add_class: _add_class, attr: _attr, outer_html: _outer_html, text: _text, create: _create, style: _style, focus: _focus} = require \../../lib/index.ls
module.exports = new class DomfAssertion
  on_: on_ =
    * (on_)->
        document
        |> _query "input[name='test-input-button']"
        |> on_ "click", -> @value = "test button pushed"
        document
        |> _query "input[name='test-input-button']"
        |> (.value)
        |> equal _, "this is test button"
        document
        |> _query "input[name='test-input-button']"
        |> (.click!)
        document
        |> _query "input[name='test-input-button']"
        |> (.value)
        |> equal _, "test button pushed"
  parent: parent =
     (parent)->
        document
        |> _query \#test-second
        |> parent
        |> get \id
        |> equal _, \test-top
     (parent)->
        document
        |> _query \BODY
        |> parent
        |> (.tagName)
        |> equal _, \HTML
  parents: parents =
    * (parents)->
        document
        |> _query \#test-third-layer
        |> parents
        |> map get \id
        |> zip-with $, [(is \test-second-layer), (is \test-top-layer)]
        |> filter (is true)
        |> (.length)
        |> equal _, 2
    * (parents)->
        document
        |> _query \#test-third-layer
        |> parents
        |> map get \tagName
        |> zip-with $, [(is \DIV), (is \DIV), (is \BODY), (is \HTML)]
        |> filter (is true)
        |> (.length)
        |> equal _, 4
  children: children =
     (children)->
        document
        |> _query \#test-top
        |> children
        |> map get \id
        |> zip-with $, [(is \test-second), (is \test-second-next)]
        |> filter (is true)
        |> (.length)
        |> equal _, 2
     (children)->
        document
        |> _query \#test-second
        |> children
        |> map get \id
        |> zip-with $, [(is \test-second), (is \test-second-next)]
        |> filter (is true)
        |> (.length)
        |> equal _, 0
  classes: classes =
     (classes)->
        document
        |> _query \#test-second
        |> classes
        |> (.item 0) >> (is \test-class-second)
        |> equal _, true
     (classes)->
        document
        |> _query \#test-second
        |> classes
        |> (.item 0) >> (is \test-class-second)
        |> equal _, true
     (classes)->
        document
        |> _query \#test-second-next
        |> classes
        |> zip-with $, [(is \test-class-second), (is \test-class-sub)]
        |> filter (is true)
        |> (.length)
        |> equal _, 2
  has_class: has_class =
     (has_class)->
        document
        |> _query \#test-second
        |> has_class \test-class-second
        |> equal _, true
     (has_class)->
        document
        |> _query \#test-second
        |> has_class \test-class-second-not-exists
        |> equal _, false
  add_class: add_class =
     (add_class)->
        document
        |> _query \#test-second
        |> _classes >> (.contains \test-class-third-class)
        |> equal _, false
        document
        |> _query \#test-second
        |> add_class \test-class-third-class
        document
        |> _query \#test-second
        |> _classes >> (.contains \test-class-third-class)
        |> equal _, true
  remove_class: remove_class =
    * (remove_class)->
        document
        |> _query \#test-second
        |> _add_class \test-class-added
        document
        |> _query \#test-second
        |> _classes >> (.contains \test-class-added)
        |> equal _, true
        document
        |> _query \#test-second
        |> remove_class \test-class-added
        document
        |> _query \#test-second
        |> _classes >> (.contains \test-class-added)
        |> equal _, false
  query: query =
     * (query)->
        document
        |> query \#test-second
        |> _html
        |> equal _, \test-second-content
     * (query)->
        document
        |> query \h2
        |> _html
        |> equal _, "This is 1st h2"
     * (query)->
        document
        |> query \#test-second-not-exists
        |> equal _, null
  query_all: query_all =
     * (query_all)->
        document
        |> query_all \.test-class-second
        |> map _html
        |> zip-with $, [(is \test-second-content), (is \test-second-next-content)]
        |> filter (is true)
        |> (.length)
        |> equal _, 2
     * (query_all)->
        document
        |> query_all \.test-class-second-not-exists
        |> map _html
        |> zip-with $, [(is \test-second-content), (is \test-second-next-content)]
        |> filter (is true)
        |> (.length)
        |> equal _, 0
  create: create =
       (create)->
        create \div
        |>let_ (document |> _query \#test-third-layer),\appendChild, _
        document |> _query \#test-third-layer
        |> _html
        |> equal _, \<div></div>
  attr: attr =
      (attr)->
        document
        |> _query \#test-top
        |> attr \class
        |> equal _, \test-class
      (attr)->
        document
        |> _query \#test-top
        |> attr \rel
        |> equal _, null
  set_attr: set_attr =
     * (set_attr)->
        document
        |> _query \#test-top
        |> set_attr \rel \test-rel
        document
        |> _query \#test-top
        |> _attr \rel
        |> equal _, \test-rel
  style: style =
     * (style)->
        document
        |> _query \h1
        |> style
        |> (.item 0)
        |> equal _, \color
     * (style)->
        document
        |> _query \#test-top-text
        |> style
        |> (.length)
        |> equal _, 0
  set_style: set_style =
    * (set_style)->
        document
        |> _query \h1
        |> set_style \text-decoration \underline
        document
        |> _query \h1
        |> _style
        |> (.cssText)
        |> equal _, 'color: rgb(0, 0, 0); text-decoration: underline;'
  append_to: append_to =
    * (append_to)->
        _create \div
        |> append_to (document |> _query \#test-top-second)
        document
        |> _query \#test-top-second
        |> _html
        |> equal _, \<div></div>
  append: append =
    * (append)->
        document
        |> _query \#test-top-third
        |> append (_create  \p)
        document
        |> _query \#test-top-third
        |> _html
        |> equal _, \<p></p>
  select: select =
     * (select)->
        ok false, "it\'s not testable"
  focus: focus =
     * (focus)->
        document.activeElement.tagName
        |> equal _, \BODY
        document
        |> _query "input[name='test-input-text']"
        |> focus
        document.activeElement.tagName
        |> equal _, \INPUT
  blur: blur =
     * (blur)->
        document
        |> _query "input[name='test-input-text']"
        |> _focus
        document.activeElement.name
        |> equal _, \test-input-text
        document
        |> _query "input[name='test-input-text']"
        |> blur
        document.activeElement.name
        |> equal _, undefined
  text: text =
    * (text)->
        document
        |> _query \#test-top-text
        |> text
        |> equal _, "This text is for test only　日本語でも"
  set_text: set_text =
    * (set_text)->
        document
        |> _query \#test-top-text
        |> set_text "This text is added by test"
        document
        |> _query \#test-top-text
        |> _text
        |> equal _, "This text is added by test"
  html: html =
    * (html)->
        document
        |> _query \#test-second
        |> html
        |> equal _, \test-second-content
    * (html)->
        document
        |> _query \#test-empty
        |> html
        |> equal _, ""
  set_html: set_html =
    * (set_html)->
        document
        |> _query \#test-second
        |> set_html "<p>this is test paragraph</p>"
        document
        |> _query \#test-second
        |> _html
        |> equal _, "<p>this is test paragraph</p>"
  outer_html: outer_html =
    * (outer_html)->
        document
        |> _query \#test-second-next
        |> outer_html
        |> equal _, "<div id=\"test-second-next\" class=\"test-class-second test-class-sub\">
          test-second-next-content
          </div>"
  set_outer_html: set_outer_html =
    * (set_outer_html)->
        document
        |> _query \#test-second-next
        |> set_outer_html "<div id=\"test-second-next\">
          test-set-alternatvie-content
          </div>"
        document
        |> _query \#test-second-next
        |> _outer_html
        |> equal _, "<div id=\"test-second-next\">
          test-set-alternatvie-content
          </div>"

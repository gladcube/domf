{dist, lazy, may, when_, act, I, Obj: {get, set, let_}} = require \glad-functions
module.exports = new class Domf
  lazy_doc = lazy get, \document, global
  with_doc = apply >> (<< (dist _, [lazy_doc, id]))
  on_: on_ = (event, handler, elm)-->
    let_ elm, \addEventListener, event, handler
  parent: parent = get \parentNode
  parents: parents = (elm)->
    | (parent elm)? => [that] ++ parents that
    | _ => []
  children: children = (get \childNodes) >> map I
  classes: classes = (get \classList) >> (or [])
  has_class: has_class = (name, elm)-->
    name in (classes elm)
  add_class: add_class = (c, e)-->
    classes e |> let_ _, \add, c
  remove_class: remove_class = (c, e)-->
    classes e |> let_ _, \remove, c
  query: flip (let_ _, \querySelector, _)
  query_all: flip (let_ _, \querySelectorAll, _)
  create: create = (c, e) -->
    let_ e, \createElement, c
  attr: flip (let_ _, \getAttribute, _)
  set_attr: (k, v, e)-->
    e |> act let_ _, \setAttribute, k, v
  style: style = (k, e)-->
    e |> (get \style) >> (get k)
  set_style: set_style = (k, v, e)-->
    e |> act (get \style) >> (set k, v)
  append_to: append_to = let_ _, \appendChild, _
  append: append = flip (let_ _, \appendChild, _)
  select: let_ _, \select
  focus: let_ _, \focus
  blur: let_ _, \blur
  text: text = get \textContent
  set_text: set_text = (set \textContent)
  html: html = get \innerHTML
  set_html: set_html = set \innerHTML
  outer_html: outer_html = get \outerHTML
  set_outer_html: set_outer_html = set \outerHTML
  tag_name: tag_name = get \tagName
  id: id = get \id

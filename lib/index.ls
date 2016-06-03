{dist, lazy, may, when_, Obj: {get, set, let_}} = require \glad-functions

module.exports = new class Domf
  lazy_doc = lazy get, \document, global
  with_doc = apply >> (<< (dist _, [lazy_doc, id]))
  on_: on_ = (event, handler, elm)-->
    let_ elm, \addEventListener, event, handler
  parent: parent = get \parentNode
  parents: parents = (elm)->
    | (parent elm)? => [that] ++ parents that
    | _ => []
  children: children = (get \childNodes) >> map id
  classes: classes = (get \classList) >> (or [])
  has_class: has_class = (name, elm)-->
    name in (classes elm)
  add_class: add_class = (c, e)-->
    classes e |> let_ _, \add, c
  remove_class: remove_class = (c, e)-->
    classes e |> let_ _, \remove, c
  query: flip (let_ _, \querySelector, _)
  query_all: flip (let_ _, \querySelectorAll, _)
  create: let_ document, \createElement, _
  attr: flip (let_ _, \getAttribute, _)
  set_attr: (k, v, e)-->
    let_ e, \setAttribute, k, v
  style: style = get \style
  set_style: set_style = (k, v, e)-->
    style e |> set k, v
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

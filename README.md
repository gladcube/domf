## Usage

#### on_
Add eventlistener.
```livescript
document
|> query "input[name='input-button']"
|> on_ "click", -> @value = "button pushed"
```
#### parent
Get parent node (up to 1 hierarchy).
```livescript
document
|> query \#foo
|> parent #=> node
```
#### parents
Get parent nodes (up to root element, in most cases, to "html" element.).
```livescript
document
|> query \#foo
|> parents #=> [node, node, ...]
```
#### children
Get child nodes.
```livescript
document
|> query \#foo
|> children #=> [node, node, ...]
```
#### classes
Get classes of the element.
```livescript
document
|> query \#test-second
|> classes #=> [class,class]
```
#### has_class
Detect if element has the class,or not.
```livescript
document
|> query \#foo
|> has_class \bar #=> true or false
```
#### add_class
Add class value to the element.
```livescript
document
|> query \#foo
|> add_class \bar
```
#### remove_class
Remove class value from the element.
```livescript
document
|> query \#foo
|> remove_class \bar
```
#### query
Get the first element on which matches the selector(s).
```livescript
document
|> query \h1, \#foo #=> elem
```
#### query_all
Get all of elements on which matches the selector(s).
```livescript
document
|> query_all \.foo
```
#### create
Create the HTML element.
```livescript
element = create \div
```
```livescript
create \div
|> append_to (document |> query \#foo)
```
#### attr
Get the attribute value.
```livescript
document
|> query \#foo
|> attr \class
```
#### set_attr
Set value to the attribute.
```livescript
document
|> query \#foo
|> set_attr \rel \rel-var
```
#### style
Get style value.
```livescript
document
|> query \#foo
|> style
```
#### set_style
Set style value.
```livescript
document
|> query \h1
|> set_style \text-decoration \underline
```
#### append_to
Add the element into the other element.
```livescript
create \div
|> append_to (document |> query \#foo)
```
#### append
Add the other element in the element itself.
```livescript
document
|> query \#foo
|> append (create  \p)
```
#### select
Give all text in the text box selected.
```livescript
document
|> query "input[name='text-box']"
|> select
```
#### focus
Give focus to the element.
```livescript
document
|> query "input[name='text-box']"
|> focus
```
#### blur
Remove focus from the element.
```livescript
document
|> query "input[name='text-box']"
|> blur
```
#### text
Get the text content of the element.
```livescript
document
|> query \#foo
|> text
```
#### set_text
Set the text content into the element.
```livescript
document
|> query \#foo
|> set_text "This text is added by bar"
```
#### html
Get the HTML content of the element( not includes the element itself.)
```livescript
document
|> query \#foo
|> html
```
#### set_html
Set the HTML content into the element.
```livescript
document
|> query \#foo
|> set_html "<p>this is a paragraph</p>"
```
#### outer_html
Get the HTML content of the element( includes the element itself.)
```livescript
document
|> query \#foo
|> outer_html
```
#### set_outer_html
Replace the HTML content of the element( includes the element itself.)
```livescript
document
|> query
|> set_outer_html "<div id=\"foo\">this is the content of the element</div>"
```

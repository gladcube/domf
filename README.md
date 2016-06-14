## Usage

### index

* [on_](#on_)
* [parent](#parent)
* [parents](#parents)
* [children](#children)
* [classes](#classes)
* [has_class](#has_class)
* [add_class](#add_class)
* [remove_class](#remove_class)
* [query](#query)
* [query_all](#query_all)
* [create](#create)
* [attr](#attr)
* [set_attr](#set_attr)
* [style](#style)
* [set_style](#set_style)
* [append_to](#append_to)
* [append](#append)
* [select](#select)
* [focus](#focus)
* [blur](#blur)
* [text](#text)
* [set_text](#set_text)
* [html](#html)
* [set_html](#set_html)
* [outer_html](#outer_html)
* [set_outer_html](#set_outer_html)
* [tag_name](#tag_name)
* [id](#id)
* [value](#value)
* [click](#click)


#### on_
Add eventlistener.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <form name="foo-form">
  <input type="text" name="foo-input-text" value="foo">
  <input type="button" name="foo-input-button" value="this is foo button">
  </form>
</div>
```

[LiveScript]
```livescript
query "input[name='foo-input-button']" document
|> on_ \click, -> @value = "button pushed"
```
[LiveScript]
```livescript
query "input[name='foo-input-button']" document
|> (withl lazy set, \value, "button pushed", _ ) >> (apply on_ \click)
```

#### parent
Get parent node (up to 1 hierarchy).

[HTML]
```HTML
<div id="foo-top-layer">
  ...
  <div id="foo-second-layer">
    ...
    <div id="foo-third-layer">
      ...
    </div>
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-third-layer document
|> parent #=> elem(#foo-second-layer)
```
#### parents
Get parent nodes (up to the "document" as root, over "html" element.)

[HTML]
```HTML
<div id="foo-top-layer">
  ...
  <div id="foo-second-layer">
    ...
    <div id="foo-third-layer">
      ...
    </div>
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-third-layer document
|> parents #=> [elem(#foo-second-layer), elem(#foo-top-layer), ... document]
```
#### children
Get child nodes.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
  <div id="foo-second-next" class="foo-class-second foo-class-sub">
  foo-second-next-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> children #=> [elem(#foo-second), elem(#foo-second-next), ...]
```
#### classes
Get classes of the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
  <div id="foo-second-next" class="foo-class-second foo-class-sub">
  foo-second-next-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-second-next document
|> classes #=> [class(foo-class-second),class(foo-class-sub)]
```
#### has_class
Detect if element has the class,or not.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> has_class \foo-class #=> true

query \#foo-top document
|> has_class \foo-class-not #=> false
```
#### add_class
Add class value to the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> add_class \bar-class
```
#### remove_class
Remove class value from the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> remove_class \foo-class
```
#### query
Get the first element on which matches the selector.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document #=> elem(#foo-top)
```
#### query_all
Get all of elements on which matches the selector.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
  <div id="foo-second-next" class="foo-class-second foo-class-sub">
  foo-second-next-content
  </div>
</div>
```

[LiveScript]
```livescript
query_all \.foo-class-second  document
#=> [elem(#foo-second), elem(#foo-second-next)]
```
#### create
Create the HTML element.


[LiveScript]
```livescript
element = create \div document
```

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
create \div
|> append_to (query \#foo-top document)

#<div id="foo-top" class="foo-class">
#  <div id="foo-second" class="foo-class-second">
#  foo-second-content
#  </div>
#  <div></div>
#</div>
```
#### attr
Get the attribute value.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> attr \class #=> foo-class
```
#### set_attr
Set value to the attribute.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  ...
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> set_attr \rel \rel-var

#<div id="foo-top" class="foo-class" rel="rel-var">
#  ...
#</div>
```
#### style
Get style value.

[HTML]
```HTML
<h1 style="color:#000;">
...
</h1>
```

[LiveScript]
```livescript
query \h1 document
|> style #=> color:#000;
```
#### set_style
Set style value.

[HTML]
```HTML
<h1 style="color:#000;">
...
</h1>
```

[LiveScript]
```livescript
query \h1 document
|> set_style \text-decoration \underline
#=>
#<h1 style="color:#000;text-decoration:underline; ">
#...
#</h1>
```
#### append_to
Add the element into the other element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
create \div
|> append_to (query \#foo-top document)

#<div id="foo-top" class="foo-class">
#  <div id="foo-second" class="foo-class-second">
#  foo-second-content
#  </div>
#  <div></div>
#</div>

```
#### append
Add the other element in the element itself.

[HTML]
```HTML
<div id="foo-top" class="foo-top">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-class document
|> append (create \p document)

#<div id="foo-top" class="foo-class">
#  <div id="foo-second" class="foo-class-second">
#  foo-second-content
#  </div>
#  <p></p>
#</div>
```
#### select
Give all text in the text box selected.

[HTML]
```HTML
<div id="foo-top-text">
  <form name="foo-form">
  <input type="text" name="foo-input-text" value="foo">
  <input type="button" name="foo-input-button" value="this is foo button">
  </form>
</div>
```

[LiveScript]
```livescript
query "input[name='foo-input-text']" document
|> select

#The text "foo" that is in the text box "foo-input-text", goes to be selected

```
#### focus
Give focus to the element.

[HTML]
```HTML
<div id="foo-top-text">
  <form name="foo-form">
  <input type="text" name="foo-input-text" value="foo">
  <input type="button" name="foo-input-button" value="this is foo button">
  </form>
</div>
```

[LiveScript]
```livescript
query "input[name='foo-input-text']" document
|> focus
```
#### blur
Remove focus from the element.

[HTML]
```HTML
<div id="foo-top-text">
  <form name="foo-form">
  <input type="text" name="foo-input-text" value="foo">
  <input type="button" name="foo-input-button" value="this is foo button">
  </form>
</div>
```

[LiveScript]
```livescript
query "input[name='foo-input-text']" document
|> blur
```
#### text
Get the text content of the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
  <div id="foo-second-next" class="foo-class-second foo-class-sub">
  foo-second-next-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-second document
|> text #=> foo-second-content

```
#### set_text
Set the text content into the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-second document
|> set_text "This text is added by bar"

#<div id="foo-top" class="foo-class">
#  <div id="foo-second" class="foo-class-second">
#  This text is added by bar
#  </div>
#</div>

```
#### html
Get the HTML content of the element( not includes the element itself.)

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> html #=> <div id="foo-second" class="foo-class-second">
        #  foo-second-content
        #  </div>

```
#### set_html
Set the HTML content into the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> set_html "<p>this is a paragraph</p>"

#<div id="foo-top" class="foo-class">
#  <p>this is a paragraph</p>
#</div>
```
#### outer_html
Get the HTML content of the element( includes the element itself.)

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> outer_html #=> <div id="foo-top" class="foo-class">
                #  <div id="foo-second" class="foo-class-second">
                #  foo-second-content
                #  </div>
                #</div>
```
#### set_outer_html
Replace the HTML content of the element( includes the element itself.)

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> set_outer_html "<div id="foo">this is the content of the element</div>"

#<div id="foo">this is the content of the element</div>
```

#### tag_name
Get tag name from the element.

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> tag_name #=> "DIV"
```

#### id
Get the id value from the element.
In case you use with plelude.ls, it should conflict with that. Thus, import like below.

[import]
```
{id: id_} = require \domf
```

[HTML]
```HTML
<div id="foo-top" class="foo-class">
  <div id="foo-second" class="foo-class-second">
  foo-second-content
  </div>
</div>
```

[LiveScript]
```livescript
query \#foo-top document
|> id #=> "DIV"
```

#### value
Get the value from the element.

[HTML]
```HTML
<form name="foo-form">
<input type="text" name="foo-input-text" value="foovalue">
<input type="button" name="foo-input-button" value="this is foo button">
</form>
```

[LiveScript]
```livescript
query "input[name='foo-input-text']" document
|> value
#=>foovalue
```

#### click
Fire click event on the element.

[HTML]
```HTML
<form name="foo-form">
<input type="text" name="foo-input-text" value="foovalue">
<input type="button" name="foo-input-button" value="this is foo button">
</form>
```

[LiveScript]
```livescript
query "input[name='foo-input-button']" document
|> act (withl lazy set, \value, "foo button pushed", _) >> (apply on_ \click)
|> act click
|> value #=> "foo button pushed"
```

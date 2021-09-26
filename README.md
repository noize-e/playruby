# Ruby Playground

## LinksReader / Snippet

The idea behind this snippet came from the need of finding from a list with hundreds of records, all the ones related to a specific topic.

For example, given the following list

__bookmarks.txt__
```
https://docs.docker.com/language/golang/build-images/ | Build your Go image | Docker Documentation
https://www.google.com/search?client=firefox-b-e&q=inner+css+box+shadow | inner css box shadow - Google Search
https://css-tricks.com/snippets/css/css-box-shadow/ | CSS Box Shadow | CSS-Tricks
https://www.google.com/search?client=firefox-b-e&q=WP_Query | WP_Query - Google Search
https://developer.wordpress.org/reference/functions/the_post/ | the_post() | Function | WordPress Developer Resources
https://developer.wordpress.org/reference/functions/the_excerpt/ | the_excerpt() | Function | WordPress Developer Resources
...
```

Complete list check it here

If only the wanted urls are the ones realted to __`docker`__, the only thing to do is, from a terminal console execute:

```bash
>_ app.rb < bookmarks.txt
```

Then the application shows a list with all the titles from the filtered records.  Now, if a specific title wants to be opened in a web browser, send the ID to the app with the interactive panel.

The development workflow consits of 2 phases.

1. Read and classify the list records
2. The Iiteractive panel

### Phase1: Read and parse the urls

#### Display the records titles

Create a new file __`app.rb`__, then load and intialize the __`Links`__ object. Pass as argument the __`ARGF`__ object(_stream for use in scripts that process files given as command-line arguments or passed in via STDIN._) calling its method __`readlines`__(_returns the contents of the given file as an array_).

Specify the topic filter to apply and then call the titles list.

```ruby
require './lib/links_reader'

links = Links.new(ARGF.readlines)
p links.filter("docker").titles
```

Once executed from the terminal it shows:

```
[[1, "Build your Go image | Docker Documentation"]]
```

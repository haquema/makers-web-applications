# Using HTML 

_**This is a Makers Bite.** Bites are designed to train specific skills or
tools. They contain an intro, a demonstration video, some exercises with an
example solution video, and a challenge without a solution video for you to test
your learning. [Read more about how to use Makers
Bites.](https://github.com/makersacademy/course/blob/main/labels/bites.md)_

Learn to return HTML responses to be viewed in a web browser.

## Intro

Web browsers are clients. When a web browser sends a request and receives a response, that response is displayed to the user.

If that response contains HTML code, that code is interpreted and transformed into a user-friendly web page.

Whenever you visit a website using your web browser, the following happens behind the scenes:
  * the web browser sends a `GET` request to the server.
  * the web browser receives the response.
  * the web browser interprets the HTML code to know what to display.
  * the web browser shows a graphical web page (with text, images, buttons, etc) to the user.

It's important to note that this process happens **again for every new page**.

If we reload the page, the same process happens. If we visit a different page, the same process happens.

Every time we visit a URL, the web browser acts as a client — it sends a `GET` request to this URL and path, gets the response, and interprets the HTML as a user-friendly web page. It is really important that you keep this in mind when building, using and debugging your web applications, to have a good idea of what is happening.

## Returning HTML

To avoid putting HTML code in our app file, we write the HTML in a separate file, also called a _view file_.

This file is in a `views/` directory and has a `.erb` extension. We'll see later why.

```
app.rb
lib/
  ...
views/
  index.erb
```

```ruby
# file: app.rb
require 'sinatra/base'

class WebApplication < Sinatra::Base 

  get '/' do
    return erb(:index)
  end
end
```

```html
<!-- file: views/index.erb -->
<html>
  <head></head>
  <body>
    <h1>Welcome to my page</h1>
  </body>
</html>
```

## Testing for HTML content

```ruby
context "GET to /" do
  it 'contains a h1 title' do
    response = get('/')

    expect(response.status).to include('<h1>Hello</h1>')
  end
  
  it 'contains a div' do
    response = get('/')

    expect(response.status).to include('<div>')
  end
end
```

## Demonstration

@TODO

## Exercise

In the project `hello_web_project`.

Test-drive and update the `GET /hello` route so it returns the greeting message as an HTML page:

```html
<html>
  <head></head>
  <body>
    <h1>Hello!</h1>
  </body>
</html>
```

_(Don't forget to run the app using `rackup`)._

Use your web browser to access the page.


[Next Challenge](02_using_erb_dynamic_page.md)

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-applications&prefill_File=html_bites/01_page_structure.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-applications&prefill_File=html_bites/01_page_structure.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-applications&prefill_File=html_bites/01_page_structure.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-applications&prefill_File=html_bites/01_page_structure.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/web-applications&prefill_File=html_bites/01_page_structure.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
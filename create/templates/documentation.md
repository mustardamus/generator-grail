# Component `{{name}}`

## Description

Here you should shortly describe what the component is about.

## Data

Here you should list the data the component is associated with and what it is
doing (eg. a `blog-form` component):

    title:     'No title specified'
    content:   '# My blog post'     # will be filtered through markdown
    date:      Date.now()           # can be unix time or date string
    tags:      []                   # array of tags, can be blank
    published: false

## Events

Here you should list all events the component is listening to and is
dispatching (eg. a 'blog-form').

### Events Listening

    updateTitle(newTitle) # sets the data 'title' to 'newTitle'
    publish(boolean)      # sets the data 'published' to true or false

### Events Dispatching

    updatedTitle(newTitle) # dispatches 'newTitle' when data 'title' has changed
    published(boolean)     # dispatches true or false when the data 'published' changed

## Attributes?

You can give the component attributes with `v-attr`. That is useful if the
functionality is slightly different depending how to use the component.

## Dependencies

Components can depend on other components. List them here:

    edit-form
    markdown-preview

## Notes

Most of the time random things pop in your head. Save them here. Curate them
later (also with this readme-template).

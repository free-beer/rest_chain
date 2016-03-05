# RestChain

RestChain is a library to wrap REST API calls and make their use look and feel
like standard method calls. RestChain is based on the Rest Client library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rest_chain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rest_chain

## Usage

First thing to do is to require in the library. Do this bad adding a line like
the following to the top of your script...

```ruby
require "rest_chain"
```

Next you need to create a ```RestChain::Chain``` object. The ```Chain``` class
constructor takes a Hash of setting options and recognises the following keys
in this Hash...

 * ```:host``` A String containing the name of the host on which the REST API
               service is running. You must specify this value.

 * ```:logger``` A Logger class instance that the ```Chain``` will use for
                 logging purposes. This is optional.

 * ```:parameters``` A Hash of common parameters (i.e. parameters that are to
                     be part of all requests). This is optional.

 * ```:path``` An Array or String of the common parts of the path used in REST
               API URLs. For example if the path for all REST API URLs started
               with /api/v1/ you could specify these in this parameter to avoid
               having to repeatedly specify them on chained REST calls. This is
               optional.

 * ```:port``` The port number the REST API service is listening on. Only needed
               if the service is running on a non-standard port (i.e. 80 for HTTP
               services or 443 for HTTPS services). This is optional.

 * ```:scheme``` The protocol scheme to be used when making REST API requests.
                 Options are "http" or "https". This is optional with the default
                 being "https".

So creating a new ```Chain``` object might look as follows...

```ruby
chain = RestChain::Chain.new(host: "myresthost.com", path: ["api", "v1"])
```

Once you have a ```Chain``` object you can make requests against it. Lets say
you wished to fetch the details for a specific user from your REST service and
the URL to do that looked as follows

```
https://myresthost.com/api/v1/users/<user id>
```

Where the ```<user id>``` part will be replaced by the unique identifier of the
users whose details are to be retrieved. You could use the ```Chain``` object to
fetch a user with an id of 123 as follows...

```ruby
response = chain.users(123).get
```

Note that if there were parameters that you wanted to append to the request (e.g.
a session id) then you can specify them as part of the 'verb' method that is used
to initiate the request. So, using the previous example as a basis, you could add
the session id like this...

```ruby
response = chain.users(123).get(session_id: session.id)
```

Methods are provided for the ```delete```, ```get```, ```patch```, ```post``` and
```put``` verbs that all work in a similar fashion.

This call would return a ```RestChain::RestResponse``` object. This object will
possess details for the response received for the request including the status
code of the response, the headers and the response body. If you knew your response
would contain JSON formatted content then you could convert that directly to a
Ruby equivalent using...

```ruby
response.json
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rest_chain/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

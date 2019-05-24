# web-runtime-container

The web-runtime-container is that isolated runtime environment for Ruby and Node.js.  

# Getting started

First, I recommend you to edit $PWD that in docker-compose.yml to project installation path.  
e.g:

```
        WORKDIR: $PWD/..
        RUBY_VERSION: 2.6.3
        NODE_VERSION: 10.15.3 
    ports:
     - "3000:3000"
    volumes:
     - $PWD/..:$PWD/..
```

Set up a Ruby on Rails application like following:

```sh
% docker-compose run --rm web bundle init
% vi Gemfile
gem "rails" # uncomment this and save file.
% docker-compose run --rm web bundle install --path vendor/bundle
% docker-compose run --rm web bundle exec rails new . # overwrite the Gemfile
% vi Gemfile
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # comment out this line and add `gem 'tzinfo-data'` 
gem 'tzinfo-data'
% rm Gemfile.lock
% docker-compose run --rm web bundle install # install tzinfo-data
% docker-compose run --rm --service-ports web bin/rails server -p 3000 -b 0.0.0.0
```

# Change language version

Edit following lines in docker-compose.yml:

```
        RUBY_VERSION: 2.6.3
        NODE_VERSION: 10.15.3 
```

The container will be built at the next time `docker-compose run`

# Known issue

Following Warnings will be displayed when execute node.  

```
% docker-compose run --rm web node -v
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
node: /usr/lib/libstdc++.so.6: no version information available (required by node)
v10.15.3
```

# Licence

MIT

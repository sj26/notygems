import React, { Component } from 'react';
import { Input } from 'reactstrap';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="container">
          <div className="justify-content-sm-center row">
            <h1>Rubygems</h1>
            <p>To install a gem from here:</p>
            <pre>gem install --clear-sources --source http://gems.railscamp.local GEM</pre>
            <p>Or tell bundler to use this as a mirror:</p>
            <pre>bundle config --global mirror.https://rubygems.org http://gems.railscamp.local</pre>
            <p>Or add this as the source in your Gemfile:</p>
            <pre>source "http://gems.railscamp.local"</pre>
            <h2>When you get home</h2>
            <pre>bundle config --delete mirror.https://rubygems.org</pre>
          </div>
        </div>
      </div>
    );
  }
}

export default App;

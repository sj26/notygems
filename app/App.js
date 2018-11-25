import React, { Component } from 'react';
import Header from './Header.js';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="container">
          <div className="justify-content-sm-center row">
            <div className="col-sm-8">
              <Header title="Rubygems" />
              <p>To install a single gem from here:</p>
              <pre>gem install --clear-sources --source http://gems.railscamp.local GEM</pre>
              <p>Or tell rubygems to always use this mirror by adding sources to your <code>~/.gemrc</code></p>
              <pre>:sources: ["http://gems.railscamp.local"]</pre>
              <p>but remember to remove this line when you get home.</p>
              <p>Or tell bundler to always use this mirror:</p>
              <pre>bundle config --global mirror.https://rubygems.org http://gems.railscamp.local</pre>
              <p>but make sure you tell it to stop when you get home by deleting the mirror from <code>~/.bundle/config</code>, or run:</p>
              <pre>bundle config --delete mirror.https://rubygems.org</pre>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default App;

import React, { Component } from 'react';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <h1>Rubygems</h1>
        <p>To install a gem from here:</p>
        <pre>gem install --clear-sources --source http://gems.railscamp.local GEM</pre>
        <p>Or tell bundler to use this as a mirror:</p>
        <pre>bundle config --global mirror.https://rubygems.org http://gems.railscamp.local</pre>
        <p>Or add this as the source in your Gemfile:</p>
        <pre>source "http://gems.railscamp.local"</pre>
        <h2>When you get home</h2>
        <p>Bundler will continue to use this mirror until you tell it to stop. To fix it, open <code>~/.bundle/config</code> in your favourite editor and remove the line which contains <code>railscamp</code>. Or you can run the following command:</p>
        <pre>bundle config --delete mirror.https://rubygems.org</pre>
      </div>
    );
  }
}

export default App;

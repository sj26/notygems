import React, { Component } from 'react';
import { Input } from 'reactstrap';
import './App.css';

class Header extends Component {
  render() {
    return (
      <div className="d-flex align-items-center">
        <h1>{this.props.title}</h1>
        <Input className="ml-auto" type="search" name="search" id="search" placeholder="Search gems..." style={{width: "20rem"}} />
      </div>
    )
  }
}

export default Header;

import React from 'react'
import ReactDOM from 'react-dom'
import ApolloClient from "apollo-boost";
import gql from "graphql-tag";
import Player from './player.js'

import '../session_player/styles/session_player'

const client = new ApolloClient({
  uri: "/graphql"
});

let sessionData = {}
let player;

class SessionPlayer extends React.Component {

  constructor(props){
    super(props)
    this.state = {
      playing: false,
      sessionDuration: 1
    };

    this.handleChangeDuration = this.handleChangeDuration.bind(this);
  }

  render(){
    return (
      <div>
        <div className="play-button-wrapper">
          <div className="play-button" onClick={ () => this.playNextSession() }>
        </div>

        </div>
        <input type="number" onChange={ this.handleChangeDuration } value={ this.state.sessionDuration }/>
      </div>
    )
  }


  handleChangeDuration(event) {
    this.setState({ sessionDuration: event.target.value});
  }


  parseSession(data) {
    sessionData = data.data.nextSession
    player = new Player(sessionData.blocks.map(block => { return block.audio }), this)
    player.play()
    this.setState({ playing: true });
  }

  getNextSession(){
    if(this.state.playing)
      return

    client.query({
      query: gql`
    {
      nextSession(length: ${this.state.sessionDuration * 60} ) {
        blocks {
          transcript
          audio
        }
      }
    }
    `
    }).then(result => this.parseSession(result));
  }

  playNextSession(){
    this.getNextSession()
  }

}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <SessionPlayer/>,
    document.getElementById('session-player')
  )
})


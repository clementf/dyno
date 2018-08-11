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
  }

  render(){
    return (
      <div>
        <div className="play-button-wrapper">
          <div className="play-button" onClick={ () => this.playNextSession() }></div>
        </div>

        <div className="controls-wrapper">
          <span className="controls" onClick={ () => this.decrementSessionDuration() }>-</span>
          <span>
            <div>{ this.state.sessionDuration }</div>
            <div>min</div>
          </span>
          <span className="controls" onClick={ () => this.incrementSessionDuration() }>+</span>
        </div>
      </div>
    )
  }


  incrementSessionDuration(){
    let oldValue = this.state.sessionDuration

    if(oldValue < 10)
      this.setState({ sessionDuration: oldValue + 1});
  }

  decrementSessionDuration(){
    let oldValue = this.state.sessionDuration

    if(oldValue > 1)
      this.setState({ sessionDuration: oldValue - 1});
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


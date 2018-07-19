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
    this.playing = false;
  }

  render(){
    return (
      <div className="play-button" onClick={ () => this.playNextSession() }>
      </div>
    )
  }

  parseSession(data) {
    sessionData = data.data.nextSession
    player = new Player(sessionData.blocks.map(block => { return block.audio }), this)
    player.play()
    this.playing = true;
  }

  getNextSession(){
    if(this.playing)
      return

    client.query({
      query: gql`
    {
      nextSession {
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


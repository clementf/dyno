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
      loading: false,
      showLogin: false,
      sessionDuration: 1
    };
  }

  render(){
    if(this.state.showLogin == true) {
      return (
        <div>
          <p className="content-inner">
            <strong>
              Well done! A little bit of this everyday and you'll rock it! ✌ <br/>
            </strong>
            <strong>
              Register to keep track of your progress and get new tailored content.
            </strong>
          </p>
            <a className="button" href="/users/sign_up">Register</a>
        </div>
        )
    }

    else {
      return (
        <div>
          <div className="play-button-wrapper">
            <div className={`play-button ${ this.state.playing ? 'pause' : 'play' }` } onClick={ () => this.togglePlay() }>
              <span className="left"></span><span className="right"></span>
            </div>
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
    this.player = new Player(sessionData.blocks.map(block => { return block.audio }), this)
    this.setState({loading: false})
    this.play()
  }

  getNextSession(){
    this.setState({loading: true})

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

  togglePlay(){
    if(this.state.loading)
      return;

    if(!this.player){
      this.getNextSession()
      return;
    }

    if(this.state.playing)
      this.pause()
    else
      this.play()
  }

  pause(){
    this.setState(
      { playing: false },
      () => this.player.pause()
    );
  }

  play(){
    this.setState(
      { playing: true },
      () => this.player.play()
    );
  }

  finish(){
    if(!loggedIn) {
      this.setState(
        {
          showLogin: true
        }
      )
    }
  }

}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <SessionPlayer/>,
    document.getElementById('session-player')
  )
})


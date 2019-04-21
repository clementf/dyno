import React from 'react'
import ReactDOM from 'react-dom'
import ApolloClient from "apollo-boost";
import gql from "graphql-tag";
import Player from './player.js'

import '../lesson_player/styles/lesson_player'

const client = new ApolloClient({
  uri: "/graphql"
});

let lessonData = {}
let player;

class LessonPlayer extends React.Component {

  constructor(props){
    super(props)

    this.state = {
      playing: false,
      loading: false,
      showLogin: false,
      lessonDuration: 1
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
            <span className="controls" onClick={ () => this.decrementLessonDuration() }>-</span>
            <span>
              <div>{ this.state.lessonDuration }</div>
              <div>min</div>
            </span>
            <span className="controls" onClick={ () => this.incrementLessonDuration() }>+</span>
          </div>
        </div>
      )
    }
  }

  incrementLessonDuration(){
    let oldValue = this.state.lessonDuration

    if(oldValue < 10)
      this.setState({ lessonDuration: oldValue + 1});
  }

  decrementLessonDuration(){
    let oldValue = this.state.lessonDuration

    if(oldValue > 1)
      this.setState({ lessonDuration: oldValue - 1});
  }

  parseLesson(data) {
    lessonData = data.data.nextLesson
    this.player = new Player(lessonData.blocks.map(block => {
      return [block.original.audio, block.translation.audio ]
    }).flat(), this)
    this.setState({loading: false})
    this.play()
  }

  getNextLesson(){
    this.setState({loading: true})

    client.query({
      query: gql`
    {
      nextLesson(length: ${this.state.lessonDuration * 60} ) {
        blocks {
          original {
            content,
            audio
          },
          translation {
            content,
            audio
          }
        }
      }
    }
    `
    }).then(result => this.parseLesson(result));
  }

  togglePlay(){
    if(this.state.loading)
      return;

    if(!this.player){
      this.getNextLesson()
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
    <LessonPlayer/>,
    document.getElementById('lesson-player')
  )
})


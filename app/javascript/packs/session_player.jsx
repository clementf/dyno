import React from 'react'
import ReactDOM from 'react-dom'
import ApolloClient from "apollo-boost";
import gql from "graphql-tag";
import Player from './player.js'

const client = new ApolloClient({
  uri: "http://localhost:5000/graphql"
});

let sessionData = {}
let player;

function parseNextSession(data) {
  sessionData = data.data.nextSession
  player = new Player(sessionData.blocks.map(block => { return block.audio }))
  player.play()
}

client
  .query({
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
  })
  .then(result => parseNextSession(result));

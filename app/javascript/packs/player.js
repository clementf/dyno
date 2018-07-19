import { Howl, Howler } from 'howler';

class Player {
  constructor(playlistElems, sessionManager) {
    this.sessionManager = sessionManager
    this.playlist = playlistElems.map(playlistItem => {
    console.log(playlistItem)
      return new Howl({
        src: [playlistItem],
      });
    })

    this.currentPosition = 0
  }


  playNext(){
    var endOfPlaylist = this.currentPosition == this.playlist.length - 1
    if(endOfPlaylist){
      this.sessionManager.playing = false
      return
    }
    this.currentPosition = endOfPlaylist ? 0 : this.currentPosition + 1
    this.play();
  }

  play(){
    var hacky = this
    var sound = this.playlist[this.currentPosition]

    sound.play()
    sound.on('end', function(){
      window.setTimeout(function(){
        hacky.playNext()
      }, 1500)
    });

  }

}

export default Player;

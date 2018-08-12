import { Howl, Howler } from 'howler';

class Player {
  constructor(playlistElems, sessionManager) {
    this.sessionManager = sessionManager
    this.playlist = playlistElems.map(playlistItem => {

      return new Howl({
        src: [playlistItem],
      });
    })

    this.currentPosition = 0
  }

  play(){
    if(!this.sessionManager.state.playing)
      return

    var hack_this = this
    var sound     = this.playlist[this.currentPosition]

    var endOfPlaylist    = this.currentPosition == this.playlist.length - 1
    this.currentPosition = endOfPlaylist ? 0 : this.currentPosition + 1

    if(endOfPlaylist){
      this.sessionManager.pause()
      return
    }

    sound.play()
    sound.on('end', function(){
      if(!hack_this.sessionManager.state.playing)
        return

      hack_this.nextSound = window.setTimeout(function(){
        hack_this.play();
      }, 1500)
    });
  }

  pause(){
    window.clearTimeout(this.nextSound)
  }
}

export default Player;

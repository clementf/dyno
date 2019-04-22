import { Howl, Howler } from 'howler';

class Player {
  constructor(audio, lessonManager) {
    this.lessonManager = lessonManager
    this.playlist = audio.map(item => {

      return new Howl({
        src: [item],
        pool: 1,
      });
    })

    this.currentPosition = 0
  }

  play(){
    if(!this.lessonManager.state.playing)
      return

    var player = this
    var sound    = this.playlist[this.currentPosition]

    sound.play()

    sound.on('end', function(){
      // Unbind this sound from this event,
      // otherwise confusion occurs when restarting playlist from start
      this.off('end')

      var endOfPlaylist    = player.currentPosition == player.playlist.length - 1

      player.currentPosition = (player.currentPosition + 1) % player.playlist.length

      if(endOfPlaylist){
        player.lessonManager.pause()
        player.lessonManager.finish()
      }
      else {
        // Every word is a playlist item, so pause a little longer every two
        let waitTime = player.currentPosition % 2 == 1 ? 500 : 1500

        player.nextSound = window.setTimeout(function(){
          player.play();
        }, waitTime)
      }
    });
  }

  pause(){
    var sound = this.playlist[this.currentPosition]
    sound.stop() // stop current word
    sound.off('end') // unbind end event
    window.clearTimeout(this.nextSound) // Dont play next word
  }
}

export default Player;

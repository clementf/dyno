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

    var hack_this = this
    var sound     = this.playlist[this.currentPosition]

    var endOfPlaylist    = this.currentPosition == this.playlist.length - 1

    if(endOfPlaylist){
      this.lessonManager.pause()
      this.lessonManager.finish()
      this.currentPosition = 0;
      return
    }

    sound.play()
    sound.on('end', function(){
      hack_this.currentPosition = endOfPlaylist ? 0 : hack_this.currentPosition + 1
      if(!hack_this.lessonManager.state.playing)
        return

      // Every word is a playlist item, so pause a little longer every two
      let waitTime = hack_this.currentPosition % 2 == 1 ? 500 : 1500

      hack_this.nextSound = window.setTimeout(function(){
        hack_this.play();
      }, waitTime)
    });
  }

  pause(){
    var sound     = this.playlist[this.currentPosition]
    sound.stop() // stop current word
    sound.off('end') // unbind end event
    window.clearTimeout(this.nextSound) // Dont play next word
  }
}

export default Player;

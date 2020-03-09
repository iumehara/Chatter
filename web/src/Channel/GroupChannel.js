import {Socket} from 'phoenix'

class GroupChannel {
  constructor(id) {
    const socket = new Socket('ws://localhost:4000/socket', {})
    socket.connect()
    this.channel = socket.channel(`group:${id}`, {})
  }

  join() {
    this.channel.join()
      .receive('ok', () => {})
  }

  push(message) {
    this.channel.push('shout', {body: message})
  }

  on(callback) {
    this.channel.on('shout', callback)
  }
}

export default GroupChannel
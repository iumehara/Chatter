export default class Group {
  constructor(id, name) {
    this.id = id
    this.name = name
  }
}

export class GroupDetails {
  constructor(id, name, messages) {
    this.id = id
    this.name = name
    this.messages = messages
  }
}

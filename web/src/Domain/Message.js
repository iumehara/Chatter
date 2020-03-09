export default class Message {
  constructor(id, content, username, insertedAt) {
    this.id = id
    this.content = content
    this.username = username
    this.insertedAt = insertedAt
  }
}

export class NewMessage {
  constructor(content, username, groupId) {
    this.content = content
    this.username = username
    this.groupId = groupId
  }
}
export default class RedirectService {
  constructor(history) {
    this.history = history
  }

  getGroupDetailPage(groupId) {
    const route = `/groups/${groupId}`
    this.history.push(route)
  }
}

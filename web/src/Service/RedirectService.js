import {useParams} from 'react-router-dom'

export default class RedirectService {
  constructor(history) {
    this.history = history
  }

  getHomePage() {
    const route = '/groups'
    this.history.push(route)
  }

  getGroupDetailsPage(groupId) {
    const route = `/groups/${groupId}`
    this.history.push(route)
  }

  findUrlParams() {
    return useParams()
  }
}

import {fetchWrapper} from './browserWrapper'

export default class GroupRepo {
  baseUrl = 'http://localhost:4000/api'
  headers = {
    'Accept': 'application/json',
    'Origin': 'http://localhost:3000'
  }

  getList() {
    return fetchWrapper(`${this.baseUrl}/groups`, {headers: this.headers})
      .then(response => response.json())
      .then(json => json.data)
  }

  getDetails(groupId) {
    return fetchWrapper(`${this.baseUrl}/groups/${groupId}`, {headers: this.headers})
      .then(response => response.json())
      .then(json => json.data)
  }
}

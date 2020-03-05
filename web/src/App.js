import React from 'react'
import './App.scss'
import {Route, Router, Switch} from "react-router-dom"
import {createBrowserHistory} from 'history'
import HomePage from './Component/HomePage/HomePage'
import GroupDetailsPage from './Component/GroupDetailsPage/GroupDetailsPage'
import GroupRepo from './Repo/GroupRepo'
import RedirectService from './Service/RedirectService'

function App() {
  const browserHistory = createBrowserHistory()
  const redirectService = new RedirectService(browserHistory)
  const groupRepo = new GroupRepo()
  return (
    <Router history={browserHistory}>
      <div className='App'>
        <Header redirectService={redirectService}/>
        <Switch>
          <Route path='/groups/new'>
            <NewGroupPage/>
          </Route>
          <Route path='/groups/:groupId'>
            <GroupDetailsPage groupRepo={groupRepo} redirectService={redirectService}/>
          </Route>
          <Route path='/'>
            <HomePage groupRepo={groupRepo} redirectService={redirectService}/>
          </Route>
        </Switch>
      </div>
    </Router>
  )
}

export default App

function Header(props) {
  return (
    <div className='Header' onClick={() => props.redirectService.getHomePage()}>
      <div className='name'>Chatter</div>
    </div>
  )
}

function NewGroupPage() {
  return <h1>NEW GROUP</h1>
}

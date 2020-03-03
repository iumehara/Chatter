import React from 'react'
import './App.scss'
import {BrowserRouter, Route, Switch, useParams} from "react-router-dom"

function App() {
  return (
    <BrowserRouter>
      <div className='App'>
        <Header/>
        <Switch>
          <Route path='/groups/new'>
            <NewGroupPage/>
          </Route>
          <Route path='/groups/:groupId'>
            <GroupDetailPage/>
          </Route>
          <Route path='/'>
            <HomePage/>
          </Route>
        </Switch>
      </div>
    </BrowserRouter>
  )
}

export default App

function Header() {
  return (
    <div className='Header'>
      <div className='name'>Chatter</div>
    </div>
  )
}

function NewGroupPage() {
  return <h1>NEW GROUP</h1>
}

function GroupDetailPage() {
  const {groupId} = useParams()
  return <h1>{`GROUP DETAIL ${groupId}`}</h1>
}

function HomePage() {
  return <h1>My Chat Groups</h1>
}

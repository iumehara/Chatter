import React, {useState} from 'react'
import './NewGroupPage.scss'
import {NewGroup} from '../../Domain/Group'

function NewGroupPage(props) {
  const [name, setName] = useState()

  const nameChanged = e => {
    setName(e.target.value)
  }

  const createButtonClicked = () => {
    if (name === undefined) return
    const newGroup = new NewGroup(name)
    props.groupRepo.create(newGroup)
      .then(group => props.redirectService.getGroupDetailsPage(group.id))
  }

  return (
    <div className='NewGroupPage'>
      <h1>New Group</h1>
      <div className='form-element'>
        <label htmlFor='name-input'>Name</label>
        <input id='name-input' onChange={e => nameChanged(e)}/>
      </div>
      <button className='action' onClick={() => createButtonClicked()}>Create Group</button>
    </div>
  )
}

export default NewGroupPage
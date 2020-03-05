import React, {useEffect, useState} from 'react'
import './GroupDetailsPage.scss'

function GroupDetailsPage(props) {
  const {groupId} = props.redirectService.findUrlParams()
  const [group, setGroup] = useState({messages: []})

  useEffect(() => {
    props.groupRepo.getDetails(groupId)
      .then(group => setGroup(group))
  }, [props.groupRepo, groupId])

  const messageList = () => {
    return group.messages.map((message, i) => {
      return (
        <div key={i} className='message'>
          <div className='content'>
            {message.content}
          </div>
        </div>
      )
    })
  }

  return (
    <div className='GroupDetails'>
      <h1>{group.name}</h1>
      {messageList()}
    </div>
  )
}

export default GroupDetailsPage
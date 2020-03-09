import React, {useEffect, useState} from 'react'
import './GroupDetailsPage.scss'
import GroupChannel from '../../Channel/GroupChannel'
import {NewMessage} from '../../Domain/Message'

function GroupDetailsPage(props) {
  const {groupId} = props.redirectService.findUrlParams()
  const [groupName, setGroupName] = useState('')
  const [messages, setMessages] = useState([])
  const [messageContent, setMessageContent] = useState('')
  const [channel, setChannel] = useState({})
  const [username, setUsername] = useState('ANONYMOUS USER')

  useEffect(() => {
    const groupChannel = new GroupChannel(groupId)
    groupChannel.join()
    setChannel(groupChannel)

    props.groupRepo.getDetails(groupId)
      .then(group => {
        setGroupName(group.name)
        setMessages(group.messages)
      })

    groupChannel.on((payload) => {
      setMessages(messages => messages.concat(payload.body))
    })
  }, [props.groupRepo, groupId])

  const messageList = () => {
    return messages.map((message, i) => {
      const isSelf = message.username == username ? 'self' : ''

      return (
        <div key={i} className={`message-area ${isSelf}`}>
          <div className='username'>
            {message.username} said
          </div>
          <div className='message'>
            <div className='content'>
              {message.content}
            </div>
          </div>
        </div>
      )
    })
  }

  const contentInputChanged = e => {
    setMessageContent(e.target.value)
  }

  const usernameInputChanged = e => {
    setUsername(e.target.value)
  }

  const messageSendClicked = () => {
    const newMessage = new NewMessage(messageContent, username, groupId)
    setMessageContent('')
    channel.push(newMessage)
  }

  return (
    <div className='GroupDetails'>
      <h1>{groupName}</h1>
      <div className='message-list'>
        {messageList()}
      </div>
      <div className='form'>
        <div>
          <label htmlFor='username-input'>Username</label>
          <input id='username-input' onChange={e => usernameInputChanged(e)}/>
        </div>
        <div>
          <label htmlFor='content-input'>Message</label>
          <textarea id='content-input' value={messageContent} onChange={e => contentInputChanged(e)}/>
        </div>
        <button onClick={() => messageSendClicked()}>Send</button>
      </div>
    </div>
  )
}

export default GroupDetailsPage
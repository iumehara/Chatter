import React, {useEffect, useState} from 'react'
import './HomePage.scss'

function HomePage(props) {
  const [groups, setGroups] = useState([])

  useEffect(() => {
    props.groupRepo.getList()
      .then(groups => setGroups(groups))
  }, [props.groupRepo])

  const groupClicked = id => {
    props.redirectService.getGroupDetailsPage(id)
  }

  const groupList = () => {
    return groups.map((group, i) => {
      return (
        <div key={i} className='group' onClick={() => groupClicked(group.id)}>
          <div className='name'>
            {group.name}
          </div>
        </div>
      )
    })
  }

  return (
    <div className='HomePage'>
      <h1>My Chat Groups</h1>
      {groupList()}
    </div>
  )
}

export default HomePage

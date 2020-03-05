import React from 'react'
import {render, screen} from '@testing-library/react'
import GroupDetailsPage from './GroupDetailsPage'
import {waitForElement} from '@testing-library/dom'
import {GroupDetails} from '../../Domain/Group'
import Message from '../../Domain/Message'

describe('GroupDetailsPage', () => {
  it('renders title', async () => {
    const repo = new StubGroupRepo()
    const redirectService = new StubRedirectService()
    render(<GroupDetailsPage groupRepo={repo} redirectService={redirectService}/>)

    await waitForElement(() => screen.getByText(/Group 1/i))

    expect(screen.getByText(/Group 1/i)).toBeInTheDocument()
  })

  it('renders Messages', async () => {
    const repo = new StubGroupRepo()
    const redirectService = new StubRedirectService()
    render(<GroupDetailsPage groupRepo={repo} redirectService={redirectService}/>)

    await waitForElement(() => screen.getByText(/Group 1/i))

    expect(screen.getByText(/Hi there/i)).toBeInTheDocument()
    expect(screen.getByText(/hey, how's it going?/i)).toBeInTheDocument()
  })
})

class StubGroupRepo {
  getDetails(id) {
    const groupDetails = new GroupDetails(
      'asdfghjkl',
      'Group 1',
      [
        new Message("message-id-1", "Hi there"),
        new Message("message-id-2", "hey, how's it going?")
      ]
    )
    return Promise.resolve(groupDetails)
  }
}

class StubRedirectService {
  findUrlParams() {
    return {groupId: "1"}
  }
}


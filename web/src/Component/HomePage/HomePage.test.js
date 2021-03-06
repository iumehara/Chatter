import React from 'react'
import {render, screen, fireEvent} from '@testing-library/react'
import HomePage from './HomePage'
import Group from '../../Domain/Group'
import {waitForElement} from '@testing-library/dom'

describe('HomePage', () => {
  it('renders title', async () => {
    const repo = new StubGroupRepo()
    const {getByText} = render(<HomePage groupRepo={repo} />)

    await waitForElement(() => screen.getByText(/My Chat Groups/i))

    const homePageText = getByText(/My Chat Groups/i)
    expect(homePageText).toBeInTheDocument()
  })

  it('renders Group', async () => {
    const repo = new StubGroupRepo()
    render(<HomePage groupRepo={repo} />)

    await waitForElement(() => screen.getByText(/Group 1/i))

    expect(screen.getByText(/Group 1/i)).toBeInTheDocument()
    expect(screen.getByText(/Group 2/i)).toBeInTheDocument()
    expect(screen.getByText(/Group 3/i)).toBeInTheDocument()
  })

  it('redirects to group detail page', async () => {
    const repo = new StubGroupRepo()
    const redirectService = new SpyRedirectService()
    render(<HomePage groupRepo={repo} redirectService={redirectService}/>)

    await waitForElement(() => screen.getByText(/Group 1/i))
    fireEvent.click(screen.getByText(/Group 1/i))

    expect(redirectService.getGroupDetailsPageCalledWith).toEqual('1234567890')
  })

  it('redirects to the New Group Page', async () => {
    const repo = new StubGroupRepo()
    const redirectService = new SpyRedirectService()
    render(<HomePage groupRepo={repo} redirectService={redirectService}/>)

    await waitForElement(() => screen.getByText(/Add New Group/i))
    fireEvent.click(screen.getByText(/Add New Group/i))

    expect(redirectService.getNewGroupPageCalled).toEqual(true)
  })
})

class StubGroupRepo {
  getList() {
    const groups = [
      new Group('1234567890', 'Group 1'),
      new Group('2234567890', 'Group 2'),
      new Group('3234567890', 'Group 3')
    ]

    return Promise.resolve(groups)
  }
}

class SpyRedirectService {
  getNewGroupPageCalled = false
  getGroupDetailsPageCalledWith = null

  getGroupDetailsPage(groupId) {
    this.getGroupDetailsPageCalledWith = groupId
  }

  getNewGroupPage() {
    this.getNewGroupPageCalled = true
  }
}

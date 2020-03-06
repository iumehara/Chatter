import React from 'react'
import {render, screen, fireEvent} from '@testing-library/react'
import Group, {NewGroup} from '../../Domain/Group'
import {waitForElement} from '@testing-library/dom'
import NewGroupPage from './NewGroupPage'

describe('NewGroupPage', () => {
  it('renders title', async () => {
    const repo = new StubGroupRepo()
    render(<NewGroupPage groupRepo={repo} />)

    await waitForElement(() => screen.getByText(/New Group/i))

    const pageTitle = screen.getByText(/New Group/i)
    expect(pageTitle).toBeInTheDocument()
  })

  it('renders form', async () => {
    const repo = new StubGroupRepo()
    render(<NewGroupPage groupRepo={repo} />)

    await waitForElement(() => screen.getByText(/Name/i))

    expect(screen.getByText(/Name/i)).toBeInTheDocument()
    expect(screen.getByText(/Create Group/i)).toBeInTheDocument()
  })

  describe('form submission', () => {
    it('submits form content', async () => {
      const repo = new SpyGroupRepo()
      const redirectService = new SpyRedirectService()
      render(<NewGroupPage groupRepo={repo} redirectService={redirectService}/>)

      await waitForElement(() => screen.getByLabelText(/Name/i))
      let input = screen.getByLabelText(/Name/i)
      fireEvent.change(input, { target: { value: 'Birthday Party Planning' } })
      fireEvent.click(screen.getByText(/Create Group/i))

      expect(repo.createCalledWith).toEqual(new NewGroup("Birthday Party Planning"))
    })

    it('does not submit form if name is empty', async () => {
      const repo = new SpyGroupRepo()
      const redirectService = new SpyRedirectService()
      render(<NewGroupPage groupRepo={repo} redirectService={redirectService}/>)

      await waitForElement(() => screen.getByLabelText(/Name/i))
      fireEvent.click(screen.getByText(/Create Group/i))

      expect(repo.createCalledWith).toEqual(null)
    })

    it('redirects to the GroupDetails page', async () => {
      const repo = new StubGroupRepo()
      const redirectService = new SpyRedirectService()
      render(<NewGroupPage groupRepo={repo} redirectService={redirectService}/>)

      await waitForElement(() => screen.getByLabelText(/Name/i))
      let input = screen.getByLabelText(/Name/i)
      fireEvent.change(input, { target: { value: 'Birthday Party Planning' } })
      fireEvent.click(screen.getByText(/Create Group/i))

      await redirectService.getGroupDetailsPageCalledWith
      expect(redirectService.getGroupDetailsPageCalledWith).toEqual('1234567890')
    })
  })
})

class SpyGroupRepo {
  createCalledWith = null

  create(newGroup) {
    this.createCalledWith = newGroup
    return Promise.resolve({})
  }
}

class StubGroupRepo {
  create(newGroup) {
    return Promise.resolve(new Group('1234567890', 'Birthday Party Planning'))
  }
}

class SpyRedirectService {
  getGroupDetailsPageCalledWith = null

  getGroupDetailsPage(groupId) {
    this.getGroupDetailsPageCalledWith = groupId
  }
}

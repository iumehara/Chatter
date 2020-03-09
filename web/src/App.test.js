import React from 'react'
import {render, screen} from '@testing-library/react'
import App from './App'
import {waitForElement} from '@testing-library/dom'

describe('App', () => {
  it('renders Header', async () => {
    const {getByText} = render(<App/>)
    await waitForElement(() => screen.getByText(/Chatter/i))
    const headerText = getByText(/Chatter/i)
    expect(headerText).toBeInTheDocument()
  })
})

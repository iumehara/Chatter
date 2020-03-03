import React from 'react'
import {render} from '@testing-library/react'
import App from './App'

describe('App', () => {
  it('renders Header', () => {
    const {getByText} = render(<App/>)
    const headerText = getByText(/Chatter/i)
    expect(headerText).toBeInTheDocument()
  })

  it('renders Home page by default', () => {
    const {getByText} = render(<App/>)
    const homePageText = getByText(/My Chat Groups/i)
    expect(homePageText).toBeInTheDocument()
  })
})

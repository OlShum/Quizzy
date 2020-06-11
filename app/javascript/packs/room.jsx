import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { ActionCableProvider } from 'react-actioncable-provider'

import Lap from '../components/Lap'

const App = props => {
  // let questionElements = props.questions.map(function(question, i) {
  //   return <Question {...question} key={i} />
  // })

  return (
    <div className="App">
      <Lap />
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  let props = document.getElementsByTagName('div')[0].dataset.props
  let testContent = JSON.parse(props)

  ReactDOM.render(
    <ActionCableProvider url="ws://localhost:3000/cable">
      <App questions={testContent} />
    </ActionCableProvider>,
    document.body.appendChild(document.createElement('div'))
  )
})

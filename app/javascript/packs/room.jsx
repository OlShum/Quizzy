import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Lap from '../components/Lap'
import Loading from '../components/Loading'

const App = props => {
  // let questionElements = props.questions.map(function(question, i) {
  //   return <Question {...question} key={i} />
  // })

  return (
    <div className="App">
      <Loading />
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  let props = document.getElementsByTagName('div')[0].dataset.props
  let testContent = JSON.parse(props)

  ReactDOM.render(
    <App questions={testContent} />,
    document.body.appendChild(document.createElement('div'))
  )
})

import React from 'react'
import Lottie from 'react-lottie'
import ReactLoading from 'react-loading'
import 'bootstrap/dist/css/bootstrap.css'

import Lap from '../components/Lap'

export default class Loading extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      done: undefined
    }
  }

  componentDidMount() {
    setTimeout(() => {
      fetch('https://jsonplaceholder.typicode.com/posts')
        .then(response => response.json())
        .then(json => this.setState({ done: true }))
    }, 1200)
  }

  render() {
    return (
      <div className="AppContainer">
        {!this.state.done ? (
          <ReactLoading
            type={'bars'}
            color={'#ff499e'}
            className="LoadingStyle"
          />
        ) : (
          <Lap />
        )}
      </div>
    )
  }
}

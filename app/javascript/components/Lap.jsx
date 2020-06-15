import React from 'react'
import { ActionCable } from 'react-actioncable-provider'

export default class Lap extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentQuestion: 0,
      options: [],
      score: 0,
      disabled: true,
      isEnd: false
    }

    this.loadQuestion = this.loadQuestion.bind(this)
  }

  // componentDidUpdate(prevState) {
  //   console.log('HHHHHHEEEEEEEEEEEEYYYYYYYYYY')
  //   if (this.state.question_text !== prevState.question_text) {
  //     this.loadQuestion()
  //     // fetch(`http://localhost:3000/api/questions/random.json`)
  //     //   .then(response => {
  //     //     return response.json()
  //     //   })
  //     //   .then(data => {
  //     //     console.log(data)
  //     //     let { question_text, answer, option } = data
  //     //     this.setState({
  //     //       disabled: true,
  //     //       questions: question_text,
  //     //       answer,
  //     //       options: JSON.parse(option)
  //     //     })
  //     //   })
  //   }
  // }

  loadQuestion() {
    fetch(`http://localhost:3000/api/questions/random.json`)
      .then(response => {
        return response.json()
      })
      .then(data => {
        console.log(data)
        let { question_text, answer, option, theme_name } = data
        this.setState({
          question_text,
          answer,
          options: JSON.parse(option),
          theme_name
        })
      })
  }

  checkAnswer(answer) {
    fetch(`http://localhost:3000/api/questions/check_answer.json`)
      .then(response => {
        return response.json()
      })
      .then(data => {
        console.log(data)
        this.setState({ myAnswer: answer, disabled: false })
      })
  }

  renderOptions() {
    const { options, myAnswer } = this.state
    let elements = []
    options.forEach(option => {
      elements.push(
        <p
          key={option.id}
          className={`
     ${myAnswer === option ? 'selected' : null}
     `}
          onClick={() => this.checkAnswer(option)}
        >
          {option}
        </p>
      )
    })

    return elements
  }

  nextQuestionHandler() {
    fetch(`http://localhost:3000/api/questions/check_answer.json`)
      .then(response => {
        return response.json()
      })
      .then(data => {
        console.log('Next Question Button')
        const { myAnswer, answer, score } = this.state

        // if (myAnswer === answer) {
        //   this.setState({
        //     score: score + 100
        //   })
        // }

        this.setState({
          currentQuestion: this.state.currentQuestion + 1
        })
        console.log(this.state.currentQuestion)
      })
  }

  handleReceivedQuestions() {
    console.log('hehe')
  }

  render() {
    const { option } = this.state
    return (
      <div className="QuestionBlock">
        <h2 className="ThemeName">Тема: {this.state.theme_name}</h2>
        <h1>{this.state.question_text}</h1>
        <span className="Counter">Пройдено 0 из 5 вопросов</span>
        {this.loadQuestion()}
        {this.renderOptions()}
        <button
          className="NextQuestionButton"
          disabled={this.state.disabled}
          onClick={this.nextQuestionHandler}
        >
          Следующий вопрос
        </button>
      </div>
    )
  }
}

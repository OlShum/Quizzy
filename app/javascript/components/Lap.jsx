import React from 'react'
import { ActionCable } from 'react-actioncable-provider'

import Me from '../../assets/images/Me.png'
import You from '../../assets/images/You.png'
import Draw from '../../assets/images/Draw.png'
import Stars from '../../assets/images/Stars.png'
import Lose from '../../assets/images/Lose.png'

export default class Lap extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentQuestion: 0,
      myAnswer: null,
      options: [],
      score: 0,
      disabled: true,
      isEnd: false
    }

    this.loadQuestion = this.loadQuestion.bind(this)
    this.nextQuestionHandler = this.nextQuestionHandler.bind(this)
    this.checkAnswer = this.checkAnswer.bind(this)
    this.finishHandler = this.finishHandler.bind(this)
  }

  componentDidMount() {
    this.loadQuestion()
  }

  componentDidUpdate(prevProps, prevState) {
    console.log('HHHHHHEEEEEEEEEEEEYYYYYYYYYY')
    if (this.state.currentQuestion !== prevState.currentQuestion) {
      this.loadQuestion()
      // fetch(`http://localhost:3000/api/questions/random.json`)
      //   .then(response => {
      //     return response.json()
      //   })
      //   .then(data => {
      //     console.log(data)
      //     let { question_text, answer, option } = data
      //     this.setState({
      //       disabled: true,
      //       questions: question_text,
      //       answer,
      //       options: JSON.parse(option)
      //     })
      //   })
    }
  }

  // generateId() {
  //   let array = new Uint32Array(8)
  //   window.crypto.getRandomValues(array)
  //   let str = ''
  //   for (let i = 0; i < array.length; i++) {
  //     str += (i < 2 || i > 5 ? '' : '-') + array[i].toString(16).slice(-4)
  //   }
  //   return str
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
          questions: question_text,
          answer,
          options: JSON.parse(option),
          theme: theme_name
        })
      })

    // console.log(questions[0].question)
  }

  nextQuestionHandler() {
    console.log('Next Question Button')
    const { myAnswer, answer, score } = this.state

    if (myAnswer === answer) {
      this.setState({
        score: score + 100
      })
    }

    this.setState({
      currentQuestion: this.state.currentQuestion + 1
    })
    console.log(this.state.currentQuestion)
  }

  //check answer
  checkAnswer(answer) {
    this.setState({ myAnswer: answer, disabled: false })
  }

  finishHandler() {
    if (this.state.currentQuestion === 4) {
      this.setState({
        isEnd: true
      })
    }
    // console.log(this.state.questions.length)
  }

  renderOptions() {
    const { options, myAnswer } = this.state
    let elements = []

    if (Array.isArray(options)) {
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
    } else {
      elements.push(
        <p
          /* key={options.id} */
          className={`
   ${myAnswer === options ? 'selected' : null}
   `}
          onClick={() => this.checkAnswer(options)}
        >
          {options}
        </p>
      )
    }

    return elements
  }

  handleReceivedQuestions() {
    console.log('hehe')
  }

  render() {
    const { option, myAnswer, currentQuestion, isEnd } = this.state

    if (isEnd) {
      return (
        <div className="resultContainer">
          <div className="MeBlock">
            <img src={Me} />
            <div className="MeText">
              <p className="MeMe">Я</p>
              <p className="MeMeScore">{this.state.score}</p>
            </div>
          </div>
          <div className="YouBlock">
            <div className="YouText">
              <p className="YouYou">Соперник</p>
              <p className="YouYouScore">{this.state.score}</p>
            </div>
            <img src={You} />
          </div>
          <div className="result">
            <img src={Draw} />
            <h3 className="GameOverCounter">Ничья</h3>
          </div>
        </div>
      )
    } else {
      return (
        <div className="QuestionBlockContainer">
          <div className="MeBlock">
            <img src={Me} />
            <div className="MeText">
              <p className="MeMe">Я</p>
              <p className="MeMeScore">{this.state.score} </p>
            </div>
          </div>
          <div className="YouBlock">
            <div className="YouText">
              <p className="YouYou">Соперник</p>
              <p className="YouYouScore">{this.state.score} </p>
            </div>
            <img src={You} />
          </div>
          <div className="QuestionBlock">
            <h2 className="ThemeName">Тема: {this.state.theme}</h2>
            <h1>{this.state.questions}</h1>
            <span className="Counter">{`Пройдено ${currentQuestion}  из ${5} вопросов `}</span>
            {this.renderOptions()}
            {currentQuestion < 4 && (
              <button
                className="NextQuestionButton"
                disabled={this.state.disabled}
                onClick={this.nextQuestionHandler}
              >
                Следующий вопрос
              </button>
            )}
            {/* //добавить кнопку финиша */}
            {currentQuestion === 4 && (
              <button
                className="EndButton"
                disabled={this.state.disabled}
                onClick={this.finishHandler}
              >
                Завершить
              </button>
            )}
          </div>
        </div>
      )
    }
  }
}

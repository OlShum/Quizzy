@questions = [
  {
    theme_name: 'Кино',
    question_text: 'Режиссёр фильма Таксист',
    option: ['Кристофер Нолан', 'Мартин Скорсезе', 'Вуди Аллен'],
    answer: 'Мартин Скорсезе'
  },
  {
    theme_name: 'Кино',
    question_text: 'Какая актриса снялась в главной роли фильма «Мама!»?',
    option: ['Кристен Стюарт', 'Эмма Уотсон', 'Дженнифер Лоуренс'],
    answer: 'Дженнифер Лоуренс'
  },
  {
    theme_name: 'Кино',
    question_text: 'Какой фильм из перечисленных не является фильмом Marvel?',
    option: ['Чёрная молния', 'Человек-паук', 'Железный человек'],
    answer: 'Чёрная молния'
  },
  {
    theme_name: 'Кино',
    question_text: 'Главный герой фильма «7 психопатов»',
    option: ['Алекс', 'Марти', 'Пауло'],
    answer: 'Марти'
  },
  {
    theme_name: 'Кино',
    question_text: 'Первый научно-фантастический фильм, номинировавшийся на «Оскар» в категории «Лучший фильм»',
    option: ['Аватар', 'Интерстеллар', 'Заводной апельсин'],
    answer: 'Заводной апельсин'
  }
]

def seed_data
  drop_db
  create_question
end

def drop_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def create_question
  @questions.each do |question|
    Question.create!(question)
    puts "#{question}"
  end
end


seed_data

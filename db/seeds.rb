@questions = [
  {
    theme_name: 'Кино',
    question_text: 'Режиссёр фильма Таксист',
    option: ['Кристофер Нолан', 'Мартин Скорсезе', 'Вуди Аллен'],
    answer: 'Мартин Скорсезе',
    score: 100
  },
  {
    theme_name: 'Кино',
    question_text: 'Какая актриса снялась в главной роли фильма «Мама!»?',
    option: ['Кристен Стюарт', 'Эмма Уотсон', 'Дженнифер Лоуренс'],
    answer: 'Дженнифер Лоуренс',
    score: 150
  },
  {
    theme_name: 'Кино',
    question_text: 'Какой фильм из перечисленных не является фильмом Marvel?',
    option: ['Чёрная молния', 'Человек-паук', 'Железный человек'],
    answer: 'Чёрная молния',
    score: 100
  },
  {
    theme_name: 'Кино',
    question_text: 'Главный герой фильма «7 психопатов»',
    option: ['Алекс', 'Марти', 'Пауло'],
    answer: 'Марти',
    score: 100
  },
  {
    theme_name: 'Кино',
    question_text: 'Первый научно-фантастический фильм, номинировавшийся на «Оскар» в категории «Лучший фильм»',
    option: ['Аватар', 'Интерстеллар', 'Заводной апельсин'],
    answer: 'Заводной апельсин',
    score: 150
  },
  {
    theme_name: 'Биология',
    question_text: 'Наука цитология изучает живые обьекты на уровне',
    option: ['Клеточном', 'Молекулярном', 'Организменном'],
    answer: 'Клеточном',
    score: 100
  },
  {
    theme_name: 'Биология',
    question_text: 'Что является органом голосообразования',
    option: ['Ротовая полость', 'Гортань', 'Трахея'],
    answer: 'Гортань',
    score: 100
  },
  {
    theme_name: 'Биология',
    question_text: 'Позвоночник человека способен пружинить благодаря тому, что:',
    option: ['Имеет изгибы', 'Состоит из позвонков', 'Защищает спинной мозг'],
    answer: 'Имеет изгибы',
    score: 100
  },
  {
    theme_name: 'Биология',
    question_text: 'Что изучает ботаника?',
    option: ['Грибы', 'Растения', 'Вирусы'],
    answer: 'Растения',
    score: 100
  },
  {
    theme_name: 'Биология',
    question_text: 'Могут ли лягушки жить в солёной воде?',
    option: ['Да', 'Нет'],
    answer: 'Да',
    score: 150
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

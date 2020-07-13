class UsersController < ApplicationController
  def index
  	    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://i.pinimg.com/originals/ee/17/c2/ee17c26990cae591937bb679a170820b.png'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show	
  	@user = User.new(
  		name: 'Vadim',
  		username: 'Effect@mail.ru',
		avatar_url: 'https://i.pinimg.com/originals/ee/17/c2/ee17c26990cae591937bb679a170820b.png'
		)

  	@questions = [
  		Question.new(text: 'Кто тут', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'Привет мир!!!', created_at: Date.parse('27.03.2016')) 
  	]

  	@new_question = Question.new
  end
end

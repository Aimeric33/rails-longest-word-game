require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    if include_word?(params['letters'], params[:word].upcase)
      if word['found']
        @score = "Congrats! Your score is #{params[:word].length * 2.25} points"
      else
        @score = 'Sorry, this word is not valid! Your score is 0'
      end
    else
      @score = 'Sorry, this word is not in the grid! Your score is 0'
    end
  end

  def include_word?(grid, word)
    word.chars.all? do |char|
      grid.include?(char)
    end
  end
end

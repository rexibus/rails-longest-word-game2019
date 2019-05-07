class GamesController < ApplicationController
  def new
    @letters = []
    10.times{ @letters << ("a".."z").to_a.sample }
    @letters
  end

  def score

  end
end

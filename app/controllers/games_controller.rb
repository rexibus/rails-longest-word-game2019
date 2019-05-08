require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (("A".."Z").to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score

    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)

    # if params[:word].length >10
    #   @message = "Sorry but #{params[:word]} is not in the grid"
    # elsif english_word?
    #   @message = "Cool #{params[:word]} is an english word"
    # else
    #   @message = "Sorry #{params[:word]} is not english word"
    # end

  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

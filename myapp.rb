require 'sinatra'
require 'byebug'
require "sinatra/reloader"
require 'pry'
require 'active_record'
require 'rack/csrf'

use Rack::Session::Cookie, secret: SecureRandom.urlsafe_base64
use Rack::Csrf, raise: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './bbs.db'
)

class Comment < ActiveRecord::Base
  validates :body, presence: true
end

helpers do
  def hoge
    "hello"
  end

  def escape_html(target)
    Rack::Utils.escape_html(target)
  end

  def csrf_token
    Rack::Csrf.csrf_token(env)
  end

  def csrf_tag
    Rack::Csrf.csrf_tag(env)
  end
end

get '/' do
  erb :index
end

get '/hello/:name' do
  byebug
  "Hello #{params[:name]}"
  # puts params
  # puts params[:name]
end

get '/ora/:name' do |n|
  "hello #{n}"
end

=begin 
get '/picture' do
  "hello post"
end
=end

post '/picture' do
  # binding.pry
  "hello #{params[:text]}"
end

get %r{/number/([0-9]*)} do
  "hello #{params[:captures][0]}"
  # binding.pry
end

get '/main' do
  @title = "main"
  erb :main
end

get '/bbs' do
  @title = "BBS"
  @comments = Comment.all
  erb :bbs
end

post '/create' do
  Comment.create(body: params[:body])
  # binding.pry
  redirect to('/bbs')
end

post '/destroy' do
  # binding.pry
  Comment.find(params[:id]).destroy
  redirect to('/bbs')
  # puts "hello destroy"
end
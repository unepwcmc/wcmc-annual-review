class HomeController < ApplicationController
  require 'json'

  def index
    @nav = [
      {
        id: 'foreword',
        label: 'Foreword'
      },
      {
        id: 'anniversary',
        label: '40th Anniversary'
      },
      {
        id: 'highlights',
        label: '2018 Highlights'
      },
      {
        id: 'projects',
        label: 'Operations and Projects'
      },
      {
        id: 'stats-people',
        label: 'People team stats'
      },
      {
        id: 'stats-finance',
        label: 'Finance stats'
      },
      {
        id: 'future',
        label: 'Looking forward...'
      }
    ].to_json

    @hero = YAML.load(File.open("#{Rails.root}/lib/data/content/home/hero.yml", 'r'))
    @foreword = YAML.load(File.open("#{Rails.root}/lib/data/content/home/foreword.yml", 'r'))
    @anniversary = YAML.load(File.open("#{Rails.root}/lib/data/content/home/anniversary.yml", 'r'))
    @highlights = YAML.load(File.open("#{Rails.root}/lib/data/content/home/highlights.yml", 'r'))
    @projects = YAML.load(File.open("#{Rails.root}/lib/data/content/home/projects.yml", 'r'))
    @stats_people = YAML.load(File.open("#{Rails.root}/lib/data/content/home/stats-people.yml", 'r'))
    @stats_finance = YAML.load(File.open("#{Rails.root}/lib/data/content/home/stats-finance.yml", 'r'))
    @future = YAML.load(File.open("#{Rails.root}/lib/data/content/home/future.yml", 'r'))
  end
end

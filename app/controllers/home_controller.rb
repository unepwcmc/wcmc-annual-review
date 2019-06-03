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

    @published_papers = [
      {
        datapoints: [
          { x: 2007, y: 10 },
          { x: 2008, y: 5 },
          { x: 2009, y: 10 },
          { x: 2010, y: 5 },
          { x: 2011, y: 10 },
          { x: 2012, y: 5 },
          { x: 2013, y: 10 },
          { x: 2014, y: 5 },
          { x: 2015, y: 10 }
        ]
      }
    ]
  end
end

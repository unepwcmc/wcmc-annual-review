class HomeController < ApplicationController

  def index
    @nav = [
      {
        id: 1,
        label: 'Foreword',
        url: '#foreword'
      },
      {
        id: 2,
        label: '40th Anniversary',
        url: '#anniversary'
      },
      {
        id: 3,
        label: '2018 Highlights',
        url: '#highlights'
      },
      {
        id: 4,
        label: 'Operations and Projects',
        url: '#projects'
      },
      {
        id: 5,
        label: 'People team stats',
        url: '#people-stats'
      },
      {
        id: 6,
        label: 'Finance stats',
        url: '#finance-stats'
      },
      {
        id: 7,
        label: 'Looking forward...',
        url: '#future'
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

class HomeController < ApplicationController

  def index
    @nav = [
      {
        id: 'foreword',
        label: 'Foreword',
        url: '#foreword'
      },
      {
        id: 'anniversary',
        label: '40th Anniversary',
        url: '#anniversary'
      },
      {
        id: 'highlights',
        label: '2018 Highlights',
        url: '#highlights'
      },
      {
        id: 'projects',
        label: 'Operations and Projects',
        url: '#projects'
      },
      {
        id: 'people-stats',
        label: 'People team stats',
        url: '#people-stats'
      },
      {
        id: 'finance-stats',
        label: 'Finance stats',
        url: '#finance-stats'
      },
      {
        id: 'future',
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

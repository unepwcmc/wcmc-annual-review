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
        colour: { line: '#64C0D5' },
        datapoints: [
          { x: 2007, y: 12 },
          { x: 2008, y: 6 },
          { x: 2009, y: 12 },
          { x: 2010, y: 6 },
          { x: 2011, y: 12 },
          { x: 2012, y: 6 },
          { x: 2013, y: 12 },
          { x: 2014, y: 6 },
          { x: 2015, y: 12 }
        ]
      },
      {
        colour: { line: '#BFF5FF'},
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

    @references = {
      config: {
        svgPaddingTop: 70,
        chartPaddingTop: 70,
        chartPaddingBottom: 50,
        chartBackgroundColour: '#31A0C9',
        x: {
          totalTicks: 9 #NOTE! This would be the total number of datapoints
        },
        y: {
          showAxis: false
        }
      },
      data: [
        {
          colour: { line: '#000', fill: '#31A0C9', text: '#000' },
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
        },
        {
          colour: { line: '#000' },
          datapoints: [
            { x: 2007, y: 7 },
            { x: 2008, y: 3 },
            { x: 2009, y: 7 },
            { x: 2010, y: 3 },
            { x: 2011, y: 7 },
            { x: 2012, y: 3 },
            { x: 2013, y: 7 },
            { x: 2014, y: 3 },
            { x: 2015, y: 7 }
          ]
        }
      ]
    }
  end
end

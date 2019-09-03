class HomeController < ApplicationController
  include YamlHelper
  require 'json'

  def index
    @nav = [
      {
        id: 'foreword',
        label: 'Foreword'
      },
      {
        id: 'anniversary',
        label: '40th anniversary'
      },
      {
        id: 'projects',
        label: 'Our work'
      },
      {
        id: 'highlights',
        label: 'Highlights'
      },
      {
        id: 'stats-people',
        label: 'Our team'
      },
      {
        id: 'stats-finance',
        label: 'Financial overview'
      },
      {
        id: 'future',
        label: 'Moving forward...'
      }
    ].to_json

    @hero = YAML.load(File.open("#{Rails.root}/lib/data/content/home/hero.yml", 'r'))
    @foreword = YAML.load(File.open("#{Rails.root}/lib/data/content/home/foreword.yml", 'r'))
    @anniversary = YAML.load(File.open("#{Rails.root}/lib/data/content/home/anniversary.yml", 'r'))
    @highlights = load_yaml("lib/data/content/home/highlights.yml", highlight_links)
    @projects = load_yaml("lib/data/content/home/projects.yml", project_links)
    @stats_people = YAML.load(File.open("#{Rails.root}/lib/data/content/home/stats-people.yml", 'r'))
    @stats_finance = YAML.load(File.open("#{Rails.root}/lib/data/content/home/stats-finance.yml", 'r'))
    @future = YAML.load(File.open("#{Rails.root}/lib/data/content/home/future.yml", 'r'))

    @references = {
      config: {
        svgPaddingTop: 70,
        chartPaddingTop: 70,
        chartPaddingBottom: 50,
        chartBackgroundColour: '#31A0C9',
        x: {
          offset: 60,
          totalTicks: 13
        },
        y: {
          showAxis: false
        }
      },
      data: [
        {
          colour: { line: '#000', fill: '#31A0C9', text: '#000' },
          datapoints: [
            { x: 1994, y: 0 },
            { x: 1995, y: 0 },
            { x: 1996, y: 0 },
            { x: 1998, y: 0 },
            { x: 2000, y: 0 },
            { x: 2002, y: 4 },
            { x: 2004, y: 20 },
            { x: 2006, y: 32 },
            { x: 2008, y: 51 },
            { x: 2010, y: 75 },
            { x: 2012, y: 90 },
            { x: 2014, y: 95 },
            { x: 2016, y: 119 },
            { x: 2018, y: 138 }
          ]
        },
        {
          colour: { line: '#000' },
          datapoints: [
            { x: 1994, y: 0 },
            { x: 1995, y: 0 },
            { x: 1996, y: 0 },
            { x: 1998, y: 0 },
            { x: 2000, y: 0 },
            { x: 2002, y: 3 },
            { x: 2004, y: 11 },
            { x: 2006, y: 16 },
            { x: 2008, y: 24 },
            { x: 2010, y: 34 },
            { x: 2012, y: 42 },
            { x: 2014, y: 46 },
            { x: 2016, y: 54 },
            { x: 2018, y: 62 }
          ]
        }
      ]
    }
  end

  def highlight_links
    yaml_create_links("#{Rails.root}/lib/data/content/home/highlights-links.yml")
  end

  def project_links
    yaml_create_links("#{Rails.root}/lib/data/content/home/projects-links.yml")
  end
end
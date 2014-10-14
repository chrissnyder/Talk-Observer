# @cjsx React.DOM

React = require 'react'
{ Router, Routes, Route, Link } = require 'react-router'

Api = require 'zooniverse/lib/api'
new Api

User = require 'zooniverse/models/user'

talkProjects = require './lib/talk-projects'
ProjectsList = require './components/projects-list'

App = React.createClass
  displayName: 'App'

  getInitialState: ->
    user: User.current
    projects: []

  componentDidMount: ->
    User.on 'change', (e, user) =>
      @setState user: user
      @_refreshProjects()

    User.fetch()

  _refreshProjects: ->
    Api.current.get @_projectsListUrl(), (projects) =>
      projects = projects.filter (project) ->
        exists = false
        for talkProject in talkProjects
          exists = true if talkProject.name is project.name

        exists

      projects = projects.map (project) ->
        for talkProject in talkProjects
          if talkProject.name is project.name
            project[key] = value for key, value of talkProject unless key of talkProject
        project

      @setState projects: projects

  _projectsListUrl: ->
    "#{ Api.current.proxyFrame.host }/projects/list"

  render: ->
    <div className="app">
      <h1>Observer</h1>
      <p>Random extras to manage Talk.</p>

      { if @state.user then <ProjectsList projects={ @state.projects } /> else null }
    </div>

Main = React.createClass
  render: ->
    <Routes>
      <Route path="/" name="root" handler={ App } />
    </Routes>

React.renderComponent Main(null), document.querySelector('#app')
window.React = React

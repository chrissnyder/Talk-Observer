# @cjsx React.DOM

React = require 'react'
{ Routes, Route } = require 'react-router'
_ = require 'underscore'

Api = require 'zooniverse/lib/api'
new Api

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.prependTo document.body

User = require 'zooniverse/models/user'

talkProjects = require './lib/talk-projects'
talkProjectNames = _.pluck talkProjects, 'name'
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
    Api.current.get @_projectsListUrl(), (rawProjects) =>
      projects = _.chain rawProjects
        .filter (rawProject) -> rawProject.name in talkProjectNames
        .map (rawProject) ->
          talkProject = _.find talkProjects, (talkProject) -> talkProject.name is rawProject.name
          _.extend rawProject, talkProject
        .value()

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

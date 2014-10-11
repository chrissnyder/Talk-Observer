# @cjsx React.DOM

React = require 'react'
{ Router, Routes, Route, Link } = require 'react-router'

Api = require 'zooniverse/lib/api'
api = new Api

User = require 'zooniverse/models/user'
User.fetch()

TalkProjects = require './lib/talk-projects'
ProjectsList = require './components/projects-list'

App = React.createClass
  displayName: 'App'

  getInitialState: ->
    user: User.current

  componentDidMount: ->
    User.on 'change', (e, user) =>
      @setState user: user

  render: ->
    <div className="app">
      <h1>Talk Extras</h1>
      <p>View all followed discussions on Talk</p>

      { if @state.user then <ProjectsList projects={ TalkProjects } /> else null }
    </div>

Main = React.createClass
  render: ->
    <Routes>
      <Route path="/" name="root" handler={ App } />
    </Routes>

React.renderComponent Main(null), document.querySelector('#app')
window.React = React

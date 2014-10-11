# @cjsx React.DOM
React = require 'react'
Project = require './project'

ProjectsList = React.createClass
  displayName: 'ProjectsList'

  render: ->
    projectNodes = @props.projects.map (project) ->
      <Project key={ project.id }, project={ project } />

    <div className="projects-list">
      { projectNodes }
    </div>

module.exports = ProjectsList

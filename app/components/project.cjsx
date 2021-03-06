# @cjsx React.DOM
React = require 'react'

Api = require 'zooniverse/lib/api'
DiscussionsList = require './discussions-list'

Project = React.createClass
  displayName: 'Project'

  render: ->
    <div className="project">
      <div className="project-name">{ @props.project.display_name }</div>
      <DiscussionsList project={ @props.project } />
    </div>

module.exports = Project

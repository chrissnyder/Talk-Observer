# @cjsx React.DOM
React = require 'react'
Api = require 'zooniverse/lib/api'

Project = React.createClass
  displayName: 'Project'

  getInitialState: ->
    discussions: []

  componentDidMount: ->
    Api.current.get(@_url()).then (results) =>
      @setState discussions: results

  _url: ->
    "https://dev.zooniverse.org/projects/#{ @props.project.name }/talk/following/discussions"

  render: ->
    discussionNodes = @state.discussions.map (discussion) =>
      <div key={ discussion.id } className="discussion">
        { discussion.title }
      </div>

    <div className="project">
      <h2>{ @props.project.name }</h2>
      { discussionNodes }
    </div>

module.exports = Project

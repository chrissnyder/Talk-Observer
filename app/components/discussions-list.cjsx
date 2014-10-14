# @cjsx React.DOM
React = require 'react'

Api = require 'zooniverse/lib/api'
Discussion = require './discussion'

DiscussionList = React.createClass
  displayName: 'DiscussionList'

  getInitialState: ->
    discussions: []

  componentDidMount: ->
    Api.current.get(@_url()).then (results) =>
      @setState discussions: results

  _url: ->
    "#{ Api.current.proxyFrame.host }/projects/#{ @props.project.name }/talk/following/discussions"

  render: ->
    discussionNodes = @state.discussions.map (discussion) =>
      <Discussion key={ discussion._id} data={ discussion } project={ @props.project } />

    <div className="discussions-list">
      { if discussionNodes.length > 0 then discussionNodes else 'No followed discussions' }
    </div>

module.exports = DiscussionList

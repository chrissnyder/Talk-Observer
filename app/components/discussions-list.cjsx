# @cjsx React.DOM
React = require 'react'
_ = require 'underscore'

Api = require 'zooniverse/lib/api'
Discussion = require './discussion'

DiscussionsList = React.createClass
  displayName: 'DiscussionsList'

  getInitialState: ->
    discussions: []
    renderedOnce: false

  componentDidMount: ->
    @loadDiscussions()

  loadDiscussions: ->
    Api.current.get(@_url()).then (rawDiscussions) =>
      if @state.renderedOnce
        newDiscussions = _.chain rawDiscussions
          .map (discussion) -> discussion.id
          .reject (discussionId) => discussionId in @_discussionIds()
          .value()

        for rawDiscussion in rawDiscussions
          rawDiscussion.isNew = true if rawDiscussion.id in newDiscussions

      @setState discussions: rawDiscussions, renderedOnce: true

  _url: ->
    "#{ Api.current.proxyFrame.host }/projects/#{ @props.project.name }/talk/following/discussions"

  _discussionIds: ->
    @state.discussions.map (discussion) ->
      discussion.id

  render: ->
    discussionNodes = @state.discussions.map (discussion) =>
      <Discussion key={ discussion.id } data={ discussion } project={ @props.project } isNew={ discussion.isNew } />

    <div className="discussions-list">
      <div className="refresh" onClick={ @loadDiscussions }>Manual Refresh</div>
      { if discussionNodes.length > 0 then discussionNodes else 'No followed discussions' }
    </div>

module.exports = DiscussionsList

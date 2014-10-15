# @cjsx React.DOM
React = require 'react/addons'
{ classSet } = React.addons

Discussion = React.createClass
  displayName: 'Discussion'

  getInitialState: ->
    changed: @props.isNew || (@props.data.last_comment._id is localStorage.getItem @props.data.zooniverse_id)

  componentWillReceiveProps: (nextProps) ->
    @setState changed: nextProps.data.last_comment._id != @props.data.last_comment._id

  onClick: ->
    localStorage.setItem @props.data.zooniverse_id, @props.data.last_comment._id
    @setState changed: false

  _url: ->
    "http://#{ @props.project.url }/#/boards/#{ @props.data.board._id }/discussions/#{ @props.data.zooniverse_id }"

  render: ->
    classes = classSet
      'discussion': true
      'changed': @state.changed

    <div className={ classes } onClick={ @onClick }>
      <a href={ @_url() } target="_blank">{ @props.data.title }</a><br />
      <div className="user-and-time">{ @props.data.last_comment.user_name } at { @props.data.last_comment.updated_at }</div>
    </div>

module.exports = Discussion

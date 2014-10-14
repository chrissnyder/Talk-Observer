# @cjsx React.DOM
React = require 'react/addons'
{ classSet } = React.addons

Discussion = React.createClass
  displayName: 'Discussion'

  getInitialState: ->
    changed: false

  componentWillReceiveProps: (nextProps) ->
    @setState changed: nextProps.data.last_comment is @props.data.last_comment

  _url: ->
    "http://#{ @props.project.url }/#/boards/#{ @props.data.board._id }/discussions/#{ @props.data.zooniverse_id }"

  render: ->
    classes = classSet
      'discussion': true
      'changed': @state.changed

    <div className={ classes }>
      <a href={ @_url() }>{ @props.data.title }</a><br />
      <div className="user-and-time">{ @props.data.last_comment.user_name } at { @props.data.last_comment.updated_at }</div>
    </div>

module.exports = Discussion

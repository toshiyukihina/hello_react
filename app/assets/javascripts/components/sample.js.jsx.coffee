$ ->

  converter = new Showdown.converter()
  
  CommentBox = React.createClass
  
    loadCommentsFromServer: ->
      $.ajax
        url: @props.url
        dataType: 'json'
      .done (data) =>
        @setState(data: data)
      .fail (xhr, status, err) =>
        console.error "url=#{@props.url}, status=#{status}:#{err.toString()}"

    getInitialState: ->
      data: []

    componentDidMount: ->
      @loadCommentsFromServer()
      setInterval @loadCommentsFromServer, @props.pollInterval
      
    render: ->
      `<div className="CommentBox">
        <h1>Comment</h1>
        <CommentList data={this.state.data} />
        <CommentForm />
       </div>`

  CommentList = React.createClass
    render: ->
      commentNodes = @props.data.map (comment) ->
        `<Comment author={comment.author}>{comment.text}</Comment>`
      `<div className="commentList">{commentNodes}</div>`

  CommentForm = React.createClass
    render: ->
      `<div className="commentForm">
        Hello world! I am a CommentForm
       </div>`

  Comment = React.createClass
    render: ->
      rawMarkup = converter.makeHtml @props.children.toString()
      `<div className="comment">
        <h2 className="commentAuthor">{this.props.author}</h2>
        <span dangerouslySetInnerHTML={{__html: rawMarkup}}></span>
      </div>`
        
  ReactDOM.render(
    `<CommentBox url="/api/comments" pollInterval={2000} />`,
    $('#content')[0]
  )

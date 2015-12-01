$ ->

  converter = new Showdown.converter()
  
  CommentBox = React.createClass
    render: ->
      `<div className="CommentBox">
        <h1>Comment</h1>
        <CommentList data={this.props.data} />
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
        
  data = [
    {author: 'Pete Hunt', text: 'This is one comment.'}
    {author: 'Jorden Walke', text: 'This is *author* comment.'}
  ]

  ReactDOM.render(
    `<CommentBox data={data} />`,
    $('#content')[0]
  )

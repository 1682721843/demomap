class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @demo = Demo.find(params[:demo_id]) # integrate order by created!
    @comments = policy_scope(@demo.comments).order(created_at: :desc) # integrate order by created!
    @event_comments = @demo.events.map do |event|
      @comments += event.comments
    end
    @comments.sort_by(&:created_at).reverse!

### Order the comments per weighted_score. Weighted_score method comes from the gem act_as_votable ###
    @votes_comments = Comment.all.sort_by{ |a| a.weighted_score}.reverse
### End of comment ###
  end

  def new
    @comment = Comment.new
    authorize @comment
    @demo = Demo.find(params[:demo_id])
    @event = Event.find(params[:event_id]) unless params[:event_id].nil?
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @demo = Demo.find(params[:demo_id])
    @comment.user = current_user
    save_comment(@demo, @comment)
  end


  def update
    @comment = Comment.find(params[:id])# integrate order by created!
    authorize @comment
    case params[:comment][:vote]
    when 'up' then @comment.vote_by :voter => current_user, :vote => 'up'
    when 'down' then @comment.vote_by :voter => current_user, :vote => 'down'
    end

    respond_to do |format|
      format.html {redirect_to demos_path(Demo.find(params[:demo_id]))}
      format.js  # <-- will render `app/views/comments/update.js.erb`
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def save_comment(demo, comment)
    if params[:event_id].nil?
      @comment.commentable = @demo
      if @comment.save
        redirect_to demo_comments_path(@demo)
      else
        render :new
      end
    else
      @event = Event.find(params[:event_id])
      @comment.commentable = @event
      if @comment.save
        redirect_to demo_event_path(@demo, @event)
      else
        render :new
      end
    end
  end

end

class CommentsChannel < ApplicationCable::Channel
  def self.broadcast(comment)
    broadcast_to comment.post, comment:
      CommentsController.render(partial: 'comments/comment', locals: { comment: comment })
  end

  def subscribed
    # Only subscribe the last post for the demo!
    stream_for Post.last 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

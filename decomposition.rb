class Chess
  # has play loop
  def initialize(player1, player2)
  end
end

class HumanPlayer
end

class Board
end

class Piece
  # position
end

class Pawn < Piece
  # specific pieces have their own moves
  # can calculate all possible next moves
end

class Rook < Piece
end

class Bishop < Piece
end

class Knight < Piece
end

class King < Piece
end

class Queen < Piece
end

class MoveNode
  #used to build move tree to caclulate check/mate
end

###########################################

class Monopoly
  #play loop
end

class Board
  # keeps track of pieces & property
end

class Property
  # keeps track of bought/mortgage status
end

class Deck
  # community chest / chance
end

class Piece
  # keeps track of position
end

class Player
  #keeps track of owned property/money/piece.
end

class Bank
  # keeps track of transactions
end

class Jail
  # has different rules regarding next turn
end

class Tile
  # keeps track of properties or rules associated with a space
end

###########################################################
class Forum
  # can register new users
  # keeps track of users and subforums
end

class SubForum
  # has permissions
  # keeps track of threads
end

class User
  # has permissions
  # can post with sufficient permissions
  # has profile with user information
  # keeps track of posts
  # can delete own posts
end

class Mod < User
  # can promote other users to Mod
  # can delete posts on forums and subforums
  # can ban users
end

class Thread
  # tracks first post
  # keeps track of posts in a thread
end

class Post
  # contains information
  # knows parent posts and author
end

class Sticky < Thread
  # will always be at the top of a sub-forum
end

#############################################################
class Twitter
  # keeps track of users
end

class User
  # sets sharing permissions
  # keeps track of tweets
  # keeps track of followers/following
end

class Tweet
  # contains information
  # has permissions
end

class DirectMessage < Tweet
  # contains private message
end

class Retweet < Tweet
  # broadcasts a tweet
end







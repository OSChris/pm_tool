class Vote < ActiveRecord::Base

  belongs_to :project

  def up
    self.upvotes += 1
    self.save
  end

  def down
    self.downvotes += 1
    self.save
  end

  def score
    self.upvotes - self.downvotes
  end

end

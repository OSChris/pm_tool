class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  has_one :vote

  has_many :tasks
  has_many :discussions

  

  private

  def self.search(search)
    if search
      joins(:vote).where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"]).order("(votes.upvotes - votes.downvotes) DESC")
    else
      all.joins(:vote).order("(votes.upvotes - votes.downvotes) DESC")
    end
  end

end

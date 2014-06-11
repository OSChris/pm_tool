class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  has_one :vote

  has_many :tasks
  has_many :discussions

  has_many :project_members, dependent: :destroy
  has_many :users, through: :project_members

  belongs_to :user

  def project_member?(user)
    project_members.exists?(user: user)
  end


  private

  def self.search(search)
    if search
      joins(:vote).where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"]).order("(votes.upvotes - votes.downvotes) DESC")
    else
      all.joins(:vote).order("(votes.upvotes - votes.downvotes) DESC")
    end
  end

end

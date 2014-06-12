class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  has_one :vote, dependent: :destroy

  has_many :tasks
  has_many :discussions

  has_many :project_members, dependent: :destroy
  has_many :users, through: :project_members

  has_many :favorites, dependent: :destroy
  has_many :users_favorited, through: :favorites, source: :user

  has_many :taggers, dependent: :destroy
  has_many :tags, through: :taggers

  belongs_to :user

  def project_member?(user)
    project_members.exists?(user: user)
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end


  private

  def self.search(search)
    if search
      search = "%#{search}%"
      includes(:tags).
      references(:tags).
      where('projects.title ILIKE ? OR projects.description ILIKE ? OR tags.name ILIKE ?',
        search, search, search).
      distinct('projects.id').
      order("projects.updated_at DESC")
    else
      all.order("updated_at DESC")
    end
  end

end

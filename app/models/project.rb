class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true

  

  private

  def self.search(search)
    if search
      where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

end

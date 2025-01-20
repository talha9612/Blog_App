class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :title, presence: { message: "Title can't be blank" }, length: { maximum: 255 }
  validates :content, presence: true
  validate :title_must_be_capitalized
  before_save :generate_slug
  before_destroy :check_if_published
  around_save :log_and_cleanup
  # before_save :check_title_change
  after_save :check_for_title_change
  private
  def log_and_cleanup
    Rails.logger.info("Saving Post: #{self.title}")
    yield
    Rails.logger.info("Post saved successfully!")
    remove_temp_tags if saved_changes.include?("tags")
  end
  def remove_temp_tags
    self.tags.delete(Tag.find_by(title: "Temporary"))
  end
  def title_must_be_capitalized
    errors.add(:title, "must start with a capital letter") unless title.match?(/\A[A-Z]/)
  end

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def check_if_published
    if published == true
      errors.add(:base, "Cannot delete a published post.")
      throw(:abort)
    end
  end

  # def check_title_change
  #   if title_changed?
  #     Rails.logger.info("Old title: #{previous_changes['title'].first}")
  #   end
  # end
  def check_for_title_change
    if saved_changes.key?("title")
        old_value, new_value = saved_changes["title"]
        Rails.logger.info("Title changed from '#{old_value}' to '#{new_value}'")
    else
        Rails.logger.info("Title was not changed")
    end
  end
end
# after_save :notify_users, if: :saved_change_to_status?


# def notify_users
#   if status == "published"
#     User.all.each do |user|
#       NotificationMailer.new_post_email(user, self).deliver_later
#     end
#   end
# end

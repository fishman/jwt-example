class User < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_save :sanitize_name

  private
    def sanitize_name
      self.name = sanitize(self.name)
    end
end

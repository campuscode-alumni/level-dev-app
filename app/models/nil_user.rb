# frozen_string_literal: true

class NilUser
  def admin?     = false
  def user?      = false
  def persisted? = false
  def email      = ''
  def !          = true
end

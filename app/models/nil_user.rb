# frozen_string_literal: true

class NilUser
  def admin?     = false
  def user?      = false
  def subsidiary = nil
  def email      = nil
  def persisted? = false
  def !          = true
end

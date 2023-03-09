# frozen_string_literal: true

module Command
  module ClassMethods
    def call(*args, **kwargs)
      new(*args, **kwargs).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call(*args, **kwargs)
    raise NotImplementedError unless defined?(super)

    super
    @called = true
    self
  end

  def success?
    called? && errors.blank?
  end

  def failure?
    !success?
  end

  def errors
    @errors ||= []
  end

  private

  def called?
    @called
  end
end

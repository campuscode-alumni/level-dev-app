# frozen_string_literal: true

module Command
  module ClassMethods
    def call(...)
      new(...).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call(*args, **kwargs)
    raise NotImplementedError unless defined?(super)

    super
    @result = true
    self
  end

  def success?
    !failure?
  end

  def failure?
    called? && errors.any?
  end

  def errors
    @errors ||= []
  end

  private

  def called?
    @result.present?
  end
end

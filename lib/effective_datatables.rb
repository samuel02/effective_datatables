require 'simple_form'
require 'effective_resources'
require 'effective_datatables/engine'
require 'effective_datatables/version'

module EffectiveDatatables
  mattr_accessor :authorization_method

  mattr_accessor :default_length
  mattr_accessor :html_class

  mattr_accessor :actions_column # A Hash
  mattr_accessor :debug

  def self.setup
    yield self
  end

  def self.authorized?(controller, action, resource)
    if authorization_method.respond_to?(:call) || authorization_method.kind_of?(Symbol)
      raise Effective::AccessDenied.new() unless (controller || self).instance_exec(controller, action, resource, &authorization_method)
    end
    true
  end

end

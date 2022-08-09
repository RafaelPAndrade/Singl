# frozen_string_literal: true

module Singl
  VERSION = "0.0.1"
  class Error < StandardError; end

  def self.ify!(klass)
    klass.instance_methods
         .map { |m| klass.instance_method m }
         .filter { |m| m.arity.zero? and m.owner == klass }
         .each do |m|
      klass.define_singleton_method(m.name) do |*args|
        l = ->(selv, *inargs) { m.bind_call(selv, *inargs) }

        return l if args.empty?

        l.call(*args)
      end
    end
    klass
  end

  def self.method_missing(name, *args)
    l = ->(selv, *inargs) { selv.send(name, *inargs) }

    return l if args.empty?

    l.call(*args)
  end

  def self.respond_to_missing?(*)
    true
  end

  def self.included(mod)
    ify!(mod) if mod.is_a? Class
  end
end

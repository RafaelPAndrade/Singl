# frozen_string_literal: true

# Instance to singleton method converter
module Singl
  VERSION = "0.0.1"
  class Error < StandardError; end

  # Converts all the instance methods of the given class into
  # singleton methods that get the intended receiver as the first argument
  # If called with no arguments, returns a lambda that can be called with the intended receiver
  #
  # = Example
  #   >> Singl.ify! Integer
  #   >> Integer.even? 4
  #   => true
  #   >> Integer.even?
  #   => #<Proc:0x000057f0877ba488 (lambda)>
  #   >> Integer.even?.call 4
  #   => true
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

  # Creates a lambda that sends the method to the first argument given
  # If no arguments are given, then the lambda is returned
  def self.method_missing(name, *args)
    l = ->(selv, *inargs) { selv.send(name, *inargs) }

    return l if args.empty?

    l.call(*args)
  end

  def self.respond_to_missing?(*)
    true
  end

  # Automatically apply Singl.ify! when used as a mixin in a class
  def self.included(mod)
    ify!(mod) if mod.is_a? Class
  end
end

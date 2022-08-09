# frozen_string_literal: true

RSpec.shared_examples "an instance->singleton method transformer" do
  it "creates singleton methods from simple instance methods" do
    expect(klass.singleton_methods).to include(:c)
  end

  it "creates singleton methods from attr_reader methods" do
    expect(klass.singleton_methods).to include(:b)
  end

  it "does not create attr_writer methods" do
    expect(klass.singleton_methods).not_to include(:b=)
  end

  it "does not include the Singl methods" do
    expect(klass.singleton_methods).not_to include(:ify!)
  end
end

RSpec.describe Singl do
  it "has a version number" do
    expect(Singl::VERSION).not_to be nil
  end

  context "#ify!" do
    it_behaves_like "an instance->singleton method transformer" do
      let(:klass) { Singl.ify!(A.clone) }
    end
  end

  context "include" do
    it_behaves_like "an instance->singleton method transformer" do
      let(:klass) { A.clone.include(Singl) }
    end
  end
end

class A
  attr_accessor :b

  def new
    @b = 1
  end

  def c
    b == 1
  end

  def d
    b.even?
  end
end

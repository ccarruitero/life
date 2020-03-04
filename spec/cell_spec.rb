require "spec_helper"

RSpec.describe Life::Cell do
 let(:subject) { described_class.new({ alive: true, row: 3, column: 5 }) }

  it "has access to properties" do
    expect(subject.alive).to eq(true)
    expect(subject.row).to eq(3)
    expect(subject.column).to eq(5)
  end

  it "cant update properties directly" do
    expect(subject.respond_to?(:alive=)).to eq(false)
    expect(subject.respond_to?(:row=)).to eq(false)
    expect(subject.respond_to?(:column=)).to eq(false)
  end

  it "#die turn alive to false" do
    subject.die
    expect(subject.alive).to eq(false)
  end

  it "#live turn alive to true" do
    subject.die
    subject.live
    expect(subject.alive).to eq(true)
  end
end

require 'spec_helper'

describe HelloSign::Resource::BaseResource do
  let(:data){{
        :a => :a1,
        :b => :b1,
        :c => { :c1 => :c2},
        :d => [ :d1, :d2, :d3],
        :e => [ {:e1 => :e11}, {:e2 => :e21}, {:e3 => :e31}]
      }}

  describe "methods" do
    subject(:resource) {HelloSign::Resource::BaseResource.new data }

    it 'can access attributes by calling method with the same name' do
      data.keys.each do |key|
        expect(resource.send key).not_to be_empty
      end
    end

    it 'make a hash value into a new HelloSign::Resource::BaseResource' do
      expect(resource.c).to be_an HelloSign::Resource::BaseResource
    end

    it 'do not touch array value with basic type' do
      expect(resource.d).to eql(data[:d])
    end

    it 'make a array value with each item is a hash into array of HelloSign::Resource::BaseResource' do
      expect(resource.e).to be_an Array
      expect(resource.e[0]).to be_an HelloSign::Resource::BaseResource
    end
  end

  describe "#initialize" do
    context 'without key params' do
      subject(:resource) {HelloSign::Resource::BaseResource.new data }
      it "have correct data" do
        expect(resource.data).to eql(data)
      end
    end

    context 'without key params' do
      subject(:resource) {HelloSign::Resource::BaseResource.new data, :e }
      it "have correct data" do
        expect(resource.data).to eql(data[:e])
      end
    end
  end
end

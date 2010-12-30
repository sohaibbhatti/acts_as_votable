require 'acts_as_votable'
require 'spec_helper'

describe ActsAsVotable::Alias do

  before(:each) do
    clean_database
  end

  describe "votable models" do

    before(:each) do
      clean_database
      @votable = Votable.new(:name => 'votable with aliases')
      @votable.save

      @voter = Voter.new(:name => 'a voter')
      @voter.save
    end

    it "should alias a bunch of functions" do
      @votable.respond_to?(:upvotes).should be true
      @votable.respond_to?(:ups).should be true
      @votable.respond_to?(:dislikes).should be true
    end

    it "should only alias voting words that are strings" do
      @votable.respond_to?('1s'.to_sym).should be false
      @votable.respond_to?('1d_by'.to_sym).should be false
    end

    it "should add callable functions" do
      @votable.vote :voter => @voter
      @votable.likes.should == 1
    end
  end

  describe "voter models" do

    before(:each) do
      clean_database
      @votable = Votable.new(:name => 'a votable')
      @votable.save

      @voter = Voter.new(:name => 'a voter with aliases')
      @voter.save
    end

    it "should alias a bunch of functions" do
      @voter.respond_to?(:upvotes).should be true
      @voter.respond_to?(:ups).should be true
      @voter.respond_to?(:dislikes).should be true
    end

    it "should only alias voting words that are strings" do
      @voter.respond_to?('1s'.to_sym).should be false
    end

    it "should add callable functions" do
      @voter.likes @votable
      @votable.likes.should == 1
    end
  end



end

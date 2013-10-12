require 'spec_helper'

describe Octonaut::Printers::Base do

  before do
    @data = [{
      :name => "Bob Wiley",
      :email => "bob@example.com",
      :hometown => "New York, NY"
    },
    {
      :name => "Dr. Leo Marvin",
      :email => "leo@example.com",
      :hometown => "Lake Winnipesaukee, NH"
    }]

    @printer = Octonaut::Printers::Base.new
  end

  describe ".table" do
    it "prints a table" do
      table = <<-EOS
    NAME Bob Wiley
   EMAIL bob@example.com
HOMETOWN New York, NY
EOS
      @printer.table(@data.first)
      output = $stdout.string
      expect(output).to eq(table)
    end
  end

  describe ".ls" do
    it "lists items" do
      listing = <<-EOS
Bob Wiley
Dr. Leo Marvin
EOS
      @printer.ls(@data)
      output = $stdout.string
      expect(output).to eq(listing)
    end
  end

  describe ".csv" do
    it "outputs csv data" do
      csv = <<-EOS
NAME,EMAIL,HOMETOWN
Bob Wiley,bob@example.com,"New York, NY"
Dr. Leo Marvin,leo@example.com,"Lake Winnipesaukee, NH"
EOS
      @printer.csv(@data)
      output = $stdout.string
      expect(output).to eq(csv)
    end
  end

end

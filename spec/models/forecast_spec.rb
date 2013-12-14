require 'spec_helper'

describe Forecast do
  it { should validate_presence_of :location }
end

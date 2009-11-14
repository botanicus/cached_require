require_relative "../lib/cached_require"

describe Loader do
  before(:each) do
    @loader = Loader.new
  end
  
  describe "#find" do
    it "should found full path to ...." do
      @loader.find("yaml")
    end
  end
  
  describe "#[]" do
  end
  
  describe "#require" do
  end
  
  describe "#load" do
  end
  
  describe "#reload" do
  end
end

describe "$LOAD_PATH" do
  describe "#[]=" do
  end
  
  describe "#push" do
  end
  
  describe "#unshift" do
  end
  
  describe "#shift" do
  end
  
  describe "#pop" do
  end
  
  describe "#insert" do
  end
  
  describe "#reverse!" do
  end
  
  describe "#replace" do
  end
  
  describe "#sort!" do
  end
  
  describe "#collect!" do
  end
  
  describe "#map!" do
  end
  
  describe "#delete" do
  end
  
  describe "#delete_at" do
  end
  
  describe "#delete_if" do
  end
  
  describe "#uniq!" do
  end
  
  describe "#compact!" do
  end
  
  describe "#flatten!" do
  end
  
  describe "#shuffle!" do
  end
end

describe "$LOADER" do
end

describe Kernel do
  describe "#require" do
  end
  
  describe "#__require__" do
  end
  
  describe "#require" do
  end
end

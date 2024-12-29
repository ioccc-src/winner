require "pp"

class Node
  def ==(other)
    self.class == other.class &&
      self.class::Keys.all? do |key| 
        instance_variable_get(:"@#{ key }") == other.send(key)
      end
  end

  attr_accessor :tmp

  def self.create(*keys)
    klass = Class.new(Node)
    klass.const_set(:Keys, keys)
    klass.class_eval do
      keys.each do |key|
        attr_reader key
      end
    end
    klass
  end

  def self.[](*values)
    new(*values)
  end

  def initialize(*values)
    self.class::Keys.zip(values) do |key, value|
      instance_variable_set(:"@#{ key }", value)
    end
  end

  def inspect
    "#{ self.class }[#{
      self.class::Keys.map do |key|
        instance_variable_get(:"@#{ key }").inspect
      end.join(", ")
    }]"
  end

  def pretty_print(q)
    q.group(2, "#{ self.class }[", "]") do
      q.seplist(
        self.class::Keys.map do |key|
          instance_variable_get(:"@#{ key }")
        end
      ) do |v|
        q.pp v
      end
    end
  end
end

PRead = Node.create(:var)
PImm = Node.create(:num)
PNop = Node.create

PBinary = Node.create(:op, :e1, :e2)
PIfThenElse = Node.create(:cond, :e1, :e2)

PRShift = Node.create(:val, :shift)
PARef = Node.create(:e1, :e2) # e1[e2]
PSRef = Node.create(:e)
PIRef = Node.create(:e)

PSequence = Node.create(:seq, :e)

PASet = Node.create(:e1, :e2, :e3) # e1[e2] = e3
PAssign = Node.create(:var, :exp)
PLoop = Node.create(:cond, :body)
PExit = Node.create(:e)
POut = Node.create(:e)
PTest = Node.create(:e)

IRead = Node.create(:var)
IWrite = Node.create(:var)
IInc = Node.create(:var)
IDec = Node.create(:var)
INop = Node.create
IPush = Node.create(:num)
IBinary = Node.create(:op)
IARef = Node.create
IASet = Node.create
IExit = Node.create
IOut = Node.create
ITest = Node.create
IBranch = Node.create(:s1, :s2)
ILoop = Node.create(:s1, :s2)

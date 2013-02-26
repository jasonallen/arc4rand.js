Arc4Rand = require './../lib/arc4rand'

describe 'Arc4Rand', ->

  it 'should generate a valid number', ->
    r = new Arc4Rand("a seed")
    n = r.random()
    n.should.be.within(0,1)

  it 'probably shouldnt generate the same number twice in a row', ->
    r = new Arc4Rand('the seed')
    n = r.random()
    n2 = r.random()
    n.should.not.equal(n2)

  it 'should validate a valid ranged number', ->
    r = new Arc4Rand('the seed')
    for i in [0..9]
      r.random(5, 10).should.be.within(5, 10)

  it 'should return valid ranged Int', ->
    r = new Arc4Rand('the seed')
    for i in [0..9]
      int = r.randomInt(5, 10)
      int.should.be.within(5, 10)
      Math.floor(int).should.eql(int)

  it 'should generate the same random sequence given the same seed', ->
    rngA = new Arc4Rand('seed')
    aNumbers = (rngA.random() for i in [0...100])
    rngB = new Arc4Rand('seed')
    bNumbers = (rngB.random() for i in [0...100])
    aNumbers.should.eql(bNumbers)

  it 'should not generate the same random sequence given different seeds', ->
    rngA = new Arc4Rand('seedA')
    rngB = new Arc4Rand('seedB')
    for i in [0...100]
      a = rngA.random()
      b = rngB.random()
      a.should.not.equal(b)

  describe 'over a series of repeated calls', ->
    rng = new Arc4Rand('seedA')
    total = 0
    low = 1
    high = 0
    for i in [0...100]
      r = rng.random()
      low = r if r < low
      high = r if r > high
      total += r

    it 'should tend to average 0.5 over time', ->
      average = total / 100
      average.should.be.within(0.45, 0.55)

    it 'should have seen a fairly low number', ->
      low.should.be.within(0, 0.05)

    it 'should have seen a fairly high number', ->
      high.should.be.within(0.95, 1)


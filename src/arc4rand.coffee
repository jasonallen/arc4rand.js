###
A seedable random number generator based on the arc4 algorithm. I based this
implementation on the pseudocode found here:
http://en.wikipedia.org/wiki/RC4#The_pseudo-random_generation_algorithm_.28PRGA.29

I used closures instead of of class to avoid the endless "this.<foo>"
references this would have required.
###
generateKeystream = (seed) ->
  seedLength = seed.length
  seedArray = (c for c in seed).map (c) -> c.charCodeAt(0)
  keystream = (i for i in [0...256])
  j = 0
  for i in [0...256]
    j = (j + keystream[i] + seedArray[i % seedLength]) % 256
    # swap keystream[i] and keystream[j]
    swap = keystream[i]
    keystream[i] = keystream[j]
    keystream[j] = swap
  keystream
  
Arc4Rand = (seed = "seed") ->
  keystream = generateKeystream(seed)
  i = 0
  j = 0

  randomByte = ->
    i = (i + 1) % 256
    j = (j + keystream[i]) % 256
    # swap keystream[i] and keystream[j]
    swap = keystream[i]
    keystream[i] = keystream[j]
    keystream[j] = swap

    index = (keystream[i] + keystream[j]) % 256
    keystream[index]

  @random = (min = 0, max = 1) ->
    number =
      randomByte() * 1 +
      randomByte() * 256 +
      randomByte() * 65536 +
      randomByte() * 16777216 +
      randomByte() * 4294967296 +
      randomByte() * 1099511627776 +
      randomByte() * 281474976710656 +
      randomByte() * 72057594037927940
    random = number / 18446744073709551616
    min + (max - min) * random

  @randomInt = (min, max) ->
    float = @random(min, max)
    Math.round(float)
  
  return @

module.exports = Arc4Rand

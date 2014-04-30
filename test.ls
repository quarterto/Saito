require! {
  cobbler: './lib'
  'karma-sinon-expect'.expect
}

σ = (s)-> from ([] ++ s), {+objectMode}

export
  'Cobbler':
    'should return the result of a task': ->
      r = {}
      t = cobbler -> a: -> r
      expect t.task \a .to.be r
    'should call dependencies with results': ->
      r = {}
      a = expect.sinon.stub!
      a.with-args \intermediate .returns r
      t = cobbler ->
        a: @dep \b a
        b: -> 'intermediate'
      expect t.task \a .to.be r
      expect a .to.be.called-with \intermediate
    'should return a list of dependency graph edges': ->
      t = cobbler ->
        a: @dep \b ->
        b: ->

      expect t.edges! .to.eql [[\a \b]]
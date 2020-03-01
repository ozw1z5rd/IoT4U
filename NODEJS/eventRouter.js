class EventRouter { 
  constructor(sink, source) {
    this.sink = sink
    this.source = source
  }
  

  run () { 
    this.source.connect()
    this.sink.connect()
    while (1) { 
       this.sink.write(this.source.read())
    }
  }
}

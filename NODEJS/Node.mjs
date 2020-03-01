
export default class Node {
  connect () {
    throw new Error('abstract')
  }
  disconnect () {
    throw new Error('abstract')
  }
  write (dictionary) {
    throw new Error('abstract')
  }
  read (dictionary) {
    throw new Error('abstract')
  }
  setPacker (f) {
    throw new Error('abstract')
  }
  setUnpacker (f) {
    throw new Error('abstract')
  }
}

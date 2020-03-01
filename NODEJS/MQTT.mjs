import Node from './Node.mjs'
import MqttClient from 'mqtt'

export default class MQTT extends Node {
  constructor (mqttConnection) {
    super(mqttConnection)
    this.mqttConnection = mqttConnection
  }
  _afterMessage (topic, message, packet) {
    this.message = this.unpacker(String.fromCharCode(...message))
  }
  _afterSubscription (err, granted) {
    if (!err) {
      this.client.on('message', (topic, message, packet) => this._afterMessage(topic, message, packet) )
    }
  }
  _afterConnect () {
    this.client.subscribe('#', (err, granted) => this._afterSubscription(err, granted))
  }
  connect () {
    this.client = MqttClient.connect(this.mqttConnection)
    this.client.on('connect', () => this._afterConnect())
  }
  setUpacker (f) {
    this.unpacker = f
  }
  disconnect () {
    this.client.disconnect()
  }
  read () {
    if (this.message) {
      let message = this.message
      this.message = undefined
      return this.unpacker(message)
    }
    return undefined
  }
}

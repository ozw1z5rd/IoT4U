import MQTT from './MQTT.mjs'
import MariaDB from './MariaDB.mjs'

let eventDatabase = {
  host: 'homebridge.local',
  port: 3306,
  user: 'mqtt',
  database: 'mqtt',
  password: 'mqtt_password'
}

let db = new MariaDB(eventDatabase)
db.connect()
console.log('connesso al database!!!')

let mqtt = new MQTT('mqtt://homebridge.local')
console.log('mqtt started')
mqtt.setUpacker(function(message) {console.log(message)})
console.log('unpacker set')
mqtt.connect()
console.log('connected!')

console.log('loop')

console.log('in teoria il programma dovrebbe terminare ora...')

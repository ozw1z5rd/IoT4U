const MYSQL_SERVER = {
    host: '127.0.0.1', 
    user: 'mqtt', 
    password: 'mqtt_password', 
    database: 'mqtt'
}

let counter = 0
let bigTotal = 0
let mqtt = require('mqtt') 
let mysql = require('mysql')
let db = null
console.log(MQTT_SERVER)

function mysqlRecordData (topic, message, payload) { 
    db.query('INSERT INTO event SET ?', {topic, payload})
    if (topic.includes('STATE') && topic.includes('tele/')) { 
        let r = JSON.parse(payload)
        id = payload.id
        time = r.Time
        uptime = r.Uptime
        uptimesec = r.UptimeSec
        vcc = r.Vcc
        heap = r.Heap
        sleepMode = r.SleepMode
        sleep = r.Sleep
        loadAvg = r.LoadAvg
        mqttCount = r.MqttCount
        power = r.POWER
        wifiAp = r.Wifi.AP
        wifiSSId = r.Wifi.SSId
        wifiBSSId = r.Wifi.BSSId
        wifiChannel = r.Wifi.Channel
        wifiRSSI = r.Wifi.RSSI
        wifiSignal = r.Wifi.Signal
        wifiLinkCount = r.Wifi.LinkCount 
        wifiDowntime = r.Wifi.Downtime
        db.query('INSERT INTO telemetry SET ?', { id, topic, time, uptime, uptimesec, vcc, 
            heap, sleepMode, sleep, loadAvg, mqttCount, power, wifiAp, wifiSSId, wifiBSSId, 
            wifiChannel, wifiRSSI, wifiSignal, wifiLinkCount, wifiDowntime
        })
    }
}

function mqttMessageReceived (topic, message, packet) {
    let payload = String.fromCharCode(...message)
    counter += 1
    bigTotal += 1
    mysqlRecordData(topic, message, payload)
    if (counter>25) {
        console.log(bigTotal, 'events and counting...')
	counter = 0
    }
}

function mqttAfterSubscribe (err, granted) { 
    if (!err) {
        console.log('MQTT subcription successful')
        mqttClient.on('message', mqttMessageReceived)
    }
    else { 
        console.log('subscription failed')
        throw err
    }
}

function init() { 
    console.log('connecting to MQTT server')
    let mqttClient = mqtt.connect('mqtt://homebridge.local')
    mqttClient.on('connect', () => { 
        console.log('connected')
        mqttClient.subscribe('#', mqttAfterSubscribe)
    })
     console.log('connecting to MYSQL server')
    db = mysql.createConnection(MYSQL_SERVER)
    db.connect()
} 

function main () { 
    init()
}

main() 


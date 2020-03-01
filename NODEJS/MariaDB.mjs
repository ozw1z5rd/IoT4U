import Node from './Node.mjs'
import mysqlClient from 'mysql'

export default class MariaDB extends Node {
  constructor( db ) {
    super(db)
    this.DSN = db
  }
  connect () {
    this.db = mysqlClient.createConnection(this.DSN)
    this.db.connect()
    this.db.query('SELECT 1')
  }

  disconnet () {
    this.db.disconnet()
  }

  setStore (f) {
    this.store = f
  }

  write (d) {
    this.store(d)
  }
}

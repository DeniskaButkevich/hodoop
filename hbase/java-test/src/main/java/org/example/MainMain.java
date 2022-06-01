package org.example;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.*;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;
import java.nio.file.Path;

public class MainMain {
    protected  static Connection conn;

    public static void main(String[] args) throws IOException {

        Connection conn = null;
        try {
            Configuration conf = HBaseConfiguration.create();
            conf.set("hbase.master", "hbase:60000");
            conf.set("hbase.zookeeper.quorum", "zookeeper");
            conf.set("hbase.zookeeper.property.clientPort", "2181"); //2181 is the default port
            conn = ConnectionFactory.createConnection(conf);
            Table table = null;
            try {
                table = conn.getTable(TableName.valueOf("tableName"));
                Get g = new Get(Bytes.toBytes("rowId"));
                Result result = table.get(g);
                byte [] name = result.getValue(Bytes.toBytes("columnType"),Bytes.toBytes("columnName"));
                System.out.println("name: " + Bytes.toString(name));
            } catch (TableNotFoundException tnfe) {
                throw new RuntimeException("HBase table not found.", tnfe);
            } catch (IOException ioe) {
                throw new RuntimeException("Cannot create connection to HBase.", ioe);
            }
            finally {
                if (table != null) {
                    try {
                        table.close();
                    } catch (IOException e) {
                        System.out.println(e);
                    }
                }
            }

        }
        finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (IOException e) {
                    System.out.println(e);
                }
            }
        }
    }
}
package org.example;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;

import java.io.IOException;


public class Main {
    protected  static Connection conn;

    public static void main(String[] args) throws IOException {
        System.out.println("Hello world!");

        Configuration config =  HBaseConfiguration.create();
        config.set("hbase.master.port", "60000");
        config.set("hbase.master", "172.19.0.5");
        config.set("hbase.zookeeper.quorum", "172.19.0.3");
        config.set("hbase.zookeeper.property.clientPort", "2181"); //2181 is the default port

        Connection connection = ConnectionFactory.createConnection(config);
        Admin admin = connection.getAdmin();


        // Instantiating table descriptor class
        HTableDescriptor tableDescriptor = new HTableDescriptor(TableName.valueOf("pepe"));

        // Adding column families to table descriptor
        tableDescriptor.addFamily(new HColumnDescriptor("personal"));
        tableDescriptor.addFamily(new HColumnDescriptor("professional"));

        // Execute the table through admin
        admin.createTable(tableDescriptor);
        System.out.println(" Table created ");
    }
}
import oracle.pg.common.*;
import oracle.pg.text.*;
import oracle.pg.rdbms.*;
import oracle.pgx.config.*;
import oracle.pgx.common.types.*;
import java.sql.*;

public class LoadToPG {
  public static void main(String[] args) throws Exception {
    Oracle oracle = new Oracle("jdbc:oracle:thin:@127.0.0.1:1521:orcl","carspec_pguser","oracle");
    OraclePropertyGraph opg = OraclePropertyGraph.getInstance(oracle, "carspec");
    opg.countVertices();
    opg.clearRepository();
    OraclePropertyGraphDataLoader opgdl = OraclePropertyGraphDataLoader.getInstance();
    String vfile = "../data.opv";
    String efile = "../data.ope";
    opgdl.loadData(opg, vfile, efile, 4/*dop*/);
    System.out.println("Total nodes: " + opg.countVertices());
    System.out.println("Total edges: " + opg.countEdges());
    opg.commit();
  }
}

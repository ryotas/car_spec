import oracle.pgx.api.*;
import oracle.pgx.config.*;

public class Test {
  public static void main(String[] args) throws Exception {
    ServerInstance instance = Pgx.getInstance("http://localhost:7007");
    PgxSession session = instance.createSession("my-session");
    GraphConfig config = GraphConfigFactory.forAnyFormat().fromPath("load_to_pgx.json");
    PgxGraph graph = session.readGraphWithProperties(config);
    System.out.println("Total nodes: " + graph.getNumVertices());
    System.out.println("Total edges: " + graph.getNumEdges());
  }
}

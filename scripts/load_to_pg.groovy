oracle = new Oracle("jdbc:oracle:thin:@127.0.0.1:1521:orcl","opg_user","oracle");
opg = OraclePropertyGraph.getInstance(oracle, "carspec");
opg.countVertices();
opg.clearRepository();
opgdl = OraclePropertyGraphDataLoader.getInstance();
vfile = "data.opv";
efile = "data.ope";
opgdl.loadData(opg, vfile, efile, 4/*dop*/);
opg.countVertices();
opg.countEdges();
opg.commit();

:exit

open util/integer
open lib/graph
open lib/properties

pred isSpanningTree(es : set Edge, graph : UGraph) {
	graph.vertices = (graph.vertices).(es.rels)
	es in graph.edges
	undirectedAcyclic[es, graph.vertices]
	connected[es, graph.vertices]     
}

pred isInterestingSpanningTree(es : set Edge, graph : UGraph) {
	isSpanningTree[es, graph]
	complete[graph.edges, Vertex]
}

fact noDuplicates {
	all disj g1, g2 : Graph |
		g1.edges != g2.edges
}

pred isMST(es : set Edge, graph : UGraph) {
	isInterestingSpanningTree[es, graph]
	no edgeSubset: set graph.edges {
		#edgeSubset = sub[#graph.vertices, 1]
        	connected[edgeSubset, graph.vertices]
        	gt[sumOfWeights[es], sumOfWeights[edgeSubset]]
	}
}

fun sumOfWeights(es : set Edge) : Int {
	sum edge : es | edge.weight
}

fact smallWeights {
	all e : Edge |
		e.weight < 11 and e.weight > 0
}

assert alwaysSomeMST {
	all g: UGraph | (connected[g.edges, Vertex] and some g.edges) implies
		 (some es: set Edge | isMST[es, g])
}
check alwaysSomeMST  for 5 Vertex,  1 Graph, 10 Edge, 10 Int

run isMST for 5 Vertex,  1 Graph, 10 Edge, 10 Int

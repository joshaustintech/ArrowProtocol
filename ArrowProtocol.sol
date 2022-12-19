//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

struct Arrow {
    uint128 id;      // id for searching purposes
    uint128 graphid; // parent graph
    string data;     // on-chain text or markup
    address owner;   // only the owner can modify this arrow and any below it, but not above
    bool isActive;   // website visibility and adding relationships are enabled if true
}

struct Relationship {
    uint128 sourceArrow;      // the arrow higher in the heirarchy
    uint128 destinationArrow; // the arrow lower in the hierarchy
}

struct Graph {
    uint128 id;  // id for searching purposes
    string name; // the title of the graph
}

contract ArrowProtocol {

    mapping(uint => Graph) graphs; // stores all the graphs on-chain
    uint128 graphCounter = 1;      // tracking the graph ID

    mapping(uint => Arrow) arrows; // stores all the arrows on-chain
    uint128 arrowCounter = 1;      // tracking the arrow ID

    mapping(uint => Relationship) relationships; // stores all the relationships between arrows on-chain
    uint128 relationshipCounter = 1;             // tracks the relationship ID

    /*
     * Creates a new graph and puts the initial Arrow in it
     * - <_graphName> corresponds to Graph.name
     * - <_initialArrow> corresponds to Arrow.data
     */
    function createGraph( string memory _graphName, string memory _initialArrow ) public returns ( Graph memory ) {

        Arrow memory arrow = Arrow(arrowCounter, graphCounter, _initialArrow, msg.sender, true);
        arrows[arrowCounter] = arrow;

        Graph memory graph = Graph(graphCounter, _graphName);
        graphs[graphCounter] = graph;

        arrowCounter++;
        graphCounter++;

        return graph;

    }


    /*
     * Returns the arrow data matching <arrowId>, if found
     */
    function findArrowByGraphAndArrowId( uint128 _arrowId ) public view returns( string memory ) {
        return arrows[_arrowId].data;
    }

    // TBD - defining arrow relationships, and returning an array notating the entire graph

}

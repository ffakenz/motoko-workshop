import List "mo:base/List";

module Actor {  
  public type State<S, E> = {
      value: S;
      events: List.List<E>;
  };
  
  public type StateOps<S, E, C> = {
      init: () -> State<S, E>;
      check: (C, State<S, E>) -> Bool; // check commands
      apply: (E, State<S, E>) -> State<S, E>; // apply events
  };
};
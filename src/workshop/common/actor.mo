import List "mo:base/List";

module Actor {
  public type State<S, E> = {
      entity: S;
      events: List.List<E>;
  };

  public func initState<S, E>(entity: S): State<S, E> {
    return {
      entity = entity;
      events = List.nil();
    };
  };
  
  public type StateOps<S, E, C> = {
      init: S -> State<S, E>;
      check: (State<S, E>, C) -> Bool; // check commands
      apply: (State<S, E>, E) -> State<S, E>; // apply events
      applyAll: (State<S, E>, List.List<E>) -> State<S, E>; // apply events
  };
};
export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const Command = IDL.Variant({
    'initCommand' : IDL.Record({ 'value' : IDL.Nat }),
  });
  const Event = IDL.Variant({
    'initEvent' : IDL.Record({ 'value' : IDL.Nat }),
  });
  List.fill(IDL.Opt(IDL.Tuple(Event, List)));
  const State = IDL.Record({ 'value' : IDL.Nat, 'events' : List });
  return IDL.Service({ 'action' : IDL.Func([Command], [IDL.Opt(State)], []) });
};
export const init = ({ IDL }) => { return []; };

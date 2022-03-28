export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const Entity = IDL.Nat;
  const Command = IDL.Variant({
    'initCommand' : IDL.Record({ 'value' : Entity }),
  });
  const Event = IDL.Variant({ 'initEvent' : IDL.Record({ 'value' : Entity }) });
  List.fill(IDL.Opt(IDL.Tuple(Event, List)));
  const State = IDL.Record({ 'value' : Entity, 'events' : List });
  return IDL.Service({ 'action' : IDL.Func([Command], [IDL.Opt(State)], []) });
};
export const init = ({ IDL }) => { return []; };

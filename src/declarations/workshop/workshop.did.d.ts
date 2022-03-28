import type { Principal } from '@dfinity/principal';
export type Command = { 'initCommand' : { 'value' : Entity } };
export type Entity = bigint;
export type Event = { 'initEvent' : { 'value' : Entity } };
export type List = [] | [[Event, List]];
export interface State { 'value' : Entity, 'events' : List }
export interface _SERVICE {
  'action' : (arg_0: Command) => Promise<[] | [State]>,
}

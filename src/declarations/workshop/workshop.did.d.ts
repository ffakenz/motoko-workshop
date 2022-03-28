import type { Principal } from '@dfinity/principal';
export type Command = { 'initCommand' : { 'value' : bigint } };
export type Event = { 'initEvent' : { 'value' : bigint } };
export type List = [] | [[Event, List]];
export interface State { 'value' : bigint, 'events' : List }
export interface _SERVICE {
  'action' : (arg_0: Command) => Promise<[] | [State]>,
}

-module(highorder).

-compile(export_all).

%1
% unzip([{A, B} | T]) ->
%     {AT, BT} = unzip(T), {[A | AT], [B | BT]};
% unzip([]) -> {[], []}.
unzip(L) ->
    {R, S} = lists:foldl(fun ({X, Y}, {A, B}) ->
				 {[X | A], [Y | B]}
			 end,
			 {[], []}, L),
    {lists:reverse(R), lists:reverse(S)}.

% 2
% in_rank(3, 5, lists:seq(1, 10)) -> [false,false,true,true,true,false,false,false,false,false]
in_rank(X, Y, Z) ->
    lists:map(fun (W) ->
		      if W >= X, W =< Y -> true;
			 true -> false
		      end
	      end,
	      Z).

rank(Start, End, List) ->
    lists:map(fun (E) -> Start =< E andalso E =< End end,
	      List).

% 3
% first([1,a,{1,2},{2},[{3},4],"ba", []]) -> [1,2,{3},98]
first(L) ->
    F = lists:filter(fun (W) when is_list(W) ->
			     length(W) > 0;
			 (W) when is_tuple(W) -> size(W) > 0;
			 (_) -> false
		     end,
		     L),
    lists:map(fun ([H | _]) -> H;
		  (T) -> element(1, T)
	      end,
	      F).

lk(_Key, []) -> not_found;
lk(Key, [{Key, Val} | _]) -> Val;
lk(Key, [_ | R]) -> lk(Key, R).

% 4
% keys([a,c],[{a,ok},{b,23},{d,"hi"}]) -> [ok,"hi"]
keysFold(X, Y) ->
    R = lists:foldl(fun (A, B) -> [lk(A, Y) | B] end, [],
		    X),
    lists:reverse(R).

keysMap(X, Y) -> lists:map(fun (A) -> lk(A, Y) end, X).
